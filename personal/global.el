;; Map Prefix-Argument to M-u
(define-key global-map (kbd "M-u") 'universal-argument)
(define-key universal-argument-map (kbd "M-u") 'universal-argument-more)
