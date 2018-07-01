;; Load ERC
(require 'erc)
(require 'erc-log)
(require 'erc-notify)
(require 'erc-spelling)
(require 'erc-autoaway)
(require 'erc-services)
(require 'erc-hl-nicks)

(setq erc-autojoin-timing 'ident
      erc-hide-list '("JOIN" "PART" "QUIT")
      erc-prompt-for-nickserv-password nil
      erc-server-reconnect-attempts 5
      erc-server-reconnect-timeout 3
      erc-track-exclude-types '("JOIN" "MODE" "NICK" "PART" "QUIT"
                                "324" "329" "332" "333" "353" "477")

      ;; Interpret mIRC-style color commands in IRC chats.
      erc-interpret-mirc-color t
      ;; Kill buffers for channels after /part.
      erc-kill-buffer-on-part t
      ;; Kill buffers for private queries after quitting the server.
      erc-kill-queries-on-quit t
      ;; Kill buffers for server messages after quitting the server.
      erc-kill-server-buffer-on-quit t
      ;; open query buffers in the current window.
      erc-query-display 'buffer
      ;; Reconnect in the background.
      erc-join-buffer 'bury
      ;; Rename buffers with network name.
      erc-rename-buffers t

      ;; Autoaway setup.
      erc-auto-discard-away t
      erc-autoaway-idle-seconds 600
      erc-autoaway-use-emacs-idle t

      ;; Save logs.
      erc-log-channels-directory "~/.irc/logs/"
      erc-save-buffer-on-part t

      ;; Use utf-8.
      erc-server-coding-system '(utf-8 . utf-8)

      ;; Default nickname to use.
      erc-nick '("dartzon" "sahelanthropus")
      )

(erc-services-mode 1)
(erc-track-mode t)

;; Create log directory of not existant.
(if (not (file-exists-p erc-log-channels-directory))
    (mkdir erc-log-channels-directory t))

;; Truncate long irc buffers.
(erc-truncate-mode +1)

;; Enable spell checking.
(erc-spelling-mode 1)

;; Auto-join channels
(erc-autojoin-mode t)
(setq erc-autojoin-channels-alist
      '(("freenode.net" "##c++")))

;; Start and stop erc
(defun start-irc ()
  "Connect to IRC."
  (interactive)
  (if (get-buffer "freenode")
      (erc-track-switch-buffer 1)
    (erc :server "irc.freenode.net" :port 6667)
    ))

(defun filter-erc-server-buffers ()
  (delq nil
        (mapcar
         (lambda (x) (and (erc-server-buffer-p x) x))
         (buffer-list))))

(defun stop-irc ()
  "Disconnects from all irc servers"
  (interactive)
  (dolist (buffer (filter-erc-server-buffers))
    (message "Server buffer: %s" (buffer-name buffer))
    (with-current-buffer buffer
      (erc-quit-server "dartzon, over."))))

(provide 'setup-irc)
