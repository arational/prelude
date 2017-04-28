(scroll-bar-mode -1)

(defun insert-uuid ()
  "Generates a UUID via `uuidgen` and inserts it into the current buffer."
  (interactive)
  (call-process "uuidgen" nil t)
  (delete-backward-char 1))
