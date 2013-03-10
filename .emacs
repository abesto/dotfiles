;;;; Based on McGeary's init: http://www.emacsblog.org/2007/10/07/declaring-emacs-bankruptcy/
(server-start)

;; paths
(add-to-list 'load-path "/Users/abesto/.emacs.d")
(add-to-list 'load-path "/Users/abesto/.emacs.d/site")

;;;;;;;;;;;;;;;;;;;
;; Generic stuff ;;
;;;;;;;;;;;;;;;;;;;
(load "my-generic") ; Settings I always want
(load "my-ido")     ; Fuzzy filename search
(load "my-org")     ; org-mode setup
(load "my-helm")
(load "my-projectile")
(load "my-evil")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; My mode startup scripts ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'my-latex-init "my-latex-init")
(add-hook 'LaTeX-mode-hook 'my-latex-init)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Language-specific stuff ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load "my-slime-load")
(load "my-haskell-load")
(load "my-ruby-load")
(load "my-perl-load")

;; Customize
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
;
;; Beginning of the el4r block:
;; RCtool generated this block automatically. DO NOT MODIFY this block!
;(add-to-list 'load-path "/Users/abesto/.rvm/rubies/ruby-1.9.3-p194/share/emacs/site-lisp")
;(require 'el4r)
;(el4r-boot)
;; End of the el4r block.
;; User-setting area is below this line.
