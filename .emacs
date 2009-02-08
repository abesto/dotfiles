;;;; Based on McGeary's init: http://www.emacsblog.org/2007/10/07/declaring-emacs-bankruptcy/

;; paths
(add-to-list 'load-path (expand-file-name "~/.emacs.d"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/site"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/site/yasnippet"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/site/cedet/speedbar"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/site/org-6.21a"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/site/doxymacs"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/site/egg"))

;;;;;;;;;;;;;;;;;;;
;; Generic stuff ;;
;;;;;;;;;;;;;;;;;;;
(require 'doremi-cmd)
(require 'color-theme)
(require 'tex-site)
(require 'egg)
(color-theme-initialize)
(autoload 'word-count-mode "word-count" "Minor mode to count words" t)
(autoload 'htmlize-file "htmlize" "Load FILE, fontify it, convert it to HTML, and save the result." t)
(autoload 'htmlize-buffer "htmlize" "Fontify buffer, convert it to HTML, and open the result in a new buffer." t)

(global-set-key "\M--" 'word-count-set-marker)

(load "my-generic") ; Settings I always want
(load "my-ido")     ; fuzzy search for M-x
(load "my-viper")

;;;;;;;;;;;;;;;;;;;;;;
;; Big environemnts ;;
;;;;;;;;;;;;;;;;;;;;;;
;;; Each contains load-* to... load it
;(autoload 'jde-mode "jde" "JDE mode." t)
;(load "my-lisp-init")   ; SLIME for editing lisp
(load "my-nxhtml-init") ; nxhtml for HTML+CSS+JS+PHP+Whatever
(load "my-haskell-init")
;(set-default-font "-adobe-courier-medium-r-normal--18-180-75-75-m-110-iso8859-1")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; My mode startup scripts ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'my-python-init "my-python-init")
(autoload 'my-ruby-init "my-ruby-init")
(autoload 'my-latex-init "my-latex-init")
(autoload 'blog-init "blog" "Blogging stuff" t)
(autoload 'my-php-init "my-php-init")

;; Mode and mode-like hooks
;; (add-hook 'python-mode-hook 'my-python-init)
(add-hook 'LaTeX-mode-hook 'my-latex-init)
(add-hook 'ruby-mode-hook 'my-ruby-init)
(push '("\\.blog\\'" . blog-init) auto-mode-alist)

;; Customize
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(TeX-output-view-style (quote (("^dvi$" ("^landscape$" "^pstricks$\\|^pst-\\|^psfrag$") "%(o?)dvips -t landscape %d -o && gv %f") ("^dvi$" "^pstricks$\\|^pst-\\|^psfrag$" "%(o?)dvips %d -o && gv %f") ("^dvi$" ("^a4\\(?:dutch\\|paper\\|wide\\)\\|sem-a4$" "^landscape$") "%(o?)xdvi %dS -paper a4r -s 0 %d") ("^dvi$" "^a4\\(?:dutch\\|paper\\|wide\\)\\|sem-a4$" "%(o?)xdvi %dS -paper a4 %d") ("^dvi$" ("^a5\\(?:comb\\|paper\\)$" "^landscape$") "%(o?)xdvi %dS -paper a5r -s 0 %d") ("^dvi$" "^a5\\(?:comb\\|paper\\)$" "%(o?)xdvi %dS -paper a5 %d") ("^dvi$" "^b5paper$" "%(o?)xdvi %dS -paper b5 %d") ("^dvi$" "^letterpaper$" "%(o?)xdvi %dS -paper us %d") ("^dvi$" "^legalpaper$" "%(o?)xdvi %dS -paper legal %d") ("^dvi$" "^executivepaper$" "%(o?)xdvi %dS -paper 7.25x10.5in %d") ("^dvi$" "." "%(o?)xdvi %dS %d") ("^pdf$" "." "xpdf %o %(outpage)") ("^html?$" "." "netscape %o"))))
 '(inhibit-startup-screen t)
 '(nuke-trailing-whitespace-in-hooks (quote (write-file-hooks mail-send-hook)) nil (nuke-trailing-whitespace))
 '(nxhtml-default-encoding (quote utf-8))
 '(nxhtml-skip-welcome t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(mumamo-background-chunk-major ((((class color) (min-colors 88) (background dark)) nil)))
 '(mumamo-background-chunk-submode ((((class color) (min-colors 88) (background dark)) nil))))
