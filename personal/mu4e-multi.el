(require 'mu4e-multi)

(defvar mu4e-bookmarks
  `(,(make-mu4e-bookmark
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
      :name "Personal ToDos"
      :query "maildir:/personal/Inbox/.ToDo"
      :key ?p)
    ,(make-mu4e-bookmark
      :name "Bevuta ToDos"
      :query "maildir:/bevuta/Inbox/.ToDo"
      :key ?b))
  "A list of pre-defined queries. Each query is represented by a
mu4e-bookmark structure with parameters :name with the name
of the bookmark, :query with the query expression (a query
string or an s-expression that evaluates to query string) and a
:key, which is the shortcut-key for the query.

An older form of bookmark, a 3-item list with (QUERY DESCRIPTION
KEY) is still recognized as well, for backward-compatibility.")

(setq mu4e-multi-account-alist
      '(("personal"
         (user-mail-address . "ivan@stefanischin.eu")
         (mu4e-drafts-folder . "/personal/Drafts")
         (mu4e-refile-folder . "/personal/Archives")
         (mu4e-spam-folder . "/personal/Spam")
         (mu4e-sent-folder . "/personal/Sent")
         (mu4e-trash-folder . "/personal/Trash")
         (mu4e-todo-folder . "/personal/Inbox/.ToDo"))
        ("gmail"
         (user-mail-address . "mettajhana@gmail.com")
         (mu4e-drafts-folder . "/gmail/\[Gmail\]/.Entw\&APw-rfe")
         (mu4e-spam-folder . "/gmail/\[Gmail\]/.Spam")
         (mu4e-sent-folder . "/gmail/\[Gmail\]/.Gesendet")
         (mu4e-trash-folder . "/gmail/\[Gmail\]/.Papierkorb"))
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
         (mu4e-trash-folder . "/bevuta/Trash")
         (mu4e-todo-folder . "/bevuta/Inbox/.ToDo"))
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

;; Add custom command and mark key for todo folder
(mu4e-multi-make-mark-for-command mu4e-todo-folder)
(define-key 'mu4e-headers-mode-map "o" 'mu4e-multi-mark-for-todo)

;; Set mail sending hook for msmtp
(add-hook 'message-send-mail-hook 'mu4e-multi-smtpmail-set-msmtp-account)

;; Set global key for new mails
(global-set-key (kbd "M-RET") 'mu4e-multi-compose-new)
