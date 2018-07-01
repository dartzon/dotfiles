;; ---------------------------------------
;; Suppress the scratch buffer's message.
;; ---------------------------------------
(setq initial-scratch-message nil)
;; ---------------------------------------

;; ------------------------
;; Highlight current line.
;; ------------------------
(global-hl-line-mode 1)
(set-face-background 'hl-line "#5A5A5A")
;; ------------------------

;; ---------------------------------------------------------------------------------
;; Anything that writes to the buffer while the region is active will overwrite it.
;; ---------------------------------------------------------------------------------
(delete-selection-mode 1)
;; ---------------------------------------------------------------------------------

;; -----------------
;; Tabs management.
;; -----------------
;; Tab = 4 spaces.
(setq-default tab-width 4)
;; Disable manual tabs.
(setq-default indent-tabs-mode nil)
;; -----------------

;; ------------------------------------------------
;; Put empty line markers into the left hand side.
;; ------------------------------------------------
(setq-default indicate-empty-lines t)
(when (not indicate-empty-lines)
  (toggle-indicate-empty-lines))
;; ------------------------------------------------

;; --------------------------------
;; Highlight matching parenthesis.
;; --------------------------------
(set-face-foreground 'show-paren-match "#BBDB00")
(set-face-foreground 'show-paren-mismatch "#F57900")
(set-face-attribute 'show-paren-match nil :weight 'extra-bold)
(show-paren-mode t)
;; --------------------------------

;; -----------------------------------------------
;; Highlight occurences of the symbol under point
;; in the current buffer.
;; -----------------------------------------------
(require 'highlight-symbol)
;; -----------------------------------------------

;; ---------------------------------------------------------
;; Visible, buffer local, bookmarks and the ability to jump
;; forward and backward to the next bookmark.
;; ---------------------------------------------------------
(require 'bm)
;; ---------------------------------------------------------

;; ---------------------------------------------------
;; Auto save all open buffers when Emacs loses focus.
;; ---------------------------------------------------
(add-hook 'focus-out-hook (lambda () (save-some-buffers t)))
;; ---------------------------------------------------

;; ----------------------------
;; Multiple cursors for Emacs.
;; ----------------------------
(require 'multiple-cursors)
;; ----------------------------

;; ------------------------------------------
;; Displays current match and total matches.
;; ------------------------------------------
(require 'anzu)
(global-anzu-mode +1)

(custom-set-variables
 '(anzu-deactivate-region t)
 '(anzu-search-threshold 1000))

;; Let spaceline handle Anzu's display.
(setq anzu-cons-mode-line-p nil)
;; ------------------------------------------

(provide 'setup-texteditor)
