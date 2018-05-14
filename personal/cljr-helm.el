(require 'clj-refactor)
(require 'cljr-helm)
(require 'clojure-mode)

(defun cljr-helm-clojure-mode-hook ()
  (clj-refactor-mode 1)
  (yas-minor-mode 1)
  (define-key clojure-mode-map (kbd "C-c C-r") 'cljr-helm))

(add-hook 'clojure-mode-hook #'cljr-helm-clojure-mode-hook)
