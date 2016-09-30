(cl-loop for (mode . state) in '(;; GIT modes
                                 (git-commit-mode . emacs)
                                 (git-rebase-mode . emacs)
                                 (dired-mode . emacs)
                                 (shell-mode . emacs)

                                 ;; CIDER modes
                                 (cider-docview-mode . emacs)
                                 (cider-inspector-mode . emacs)
                                 (cider-macroexpansion-mode . emacs)
                                 (cider-repl-mode . emacs)
                                 (cider-result-mode . emacs)
                                 (cider-stacktrace-mode . emacs)
                                 (cider-test-report-mode . emacs))
         do (evil-set-initial-state mode state))
