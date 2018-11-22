(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(alert-fade-time 20)
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#3F3F3F" "#CC9393" "#7F9F7F" "#F0DFAF" "#8CD0D3" "#DC8CC3" "#93E0E3" "#DCDCCC"])
 '(browse-url-browser-function (quote browse-url-generic))
 '(browse-url-generic-program "xdg-open")
 '(cider-repl-use-pretty-printing t)
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(custom-enabled-themes (quote (deeper-blue)))
 '(custom-safe-themes
   (quote
    ("c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "40f6a7af0dfad67c0d4df2a1dd86175436d79fc69ea61614d668a635c2cd94ab" default)))
 '(dired-du-size-format t)
 '(dired-listing-switches "-alh")
 '(ee-export-file "~/var/effort.csv")
 '(ee-subtree-tag "redmine")
 '(ee-user "liquid")
 '(electric-indent-mode t)
 '(enable-local-variables nil)
 '(fci-rule-color "#383838")
 '(geiser-active-implementations (quote (chicken)))
 '(geiser-default-implementation (quote chicken))
 '(geiser-mode-start-repl-p t t)
 '(global-linum-mode nil)
 '(global-relative-line-numbers-mode nil)
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(linum-format (quote linum-relative))
 '(magit-repository-directories (quote (("~/src/bevuta" . 2) ("~/src" . 1))))
 '(mbsync-status-line-re "^C: .+")
 '(mu4e-change-filenames-when-moving t)
 '(mu4e-headers-include-related nil)
 '(mu4e-maildir "/home/ivan/.mail")
 '(nrepl-message-colors
   (quote
    ("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3")))
 '(nxml-attribute-indent 2)
 '(nxml-child-indent 2)
 '(org-agenda-files (quote ("~/var/todo.org")))
 '(org-clock-continuously t)
 '(org-clock-into-drawer nil)
 '(org-clock-rounding-minutes 15)
 '(org-ellipsis "[...]")
 '(org-log-into-drawer nil)
 '(org-replace-disputed-keys t)
 '(org-return-follows-link t)
 '(org-src-fontify-natively t)
 '(org-support-shift-select nil)
 '(org-time-stamp-rounding-minutes (quote (15 15)))
 '(package-selected-packages
   (quote
    (dired-du zop-to-char zenburn-theme yaml-mode writeroom-mode which-key volatile-highlights undo-tree smartrep smartparens smart-mode-line slime rcirc-notify rainbow-mode rainbow-delimiters puppet-mode popup pkgbuild-mode php-mode ov operate-on-number mu4e-alert move-text memoize markdown-mode magit json-mode js2-mode imenu-anywhere hl-todo guru-mode grizzl goto-chg god-mode gitignore-mode gitconfig-mode git-timemachine gist geiser flycheck flx f expand-region elisp-slime-nav effort-export editorconfig easy-kill discover-my-major diminish diff-hl csv-mode crux counsel-projectile company clj-refactor browse-kill-ring beacon anzu ag ace-window)))
 '(pdf-view-midnight-colors (quote ("#DCDCCC" . "#383838")))
 '(prelude-flyspell nil)
 '(rcirc-authinfo nil)
 '(rcirc-default-nick "ivan")
 '(rcirc-notify-popup-timeout 1800)
 '(rcirc-server-alist (quote (("irc.f0o.de" :nick "ivan" :channels ("#bevuta")))))
 '(scheme-program-name "csi")
 '(send-mail-function (quote sendmail-send-it))
 '(sendmail-program "msmtp")
 '(smartparens-global-mode nil)
 '(smartparens-global-strict-mode t)
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   (quote
    ((20 . "#BC8383")
     (40 . "#CC9393")
     (60 . "#DFAF8F")
     (80 . "#D0BF8F")
     (100 . "#E0CF9F")
     (120 . "#F0DFAF")
     (140 . "#5F7F5F")
     (160 . "#7F9F7F")
     (180 . "#8FB28F")
     (200 . "#9FC59F")
     (220 . "#AFD8AF")
     (240 . "#BFEBBF")
     (260 . "#93E0E3")
     (280 . "#6CA0A3")
     (300 . "#7CB8BB")
     (320 . "#8CD0D3")
     (340 . "#94BFF3")
     (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#181a26" :foreground "gray80" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 130 :width normal :foundry "PfEd" :family "DejaVu Sans Mono")))))
