;;; gptel-magit.el --- Generate commit messages for magit using gptel -*- lexical-binding: t; -*-

;; Copyright (C) 2025 Authors
;; SPDX-License-Identifier: Apache-2.0

;; Author: Ragnar Dahlén <r.dahlen@gmail.com>
;; Version: 1.0
;; Package-Requires: ((emacs "28.1") (magit "4.0") (gptel "0.9.8"))
;; Keywords: vc, convenience
;; URL: https://github.com/ragnard/gptel-magit

;;; Commentary:

;; This package uses the gptel library to add LLM integration into
;; magit. Currently, it adds functionality for generating commit
;; messages.

;;; Code:

(require 'gptel)
(require 'magit)

(defun my/read-gitcommit-file-as-string (filename)
  "Read the entire contents of FILENAME into a string."
  (with-temp-buffer
    (insert-file-contents filename)
    (buffer-string)))

(defconst gptel-magit-prompt-conventional-commits
  (concat
   "You are tasked with generating a Git commit message that closely follows all the directives in the following git commit message template. Make sure you respect the character limits for the title and the body, also, keep the template content as is while inserting your generated commit messages in the right places:\n\n```"
   (with-temp-buffer
     (insert-file-contents "~/.config/git/gitcommitmsg.txt")
     (buffer-string))
   "```\n\nThe git diff output is:")
  "Prompt for generating a Git commit message using a template.")

(defcustom gptel-magit-commit-prompt
  gptel-magit-prompt-conventional-commits
  "The prompt to use for generating a commit message.
The prompt should consider that the input will be a diff of all
staged changes."
  :type 'string
  :group 'gptel-magit)

(defcustom gptel-magit-diff-explain-prompt
  "You are an expert at understanding and explaining code changes by reading diff output.
Your job is to write a short clear summary explanation of the changes."
  "The prompt to use for explaining diff changes.
The prompt should consider that the input will be a diff some changes."
  :type 'string
  :group 'gptel-magit)

(custom-declare-variable
 'gptel-magit-model nil
 "The gptel model to use, defaults to `gptel-model` if nil.

See `gptel-model` for documentation.

If set to a model that uses a different backend than
`gptel-backend`, also requires `gptel-magit-backend' to be set to
the correct backend."
 :type (get 'gptel-model 'custom-type)
 :group 'gptel-magit)

(custom-declare-variable
 'gptel-magit-backend nil
 "The gptel backend to use, defaults to `gptel-backend` if nil.

See `gptel-backend` for documentation."
 :type (get 'gptel-backend 'custom-type)
 :group 'gptel-magit)


(defun gptel-magit--format-commit-message (message)
  "Format commit message MESSAGE nicely."
  (with-temp-buffer
    (text-mode)
    (insert message)
    ;; (setq fill-column git-commit-summary-max-length)
    ;; (fill-region (point-min) (point-max))
    (buffer-string)))

(defun gptel-magit--request (&rest args)
  "Call `gptel-request` with ARGS.

Respects configured model/backend options."
  (declare (indent 1))
  (let* ((gptel-backend (or gptel-magit-backend gptel-backend))
         (gptel-model (or gptel-magit-model gptel-model)))
    (apply #'gptel-request args)))

(defun write-string-to-file (string filename)
  "Writes the given STRING to the specified FILENAME using UTF-8 encoding.
  Returns t if successful, nil otherwise."
  (with-temp-file filename
    (insert string)
    t))

(defun gptel-magit--generate (callback)
  "Generate a commit message for current magit repo.
Invokes CALLBACK with the generated message when done."
  (let ((diff (magit-git-output "diff" "--cached")))
    (gptel-magit--request diff
      :system gptel-magit-commit-prompt
      :context nil
      :callback (lambda (response _info)
                  (let ((msg (gptel-magit--format-commit-message response)))
                    (funcall callback msg))))))

(defun gptel-magit-generate-message ()
  "Generate a commit message when in the git commit buffer."
  (interactive)
  (unless (magit-commit-message-buffer)
    (user-error "No commit in progress"))
  (gptel-magit--generate (lambda (message)
                           (with-current-buffer (magit-commit-message-buffer)
                             (save-excursion
                               (goto-char (point-min))
                               (insert message)))))
  (message "magit-gptel: Generating commit message..."))

(defun gptel-magit-commit-generate (&optional args)
  "Create a new commit with a generated commit message.
Uses ARGS from transient mode."
  (interactive (list (magit-commit-arguments)))
  (gptel-magit--generate
   (lambda (message)
     (magit-commit-create (append args `("--message" ,message "--edit")))))
  (message "magit-gptel: Generating commit..."))

(defun gptel-magit--show-diff-explain (text)
  "Popup a buffer with diff explanation TEXT."
  (let ((buffer-name "*gptel-magit diff-explain*"))
    (when-let ((existing-buffer (get-buffer buffer-name)))
      (kill-buffer existing-buffer))
    (let ((buffer (get-buffer-create buffer-name)))
      (with-current-buffer buffer
        (insert text)
        (setq fill-column 72)
        (fill-region (point-min) (point-max))
        (markdown-view-mode)
        (goto-char (point-min)))
      (pop-to-buffer buffer))))

(defun gptel-magit--do-diff-request (diff)
  "Send request for an explanation of DIFF."
  (gptel-magit--request diff
    :system gptel-magit-diff-explain-prompt
    :context nil
    :callback (lambda (response _info)
                (gptel-magit--show-diff-explain response)))
  (message "magit-gptel: Explaining diff..."))

(defun gptel-magit-diff-explain ()
  "Ask for an explanation of diff at current section."
  (interactive)
  (when-let* ((section (magit-current-section))
              (start (oref section content))
              (end (oref section end))
              (content (buffer-substring start end)))
    (gptel-magit--do-diff-request content)))

;;;###autoload
(defun gptel-magit-install ()
  "Install gptel-magit functionality."
  (define-key git-commit-mode-map (kbd "M-g") 'gptel-magit-generate-message)
  (transient-append-suffix 'magit-commit #'magit-commit-create
    '("g" "Generate commit" gptel-magit-commit-generate))
  (transient-append-suffix 'magit-diff #'magit-stash-show
    '("x" "Explain" gptel-magit-diff-explain)))

(provide 'gptel-magit)
;;; gptel-magit.el ends here
