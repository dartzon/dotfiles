(require 'projectile)
(projectile-mode)

;; Change projectile mode-line display.
(setq-default projectile-mode-line '(:eval (format "%s" (projectile-project-name))))

;; Enable caching unconditionally.
(setq projectile-enable-caching t)
;; Disable remote file exists cache
(setq projectile-file-exists-remote-cache-expire nil)

;; Ignore the following folders.
(setq projectile-globally-ignored-directories '(".idea" ".ensime_cache" ".eunit" ".git" ".hg" ".fslckout" "_FOSSIL_" ".bzr" "_darcs" ".tox" ".svn" ".stack-work" ".cquery_cached_index"))

;; Ignore the following files extensions.
(setq projectile-globally-ignored-file-suffixes '(".o" ".a" ".so" ".dll" ".exe"))

(provide 'setup-projectmanagement)
