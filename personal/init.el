(with-eval-after-load 'smartparens
  (define-key smartparens-mode-map (kbd "M-[") 'sp-backward-unwrap-sexp)
  (define-key smartparens-mode-map (kbd "M-]") 'sp-unwrap-sexp))

(scroll-bar-mode -1)
