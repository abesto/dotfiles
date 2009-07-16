(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(TeX-output-view-style (quote (("^dvi$" ("^landscape$" "^pstricks$\\|^pst-\\|^psfrag$") "%(o?)dvips -t landscape %d -o && gv %f") ("^dvi$" "^pstricks$\\|^pst-\\|^psfrag$" "%(o?)dvips %d -o && gv %f") ("^dvi$" ("^a4\\(?:dutch\\|paper\\|wide\\)\\|sem-a4$" "^landscape$") "%(o?)xdvi %dS -paper a4r -s 0 %d") ("^dvi$" "^a4\\(?:dutch\\|paper\\|wide\\)\\|sem-a4$" "%(o?)xdvi %dS -paper a4 %d") ("^dvi$" ("^a5\\(?:comb\\|paper\\)$" "^landscape$") "%(o?)xdvi %dS -paper a5r -s 0 %d") ("^dvi$" "^a5\\(?:comb\\|paper\\)$" "%(o?)xdvi %dS -paper a5 %d") ("^dvi$" "^b5paper$" "%(o?)xdvi %dS -paper b5 %d") ("^dvi$" "^letterpaper$" "%(o?)xdvi %dS -paper us %d") ("^dvi$" "^legalpaper$" "%(o?)xdvi %dS -paper legal %d") ("^dvi$" "^executivepaper$" "%(o?)xdvi %dS -paper 7.25x10.5in %d") ("^dvi$" "." "%(o?)xdvi %dS %d") ("^pdf$" "." "xpdf %o %(outpage)") ("^html?$" "." "netscape %o"))))
 '(ecb-auto-activate nil)
 '(ecb-layout-name "left4")
 '(ecb-options-version "2.40")
 '(ecb-source-path (quote (("~/proj/" "Projects"))))
 '(ecb-tree-buffer-style (quote ascii-guides))
 '(ecb-tree-indent 2)
 '(erc-user-full-name "Nagy Zoltán")
 '(imenu-auto-rescan t)
 '(imenu-auto-rescan-maxout 60000000)
 '(inhibit-startup-screen t)
 '(mumamo-noweb2-mode-from-ext (quote (("c" . c-mode))))
 '(mumamo-set-major-mode-delay 0.3)
 '(nuke-trailing-whitespace-in-hooks (quote (write-file-hooks mail-send-hook)) nil (nuke-trailing-whitespace))
 '(nxhtml-default-encoding (quote utf-8))
 '(nxhtml-skip-welcome t)
 '(nxml-mode-hook (quote (rng-validate-mode)))
 '(org-agenda-files (quote ("~/proj/beluga/proj.org" "~/gtd/main.org")))
 '(org-export-author-info nil)
 '(org-export-creator-info nil)
 '(org-export-default-language "hu")
 '(org-export-preserve-breaks t)
 '(org-export-time-stamp-file nil)
 '(php-manual-path "~/docs/php/html")
 '(show-paren-mode t)
 '(smooth-scroll-margin 4)
 '(transient-mark-mode (quote (only . t)))
 '(use-file-dialog nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ecb-default-highlight-face ((((class color) (background dark)) (:background "color-22"))))
 '(ecb-mode-line-prefix-face ((((class color) (background dark)) (:foreground "lightgreen"))))
 '(ecb-tag-header-face ((((class color) (background dark)) (:background "DarkGreen"))))
 '(mumamo-background-chunk-major ((((class color) (min-colors 88) (background dark)) nil)))
 '(mumamo-background-chunk-submode ((((class color) (min-colors 88) (background dark)) nil)))
 '(viper-minibuffer-emacs ((((class color)) nil)))
 '(viper-minibuffer-insert ((((class color)) nil)))
 '(viper-minibuffer-vi ((((class color)) nil)))
 '(viper-replace-overlay ((((class color)) nil)))
 '(viper-search ((((class color)) nil))))
