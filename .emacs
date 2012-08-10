;;;; Based on McGeary's init: http://www.emacsblog.org/2007/10/07/declaring-emacs-bankruptcy/
(server-start)

;; paths
(add-to-list 'load-path "/Users/abesto/.emacs.d")
(dolist (path (list ""
                    "/js2-mode"
                    "/coffee-mode"
                    "/find-things-fast"
                    ))
  (add-to-list 'load-path (concat "/Users/abesto/.emacs.d/site" path)))

;;;;;;;;;;;;;;;;;;;
;; Generic stuff ;;
;;;;;;;;;;;;;;;;;;;
(load "my-generic") ; Settings I always want
(load "my-ido")     ; Fuzzy filename search
(load "my-viper")   ; Viper-mode setup
(load "my-org")     ; org-mode setup
(load "my-ftf")     ; find-things-fast

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
(load "my-coffeescript-load")
(load "my-js2-load")


;; Customize
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
