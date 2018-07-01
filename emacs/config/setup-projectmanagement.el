(require 'projectile)
(projectile-mode)

;; Change projectile mode-line display.
(setq-default projectile-mode-line '(:eval (format "%s" (projectile-project-name))))

;; Enable caching unconditionally.
(setq projectile-enable-caching t)
;; Disable remote file exists cache
(setq projectile-file-exists-remote-cache-expire nil)
;; Ignore the following files extensions.
(setq projectile-globally-ignored-file-suffixes '(".o" ".a" ".so" ".dll" ".exe"))

(provide 'setup-projectmanagement)
