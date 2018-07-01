;; -----------------------------------------
;; Custom garbage collection configuration.
;; -----------------------------------------
;; See http://bling.github.io/blog/2016/01/18/why-are-you-changing-gc-cons-threshold/
(defun mem-minibuffer-setup-hook ()
  (setq gc-cons-threshold most-positive-fixnum))
(defun mem-minibuffer-exit-hook ()
  (setq gc-cons-threshold 50000000))
(add-hook 'minibuffer-setup-hook #'mem-minibuffer-setup-hook)
(add-hook 'minibuffer-exit-hook #'mem-minibuffer-exit-hook)

;; Garbage collect when emacs is out of focus.
(add-hook 'focus-out-hook 'garbage-collect)
;; -----------------------------------------

;; --------------------------
;; Custom folders and files.
;; --------------------------
;; config/ is the folder  where all the lisp config files will be stored.
(add-to-list 'load-path (expand-file-name (concat user-emacs-directory "config/")))
(let ((default-directory (concat user-emacs-directory "config/")))
  (normal-top-level-add-subdirs-to-load-path))

;; Save emacs' custom variables in custom-vars.el instead of polluting init.el
(setq custom-file (concat user-emacs-directory "config/custom-vars.el"))

;; Folder for saving packages configs and tmp files.
(setq emacs-saves-directory (concat user-emacs-directory ".saves/"))
(unless (file-exists-p emacs-saves-directory)
  (make-directory emacs-saves-directory t))

(setq ido-save-directory-list-file (concat emacs-saves-directory "ido.last")
      recentf-save-file (concat emacs-saves-directory "recentf")
      smex-save-file (concat emacs-saves-directory "smex-items")
      projectile-cache-file (concat emacs-saves-directory "projectile.cache")
      projectile-known-projects-file (concat emacs-saves-directory "projectile-bookmarks.eld")
      auto-save-list-file-prefix (concat emacs-saves-directory "auto-save-list/.saves-")
      )

;; Folder where file templates are stored.
(setq-default file-template-paths
              `(,(concat user-emacs-directory "config/programming/filetemplates/")))

;; Folder where the irony server will be installed.
(setq irony-user-dir (concat user-emacs-directory "config/irony-server/"))
;; --------------------------

;; ---------------------------------------------------------------------------
;; Consider local variables as safe without asking each time we visit a file.
;; ---------------------------------------------------------------------------
(setq enable-local-variables :safe)
;; ---------------------------------------------------------------------------

;; ------------------------------------------
;; Package management using cask and pallet
;; ------------------------------------------
(require 'cask)
(cask-initialize)
(require 'pallet)
(pallet-mode t)
;; ------------------------------------------
