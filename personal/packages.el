(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(prelude-require-packages '(ag
                            clj-refactor
                            rcirc-notify
                            dired-du
                            google-translate))
