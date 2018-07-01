;; ---------------------
;; Remove visual noise.
;; ---------------------
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

;; Turn off mouse inteshellerface (Menu bar + tool bar + scroll bar).
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; Turn off dialog boxes.
(setq use-dialog-box nil)
;; Wait 1ms before echoing.
(setq echo-keystrokes 0.1)
;; Visible bell instead of bip noise.
(setq visible-bell t)

;; Disalbe blinking cursor.
(blink-cursor-mode -1)
;; ----------------------------------------------------

;; --------------------------------------------------------
;; Scroll one line at a time (less "jumpy" than defaults).
;; --------------------------------------------------------
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time
(setq scroll-conservatively 10000)
(setq scroll-preserve-screen-position t)
;; --------------------------------------------------------

;; ----------------------------------------------------
;; Use spaceline, a mode-line theme used by Spacemacs.
;; ----------------------------------------------------
(require 'spaceline-config)
(require 'spaceline-segments)

(setq powerline-default-separator 'slant)
(setq spaceline-workspace-numbers-unicode t)
(setq spaceline-separator-dir-left '(left . left))
(setq spaceline-separator-dir-right '(right . right))
(setq spaceline-highlight-face-func 'spaceline-highlight-face-modified)
(spaceline-toggle-projectile-root-on)
(spaceline-toggle-minor-modes-off)
(spaceline-toggle-which-function-off)

(spaceline-emacs-theme '((projectile-root)))
;; ----------------------------------------------------

;; ----------------------------------
;; Display line numbers on the left.
;; ----------------------------------
(global-nlinum-mode)
(setq nlinum-highlight-current-line t)

;; Precalculate the line number width to avoid horizontal jumps on scrolling.
(defun my-precalcul-nlinum ()
  (when nlinum-mode
    (setq-local nlinum-format
                (concat "%" (number-to-string
                             ;; Guesstimate number of buffer lines.
                             (ceiling (log (max 1 (/ (buffer-size) 80)) 10)))
                        "d "))))
(add-hook 'nlinum-mode-hook #'my-precalcul-nlinum)
;; ----------------------------------

;; --------------------------------------------
;; move point from window to window using Meta
;; and the arrow keys
;; --------------------------------------------
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings 'meta))
;; --------------------------------------------

;; -------------------------------------------------
;; Automatic windows resizing based on the content.
;; -------------------------------------------------
(zoom-mode t)

(setq zoom-size '(0.618 . 0.618) ;; Resize the selected window using the golden ratio.
      zoom-ignored-major-modes '(dashboard-mode)
      ;; zoom-ignored-buffer-names '("*dashboard*")
      ;; Don't resize any buffer containing less than 20 lines.
      ;; zoom-ignore-predicates '((lambda () (> (count-lines (point-min) (point-max)) 20)))
      )
;; ----------------------------------

;; ------------------------------------------------
;; Minibuffer smart-completion using ido and smex.
;; ------------------------------------------------
(require 'ido)
(ido-mode t)
(ido-everywhere 1)

(require 'ido-completing-read+)
(ido-ubiquitous-mode 1)

(require 'smex)
(smex-initialize)
;; ------------------------------------------------

;; -------------------------------
;; Set and customize emacs theme.
;; -------------------------------
(load-theme 'zenburn t)

(custom-theme-set-faces
 'zenburn
 '(default ((t (:family "Inconsolata"
                        :foundry "PfEd"
                        :slant normal
                        :weight normal
                        :height 120
                        :width normal))))

 '(linum ((t (:foreground "dark gray"
                          :background "#3F3F3F"))))

 '(nlinum-current-line ((t (:inherit linum
                                     :foreground "gold"
                                     :weight bold))))

 '(mode-line ((t (:background "#2B2B2B"
                              :family "Liberation Mono"
                              :foreground "#DCDCCC"
                              :weight normal
                              :height 120
                              :width normal))))

 '(mode-line-buffer-id ((t (:foreground "#DCDCCC"
                                        :weight bold))))

 '(mode-line-inactive ((t (:inherit mode-line
                                    :foreground "#DCDCCC"
                                    :height 120))))

 '(header-line ((t (:background "#2B2B2B"
                                :family "Liberation Mono"
                                :foreground "dark gray"
                                :weight bold
                                :height 120
                                :width normal))))

 '(anzu-mode-line ((t (:foreground "gold"
                                   :weight bold))))

 '(whitespace-tab ((t (:background "#BC8383" :foreground "#2B2B2B" :strike-through t))))
 '(whitespace-trailing ((t (:background "#CC9393" :foreground "#2B2B2B" :strike-through t))))

 '(doxymacs-keyword-face ((t (:underline t
                                         :weight bold))))

 '(column-enforce-face ((t (:inherit default
                                     :background "#F57900"
                                     ;; :foreground "#2B2B2B"
                                     :foreground "#FFC58C"
                                     ))))
 )
;; -------------------------------

(provide 'setup-gui)
