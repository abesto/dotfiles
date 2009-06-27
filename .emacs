;;;; Based on McGeary's init: http://www.emacsblog.org/2007/10/07/declaring-emacs-bankruptcy/

;; paths
(dolist (path (list "~/.emacs.d"
                    "~/.emacs.d/site"
                    "~/.emacs.d/site/mail"
                    "~/.emacs.d/site/yasnippet"
                    "~/.emacs.d/site/org"
                    "~/.emacs.d/site/doxymacs"))
  (add-to-list 'load-path (expand-file-name path)))
;(add-to-list 'load-path (expand-file-name "~/.emacs.d/site/egg"))  Dontwant :(

;;;;;;;;;;;;;;;;;;;
;; Generic stuff ;;
;;;;;;;;;;;;;;;;;;;
(require 'doremi-cmd)
(require 'color-theme)
(require 'tex-site)
(require 'org2rem)
;(require 'egg)
(color-theme-initialize)
(autoload 'word-count-mode "word-count" "Minor mode to count words" t)
(autoload 'htmlize-file "htmlize" "Load FILE, fontify it, convert it to HTML, and save the result." t)
(autoload 'htmlize-buffer "htmlize" "Fontify buffer, convert it to HTML, and open the result in a new buffer." t)

(global-set-key "\M--" 'word-count-set-marker)

(load "my-generic") ; Settings I always want
(load "my-ido")     ; fuzzy search
(load "my-viper")   ; viper-mode setup
;(load "my-modal")
;(add-hook 'find-file-hook 'vip-mode)
(load "my-org")     ; org-mode setup

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; My mode startup scripts ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'my-python-init "my-python-init")
(autoload 'my-ruby-init "my-ruby-init")
(autoload 'my-latex-init "my-latex-init")
(autoload 'blog-init "blog" "Blogging stuff" t)
;(autoload 'my-php-init "my-php-init" t)
(autoload 'my-mail-init "my-mail-init")

;; Mode and mode-like hooks
;; (add-hook 'python-mode-hook 'my-python-init)
(add-hook 'LaTeX-mode-hook 'my-latex-init)
(add-hook 'ruby-mode-hook 'my-ruby-init)
(add-hook 'php-mode-user-hook 'my-php-init)
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
;; mails
(autoload 'post-mode "post" "mode for e-mail" t)
(add-to-list 'auto-mode-alist '("\\.*mutt-*\\|.article\\|\\.followup" . post-mode))
(add-hook 'post-mode-hook 'my-mail-init)

;;;;;;;;;;;;;;;;;;;;;;
;; Big environemnts ;;
;;;;;;;;;;;;;;;;;;;;;;
;;; Each contains load-* to... load it
(load "my-jde-init")     ; A Java Development Environment for Emacs
(load "my-slime-init")   ; SLIME for editing lisp
(load "my-nxhtml-init")  ; nxhtml for HTML+CSS+JS+PHP+Whatever
(load "my-haskell-init")
(load "my-ecb-init")
(load "my-php-init")

(load-php)

; Load them on startup if running in daemon mode
 (if (daemonp)
     (progn
       (load-slime)
       ;(load-nxhtml)
       (load-haskell)
       ;(load-jde)))
       (load-ecb)
       (load-php)
       ))

(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;; Customize
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
