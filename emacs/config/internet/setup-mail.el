 (require 'mu4e)

(setq
 ;; set mu4e as default mail client.
 mail-user-agent 'mu4e-user-agent

 ;; Mail directory path.
 mu4e-maildir "~/.mail/dartzon@gmail.com"

 )

(setq mu4e-change-filenames-when-moving t)

(setq mu4e-drafts-folder "/drafts"
      mu4e-sent-folder   "/sent"
      mu4e-trash-folder  "/trash")

(setq mu4e-maildir-shortcuts
      '( ("/INBOX"   . ?i)
         ("/sent"    . ?s)
         ("/trash"   . ?t)
         ("/archive" . ?a)))

;; Don't save messages to Sent Messages, Gmail/IMAP takes care of this
(setq mu4e-sent-messages-behavior 'delete
      mu4e-get-mail-command "true"           ;;"offlineimap"  ;; or fetchmail, or ...
      mu4e-update-interval 300             ;; update every 5 minutes
      message-kill-buffer-on-exit t
      mu4e-use-fancy-chars t               ;; use 'fancy' non-ascii characters in various places
      mu4e-view-show-images t
      mu4e-image-max-width 800
      ;; display html content in emails with w3m
      w3m-command "/usr/bin/w3m -dump -cols 100 -graph -T text/html -o display_link=false"
      mu4e-view-prefer-html t
      mu4e-attachment-dir "~/Downloads/"   ;; save attachment to ~/Downloads
      mu4e-headers-skip-duplicates t       ;; exclude own e-mail address when “replying to all”
      mu4e-compose-dont-reply-to-self t

      ;; customize the reply-quote-string
      message-citation-line-format "On %a %d %b %Y at %R, %f wrote:\n"
      ;; choose to use the formatted string
      message-citation-line-function 'message-insert-formatted-citation-line
      )

;; use imagemagick, if available
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))

;; view messages in an external web browser
(add-to-list 'mu4e-view-actions
             '("ViewInBrowser" . mu4e-action-view-in-browser) t)

;; something about ourselves
(setq
 user-mail-address "dartzon@gmail.com"
 user-full-name  "Othmane AIT EL CADI"
 mu4e-compose-signature
 (concat
  "Othmane AIT EL CADI\n"
  "C++ Software Engineer\n"))


;; Enable 72 column message limit and flyspell.
(add-hook 'mu4e-compose-mode-hook
          (defun my-do-compose-stuff ()
            "My settings for message composition."
            (set-fill-column 72)
            (flyspell-mode)))

;; sending mail -- replace USERNAME with your gmail username
;; also, make sure the gnutls command line utils are installed
;; package 'gnutls-bin' in Debian/Ubuntu

(require 'smtpmail)
(setq message-send-mail-function 'smtpmail-send-it
      starttls-use-gnutls t
      smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587)

;; Confirmation before sending
(add-hook 'message-send-hook
          (lambda ()
            (unless (yes-or-no-p "Are you sure you want to send the message?")
              (signal 'quit nil))))


(provide 'setup-mail)
