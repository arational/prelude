;; f runs the command mbsync
(require 'mbsync)
(add-hook 'mbsync-exit-hook 'gnus-group-get-new-news)
(global-set-key (kbd "M-#") 'mbsync)
