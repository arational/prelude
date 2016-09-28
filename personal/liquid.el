(with-eval-after-load 'smartparens
  (define-key smartparens-mode-map (kbd "M-[") 'sp-backward-unwrap-sexp)
  (define-key smartparens-mode-map (kbd "M-]") 'sp-unwrap-sexp))

(scroll-bar-mode -1)

(key-chord-define-global "uu" nil)
(key-chord-define-global "xx" nil)
(key-chord-define-global "JJ" nil)
