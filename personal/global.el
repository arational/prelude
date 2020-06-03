;; Map Prefix-Argument to M-u
(define-key global-map (kbd "M-u") 'universal-argument)
(define-key universal-argument-map (kbd "M-u") 'universal-argument-more)

;; Toggle smartparens strict mode for buffer
(global-set-key (kbd "C-x M-s") 'smartparens-strict-mode)

;; Wrap in square brackets
(global-set-key (kbd "M-[") 'paredit-wrap-square)

;; keep cursor at same position when scrolling and add keywbindings to
;; scroll the screen when moving the cursor
(setq scroll-preserve-screen-position 1)
(global-set-key (kbd "M-n") (kbd "C-u 1 C-v"))
(global-set-key (kbd "M-p") (kbd "C-u 1 M-v"))
