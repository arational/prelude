;; automatically sync mails with timer
(defun sync-mails-sentinel (proc _)
  (when (eq (process-status proc) 'exit)
    (mu4e-update-mail-and-index nil)))

(defun sync-mails ()
  (let ((proc (start-process "sync-mails" "*sync-mails*" "mailcheck.sh")))
    (set-process-sentinel proc 'sync-mails-sentinel)))

(defvar sync-mails-timer
  (run-at-time 0 600 'sync-mails))
