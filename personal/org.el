(with-eval-after-load 'org
  (define-key org-read-date-minibuffer-local-map (kbd "C-p")
    (lambda () (interactive)
      (org-eval-in-calendar '(calendar-backward-day 1))))
  (define-key org-read-date-minibuffer-local-map (kbd "C-n")
    (lambda () (interactive)
      (org-eval-in-calendar '(calendar-forward-day 1)))))
