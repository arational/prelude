(require 'smartparens-clojure)

(add-hook 'clojure-mode-hook #'smartparens-strict-mode)
(add-hook 'lisp-mode-hook #'smartparens-strict-mode)
