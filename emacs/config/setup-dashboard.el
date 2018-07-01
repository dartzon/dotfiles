;; ----------------------------------------------
;; Dashboard
;; ----------------------------------------------
(require 'dashboard)
(dashboard-setup-startup-hook)
(setq dashboard-banner-logo-title "[E M A C S  D A S H B O A R D]")
(setq dashboard-startup-banner 'logo)

(setq dashboard-items '((recents  . 5)
                        (bookmarks . 5)
                        (projects . 5)))

(provide 'setup-dashboard)
