(require 'mu4e-multi)

(setq mu4e-multi-account-alist
      '(("personal"
         (user-mail-address . "ivan@stefanischin.eu")
         (mu4e-drafts-folder . "/personal/Drafts")
         (mu4e-refile-folder . "/personal/Archived")
         (mu4e-spam-folder . "/personal/Spam")
         (mu4e-sent-folder . "/personal/Sent")
         (mu4e-trash-folder . "/personal/Trash"))
        ("gmail"
         (user-mail-address . "mettajhana@gmail.com")
         (mu4e-drafts-folder . "/gmail/Drafts")
         (mu4e-refile-folder . "/gmail/Archived")
         (mu4e-spam-folder . "/gmail/Spam")
         (mu4e-sent-folder . "/gmail/Sent")
         (mu4e-trash-folder . "/gmail/Trash"))
        ("spam"
         (user-mail-address . "katzomoto@online.de")
         (mu4e-drafts-folder . "/spam/Drafts")
         (mu4e-refile-folder . "/spam/Archived")
         (mu4e-spam-folder . "/spam/Spam")
         (mu4e-sent-folder . "/spam/Sent")
         (mu4e-trash-folder . "/spam/Trash"))
        ("bevuta"
         (user-mail-address . "ivan.stefanischin@bevuta.com")
         (mu4e-drafts-folder . "/bevuta/Drafts")
         (mu4e-refile-folder . "/bevuta/Archived")
         (mu4e-spam-folder . "/bevuta/Spam")
         (mu4e-sent-folder . "/bevuta/Sent")
         (mu4e-trash-folder . "/bevuta/Trash"))))
(mu4e-multi-enable)

;; Add custom command and mark key for spam folder
(mu4e-multi-make-mark-for-command mu4e-spam-folder)
(define-key 'mu4e-headers-mode-map "i" 'mu4e-multi-mark-for-spam)

;; Set mail sending hook for msmtp
(add-hook 'message-send-mail-hook 'mu4e-multi-smtpmail-set-msmtp-account)

;; Set global key for new mails
(global-set-key (kbd "M-RET") 'mu4e-multi-compose-new)
