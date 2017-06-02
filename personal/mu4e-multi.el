(require 'mu4e-multi)

(setq mu4e-bookmarks
      `(,(make-mu4e-bookmark
          :name  "Flagged messages"
          :query "flag:flagged AND NOT flag:trashed"
          :key ?f)
        ,(make-mu4e-bookmark
          :name  "Unread messages"
          :query "flag:unread AND NOT flag:trashed"
          :key ?u)
        ,(make-mu4e-bookmark
          :name "Today's messages"
          :query "date:today..now"
          :key ?t)
        ,(make-mu4e-bookmark
          :name "Last 7 days"
          :query "date:7d..now"
          :key ?w)
        ,(make-mu4e-bookmark
          :name "Personal"
          :query "maildir:/personal/Inbox"
          :key ?p)
        ,(make-mu4e-bookmark
          :name "Bevuta"
          :query "maildir:/bevuta/Inbox"
          :key ?b)))

(setq mu4e-multi-account-alist
      '(("personal"
         (user-mail-address . "ivan@stefanischin.eu")
         (mu4e-drafts-folder . "/personal/Drafts")
         (mu4e-refile-folder . "/personal/Archives")
         (mu4e-spam-folder . "/personal/Spam")
         (mu4e-sent-folder . "/personal/Sent")
         (mu4e-trash-folder . "/personal/Trash"))
        ("spam"
         (user-mail-address . "katzomoto@online.de")
         (mu4e-drafts-folder . "/spam/Drafts")
         (mu4e-spam-folder . "/spam/Spam")
         (mu4e-sent-folder . "/spam/Sent")
         (mu4e-trash-folder . "/spam/Trash"))
        ("bevuta"
         (user-mail-address . "ivan.stefanischin@bevuta.com")
         (mu4e-drafts-folder . "/bevuta/Drafts")
         (mu4e-spam-folder . "/bevuta/Spam")
         (mu4e-sent-folder . "/bevuta/Sent")
         (mu4e-trash-folder . "/bevuta/Trash"))
        ("stefanischin"
         (user-mail-address . "3013-614@online.de")
         (mu4e-drafts-folder . "/stefanischin/Drafts")
         (mu4e-refile-folder . "/stefanischin/Archives")
         (mu4e-spam-folder . "/stefanischin/Spam")
         (mu4e-sent-folder . "/stefanischin/Sent")
         (mu4e-trash-folder . "/stefanischin/Trash"))))
(mu4e-multi-enable)

;; Add custom command and mark key for spam folder
(mu4e-multi-make-mark-for-command mu4e-spam-folder)
(define-key 'mu4e-headers-mode-map "i" 'mu4e-multi-mark-for-spam)

(setq mu4e-attachment-dir "~/tmp")

;; Set mail sending hook for msmtp
(add-hook 'message-send-mail-hook 'mu4e-multi-smtpmail-set-msmtp-account)

;; Set global key for new mails
(global-set-key (kbd "M-RET") 'mu4e-multi-compose-new)

;; use multiple signatures
(defun my-mu4e-choose-signature ()
  "Insert one of a number of sigs"
  (interactive)
  (let ((message-signature
          (mu4e-read-option "Signature:"
            '(("formal" .
               (concat
                "bevuta IT GmbH - professionelle IT-Lösungen\n"
                "Marktstraße 10 | http://www.bevuta.com/ | HRB 62476 AG Köln\n"
                "50968 Köln     | Tel.: +49 221 282678-0 | Geschäftsführer: Pablo Beyen"))
              ("informal" .
               (concat
                "Ivan Stefanischin\n"
                "Adenauerallee 16"
                "53332 Bornheim"))))))
    (message-insert-signature)))

(add-hook 'mu4e-compose-mode-hook
          (lambda () (local-set-key (kbd "C-c C-w") #'my-mu4e-choose-signature)))

(add-hook 'mbsync-exit-hook
          (lambda () (mu4e-update-mail-and-index nil)))

(setq mu4e-msg2pdf "/usr/bin/msg2pdf")
