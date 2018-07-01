;; --------------------------------------------------------------
;; Abbreviate some major-modes and minor-modes in the mode line.
;; --------------------------------------------------------------
(require 'dim)
(dim-major-names
 '((emacs-lisp-mode "elisp")
   (package-menu-mode "pkg")
   (sh-mode "sh")
   ))
(dim-minor-names
 '((abbrev-mode "")
   (page-break-lines-mode "")
   (isearch-mode "")
   (anzu-mode "")
   (zoom-mode "")
   (multiple-cursors-mode "")
   (flyspell-mode "")
   ))
(setq dim-everywhere 't)
;; --------------------------------------------------------------

;; Change "yes or no" to "y or n".
(fset 'yes-or-no-p 'y-or-n-p)

(provide 'setup-abbreviations)
