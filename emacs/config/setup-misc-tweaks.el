;; ----------------------------------------------
;; Kill all buffers in one command.
;; ----------------------------------------------
(defun kill-all-buffers ()
  (interactive)
  (mapcar 'kill-buffer (buffer-list))
  (delete-other-windows))
;; ----------------------------------------------

;; ----------------------------------------------
;; Use the X clipboard in both X and xterm mode.
;; ----------------------------------------------
(require 'xclip)
(xclip-mode 1)
;; ----------------------------------------------

;; ---------------------------------------
;; Disable nlinum in the following modes.
;; ---------------------------------------
(defun my-disable-nlinum-mode ()
  (when (member major-mode '(dashboard-mode mu4e-main-mode mu4e-headers-mode mu4e-view-mode))
    (nlinum-mode -1)
    (setq indicate-empty-lines nil)
    )
  )

(add-hook 'after-change-major-mode-hook #'my-disable-nlinum-mode)

;; (add-hook 'after-change-major-mode-hook #'my-disable-show-trailing-whitespace)
;; (add-hook 'kill-buffer-hook #'my-disable-nlinum-mode)

;; (add-hook 'spaceline-pre-hook #'my-disable-nlinum-mode)
;; (add-hook 'dashboard-mode-hook #'my-disable-nlinum-mode)
;;
;; (add-hook 'mu4e-main-mode-hook #'my-disable-nlinum-mode)
;; (add-hook 'mu4e-headers-mode-hook #'my-disable-nlinum-mode)
;; (add-hook 'mu4e-view-mode-hook #'my-disable-nlinum-mode)
;; ---------------------------------------

(provide 'setup-misc-tweaks)
