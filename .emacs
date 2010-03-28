;;;; Based on McGeary's init: http://www.emacsblog.org/2007/10/07/declaring-emacs-bankruptcy/

;; paths
(add-to-list 'load-path "/home/abesto/.emacs.d")
(dolist (path (list ""
                    "/mail"
                    "/yasnippet"
                    "/org"
                    "/doxymacs"
                    "/distel/elisp"
                    "/completion-ui"
                    "/zencoding"
                    ))
  (add-to-list 'load-path (concat "/home/abesto/.emacs.d/site" path)))

;;;;;;;;;;;;;;;;;;;
;; Generic stuff ;;
;;;;;;;;;;;;;;;;;;;
(require 'tex-site)

(autoload 'htmlize-file "htmlize" "Load FILE, fontify it, convert it to HTML, and save the result." t)
(autoload 'htmlize-buffer "htmlize" "Fontify buffer, convert it to HTML, and open the result in a new buffer." t)

(load "my-generic") ; Settings I always want
(load "my-ido")     ; Fuzzy filename search
(load "my-viper")   ; Viper-mode setup
(load "my-org")     ; org-mode setup

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; My mode startup scripts ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'my-latex-init "my-latex-init")
(autoload 'my-php-init "my-php-init")
(autoload 'my-mail-init "my-mail-init")
(autoload 'my-c++-init "my-c++-init")

;; Mode hooks
(add-hook 'c++-mode-hook 'my-c++-init)
(add-hook 'LaTeX-mode-hook 'my-latex-init)
(add-hook 'php-mode-user-hook 'my-php-init)
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
;; mails
(autoload 'post-mode "post" "mode for e-mail" t)
(add-hook 'post-mode-hook 'my-mail-init)

;;;;;;;;;;;;;;;;;;;;;;
;; Big environemnts ;;
;;;;;;;;;;;;;;;;;;;;;;
;;; Each contains load-* to... load it
(load "my-jde-load")     ; A Java Development Environment for Emacs
(load "my-slime-load")   ; SLIME for editing lisp
(load "my-nxhtml-load")  ; nxhtml for HTML+CSS+JS+PHP+Whatever
(load "my-haskell-load")
(load "my-php-load")
(load "my-ecb-load")

(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;; Customize
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)


;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))
