(require 'mu4e-vars)

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

;; use capability to select from multiple smtp accounts documented in:
;; https://www.djcbsoftware.nl/code/mu/mu4e/Multiple-accounts.html
(setq user-mail-address "ivan@stefanischin.eu"
      user-full-name "Ivan Stefanischin"
      mu4e-sent-folder "/personal/Sent"
      mu4e-drafts-folder "/personal/Drafts"
      mu4e-refile-folder "/personal/Archives"
      mu4e-spam-folder "/personal/Spam"
      mu4e-trash-folder "/personal/Trash"
      smtpmail-default-smtp-server "smtp.1und1.de"
      smtpmail-local-domain "1und1.de"
      smtpmail-smtp-server "smtp.1und1.de")

(defvar my-mu4e-account-alist
  '(("personal"
     (user-mail-address "ivan@stefanischin.eu")
     (mu4e-sent-folder "/personal/Sent")
     (mu4e-drafts-folder "/personal/Drafts")
     (mu4e-refile-folder "/personal/Archives")
     (mu4e-spam-folder "/personal/Spam")
     (mu4e-trash-folder "/personal/Trash")
     (smtpmail-default-smtp-server "smtp.1und1.de")
     (smtpmail-local-domain "1und1.de")
     (smtpmail-smtp-server "smtp.1und1.de"))
    ("bevuta"
     (user-mail-address "ivan.stefanischin@bevuta.com")
     (mu4e-sent-folder "/bevuta/Sent")
     (mu4e-drafts-folder "/bevuta/Drafts")
     (mu4e-refile-folder "/bevuta/Archives")
     (mu4e-spam-folder "/bevuta/Spam")
     (mu4e-trash-folder "/bevuta/Trash")
     (smtpmail-default-smtp-server "mail.networkname.de")
     (smtpmail-local-domain "networkname.de")
     (smtpmail-smtp-server "mail.networkname.de"))
    ("stefanischin"
     (user-mail-address "3013-614@online.de")
     (mu4e-sent-folder "/stefanischin/Sent")
     (mu4e-drafts-folder "/stefanischin/Drafts")
     (mu4e-refile-folder "/stefanischin/Archives")
     (mu4e-spam-folder "/stefanischin/Spam")
     (mu4e-trash-folder "/stefanischin/Trash")
     (smtpmail-default-smtp-server "smtp.1und1.de")
     (smtpmail-local-domain "1und1.de")
     (smtpmail-smtp-server "smtp.1und1.de"))))

(defun my-mu4e-set-account ()
  "Set the account for composing a message."
  (let* ((account
          (if mu4e-compose-parent-message
              (let ((maildir (mu4e-message-field mu4e-compose-parent-message :maildir)))
                (string-match "/\\(.*?\\)/" maildir)
                (match-string 1 maildir))
            (completing-read (format "Compose with account: (%s) "
                                     (mapconcat #'(lambda (var) (car var))
                                                my-mu4e-account-alist "/"))
                             (mapcar #'(lambda (var) (car var)) my-mu4e-account-alist)
                             nil t nil nil (caar my-mu4e-account-alist))))
         (account-vars (cdr (assoc account my-mu4e-account-alist))))
    (if account-vars
        (mapc #'(lambda (var)
                  (set (car var) (cadr var)))
              account-vars)
      (error "No email account found"))))

(add-hook 'mu4e-compose-pre-hook 'my-mu4e-set-account)

;; Add custom command and mark key for spam folder
;;(mu4e-multi-make-mark-for-command mu4e-spam-folder)
;;(define-key 'mu4e-headers-mode-map "i" 'mu4e-multi-mark-for-spam)

(setq mu4e-attachment-dir "~/tmp")

;; Set mail sending hook for msmtp
;;(add-hook 'message-send-mail-hook 'mu4e-multi-smtpmail-set-msmtp-account)

;; Set global key for new mails
;;(global-set-key (kbd "M-RET") 'mu4e-multi-compose-new)

;; use multiple signatures
(defun my-mu4e-choose-signature ()
  "Insert one of a number of sigs"
  (interactive)
  (let ((message-signature
          (mu4e-read-option "Signature:"
            '(("bevuta" .
               (concat
                "bevuta IT GmbH - professionelle IT-Lösungen\n"
                "Marktstraße 10 | http://www.bevuta.com/ | HRB 62476 AG Köln\n"
                "50968 Köln     | Tel.: +49 221 282678-0 | Geschäftsführer: Pablo Beyen"))
              ("private" .
               (concat
                "Ivan Stefanischin\n"
                "Adenauerallee 16\n"
                "53332 Bornheim\n"
                "Germany\n"
                "Mobile: +49 176 43874801"))
              ("samadhi" .
               (concat
                "Samadhi Buddhistisches Meditationscenter • Gierolstraße 7, 53127 Bonn\n"
                "Tel.: 0228 / 926 791 38 oder 0152 / 12815210\n"
                "\n"
                "www.samadhi-meditation.org • www.facebook.com/SamadhiBonn"))))))
    (message-insert-signature)))

(add-hook 'mu4e-compose-mode-hook
          (lambda () (local-set-key (kbd "C-c C-w") #'my-mu4e-choose-signature)))

(setq mu4e-msg2pdf "/usr/bin/msg2pdf")

;; don't keep message buffers around
(setq message-kill-buffer-on-exit t)

(setq mu4e-get-mail-command "mbsync")
