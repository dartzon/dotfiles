;; ------------------------------------
;; Current line and region commenting.
;; ------------------------------------
(require 'evil-nerd-commenter)
;; ------------------------------------

;; ----------------------------------------------------------
;; Highlight characters that exceed the 100th column margin.
;; ----------------------------------------------------------
(setq column-enforce-column 100
      column-enforce-comments nil ;; Allowing long comments.
      )
;; ----------------------------------------------------------

;; ------------------------------
;; Show unnecessary white space.
;; -----------------------------
(setq whitespace-style (quote (face trailing)))
(setq whitespace-display-mappings
      '(
        (tab-mark 32 [183] [46])
        ))
;; ------------------------------

;; -------------------------------------------------------
;; Insert parens pairs automaticaly (), {}, [], "" etc...
;; -------------------------------------------------------
(require 'smartparens-config)
;; -------------------------------------------------------

;; ----------------------------------------------------------------------------
;; Saving or writing a file silently puts a newline at the end if there isn't
;; already one there.
;; ----------------------------------------------------------------------------
(setq require-final-newline t)
;; ------------------------------------------

;; --------------------------------------------------------
;; Display the function's name the cursor is currently in.
;; --------------------------------------------------------
(defadvice which-func-ff-hook (after header-line activate)
  (when which-function-mode
    (setq which-func-format (quote ("ƒ : " (:propertize which-func-current) "(...)"))
          header-line-format '((which-function-mode (" " which-func-format "")))
          which-func-unknown "n/a")
    ))
;; --------------------------------------------------------

;; ------------------------------------------------
;; Dynamic file templates insertion for new files.
;; The templates are stored in :
;; config/programming/filetemplates/
;; ------------------------------------------------
(setq file-template-insert-automatically t)
(setq file-template-search-current-dir nil)
(require 'file-template)

(add-to-list 'file-template-mapping-alist
             '("\\.js$" . "template.js"))

(add-hook 'find-file-not-found-hooks 'file-template-find-file-not-found-hook 'append)
;; ------------------------------------------------

;; #################################################################################################
;; Language specific configurations.
;; #################################################################################################

;; *************************************************************************************************
;; >> C and C-like (C++, Java, Objective C, CORBA IDL, etc.)
;; *************************************************************************************************
(require 'cc-mode)

;; ----------------------
;; Use Doxygen comments.
;; ----------------------
(require 'doxymacs)
(setq doxymacs-command-character "\\"
      doxymacs-doxygen-style "C++")
;; ----------------------

;; -------------------------------------------------------------------------------------
;; Automaticaly convert Emacs default styles to Artistic Style default styles (AStyle).
;; -------------------------------------------------------------------------------------
(require 'astyle-hooks)
(setq-default c-default-style "bsd"   ;; Use "bsd" style AKA Allman style.
              indent-namespaces "no"
              indent-classes "yes")
;; -------------------------------------------------------------------------------------

;; --------------------------------------
;; Automatic pairs for C style comments.
;; --------------------------------------
;; (sp-with-modes '(c-mode c++-mode java-mode js-mode)
;;   (sp-local-pair "/* " " */" :post-handlers '((" | " "SPC")
;;                                               ("* ||\n[i]" "RET")))
;;   )
(sp-with-modes '(c-mode c++-mode java-mode js-mode)
  (sp-local-pair "{" nil :post-handlers '(("||\n[i]" "RET"))))
(sp-local-pair 'c++-mode "/*" "*/" :post-handlers '((" | " "SPC")
                                                    ("* ||\n[i]" "RET")))
;; --------------------------------------

;; -----------------------------------
;; Code formating using clang-format.
;; -----------------------------------
(require 'clang-format)

(defun my-run-clang-format () (interactive)
       (save-excursion ;;< Save the point and restore it after the execution.
         (goto-line 1)
         (deactivate-mark)
         (if (search-forward user-mail-address)
             (clang-format-buffer)
           ))
       )

;; -----------------------------------

;; *************************************************************************************************

;; *************************************************************************************************
;; >> C/C++
;; *************************************************************************************************
(defun my-c-c++-config ()
  (require 'setup-dev-cpp)
  )
;; *************************************************************************************************

;; *************************************************************************************************
;; >> CMake
;; *************************************************************************************************
(autoload 'cmake-font-lock-activate "cmake-font-lock" nil t)
;; *************************************************************************************************

;; #################################################################################################

;; ---------------------------
;; General programming hooks.
;; ---------------------------
(add-hook 'prog-mode-hook (lambda ()
                            (smartparens-mode)
                            (doxymacs-mode)
                            (doxymacs-font-lock)
                            (column-enforce-mode)
                            (which-function-mode)
                            (rainbow-mode)
                            (whitespace-cleanup-mode)
                            (whitespace-mode)
                            ))
;; ---------------------------

;; ----------
;; CC hooks.
;; ----------
(add-hook 'c-mode-common-hook (lambda ()
                                (rainbow-turn-off)
                                (add-hook 'before-save-hook 'my-run-clang-format nil t)
                                ))
;; ----------

;; ----------
;; Js hooks.
;; ----------
(add-hook 'js-mode-hook (lambda ()
                          (add-hook 'before-save-hook 'my-run-clang-format nil t)
                          ))
;; ----------

;; -----------
;; C/C++ hooks.
;; -----------
(add-hook 'c-mode-hook (lambda ()
                         (my-c-c++-config)))
(add-hook 'c++-mode-hook (lambda ()
                           (my-c-c++-config)))
;; -----------

;; ------------
;; CMake hook.
;; ------------
(add-hook 'cmake-mode-hook 'cmake-font-lock-activate)
;; ------------

(provide 'setup-dev)
