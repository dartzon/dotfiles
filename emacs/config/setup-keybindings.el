(require 'bind-key)

(bind-key "C-x C-b" 'ibuffer)

(bind-key "C-c C-k" 'kill-all-buffers)

(bind-key "C-<f3>" 'highlight-symbol)
(bind-key "<f3>" 'highlight-symbol-next)
(bind-key "S-<f3>" 'highlight-symbol-prev)
(bind-key "C-<f2>" 'bm-toggle)
(bind-key "<f2>" 'bm-next)
(bind-key "S-<f2>" 'bm-previous)

(bind-key "C-r" 'replace-string)
(bind-key "C-S-l" 'mc/edit-lines)

;; Disable C-c d key binding for doxymacs.
(unbind-key "C-c d" doxymacs-mode-map)
(bind-key "C-c d" (lambda (&optional arg) (interactive)
                    (switch-to-buffer "*dashboard*")
                    (dashboard-next-section)
                    ))

(bind-key "C-h C-m" 'discover-my-major)
(bind-key "C-h M-m" 'discover-my-mode)

(bind-key "M-x" 'smex)

(bind-key "C-c e" 'mu4e)

(bind-key "C-c i" 'start-irc)
(bind-key "C-c M-i" 'stop-irc)

(bind-key "C-*" 'evilnc-comment-or-uncomment-lines prog-mode-map)
(bind-key "C-*" 'evilnc-comment-or-uncomment-lines c-mode-base-map)

;; (bind-key "RET" 'newline-and-indent prog-mode-map)
;; (bind-key "RET" 'newline-and-indent c-mode-base-map)

(bind-key "C-c f" (lambda (&optional arg) (interactive)
                    (when (projectile-project-p)
                      (projectile-find-file))))

(bind-key "TAB" 'company-complete c-mode-map)
(bind-key "TAB" 'company-complete c++-mode-map)

(bind-key "C-c h" 'hackernews)

(provide 'setup-keybindings)
