(setq viper-mode t)                ; enable Viper
(require 'viper)                   ; load Viper
(require 'vimpulse)                ; load Vimpulse
(setq viper-ex-style-editing nil)  ; can backspace past start of insert / line
(setq woman-use-own-frame nil      ; don't create new frame for manpages
      woman-use-topic-at-point t   ; don't prompt upon K key (manpage display)
      viper-vi-style-in-minibuffer nil ; don't.
      viper-want-ctl-h-help 1)       ; yes I do

(define-key viper-insert-global-user-map "\C-d" 'delete-char)
(require 'redo)                    ; redo
(require 'rect-mark)               ; nice block mode
(setq scroll-conservatively 0)     ; vim-style scrolling
(setq scroll-margin 5)             ; and again

;; Unbind accented chars
(define-key viper-vi-basic-map "ö" 'viper-nil)
(define-key viper-vi-basic-map "ü" 'viper-nil)
(define-key viper-vi-basic-map "ó" 'viper-nil)
(define-key viper-vi-basic-map "ő" 'viper-nil)
(define-key viper-vi-basic-map "ú" 'viper-nil)
(define-key viper-vi-basic-map "é" 'viper-nil)
(define-key viper-vi-basic-map "á" 'viper-nil)
(define-key viper-vi-basic-map "ű" 'viper-nil)
(define-key viper-vi-basic-map "í" 'viper-nil)
