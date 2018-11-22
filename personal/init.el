(scroll-bar-mode -1)

(defun insert-uuid ()
  "Generates a UUID via `uuidgen` and inserts it into the current buffer."
  (interactive)
  (call-process "uuidgen" nil t)
  (delete-backward-char 1))

(add-to-list 'auto-mode-alist
             '("\\.cl\\'" . (lambda ()
                               (c-mode))))

;; Adds the ticket number into the commit message
(defun my-git-commit-setup ()
  (let ((root (magit-git-dir))
        (branch (magit-get-current-branch)))
    (when (string-match "^/home/ivan/src/bevuta" root)
      (let ((re "\\([[:digit:]]\\{3,\\}\\)-?")
            (format-string "[%s] \n"))
        (when (and branch (string-match re branch))
          (let ((prefix (format format-string (match-string 1 branch))))
            (goto-char (point-min))
            (when (eolp)
              (insert prefix)
              (forward-char -1))))))))

(add-hook 'git-commit-mode-hook 'my-git-commit-setup)

;; esc always quits
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(global-set-key [escape] 'keyboard-quit)

;; disable rainbow parentheses
(rainbow-delimiters-mode -1)
