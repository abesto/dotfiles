(setq viper-mode t)                ; enable Viper
(require 'viper)                   ; load Viper
(require 'vimpulse)                ; load Vimpulse
(setq viper-ex-style-editing nil   ; can backspace past start of insert / line
      woman-use-own-frame nil      ; don't create new frame for manpages
      woman-use-topic-at-point t   ; don't prompt upon K key (manpage display)
      viper-vi-style-in-minibuffer nil ; don't.
      viper-want-ctl-h-help 1)      ; yes I do

(define-key viper-insert-global-user-map "\C-d" 'delete-char)
(require 'redo)                    ; redo
(require 'rect-mark)               ; nice block mode
(setq scroll-conservatively 0)     ; vim-style scrolling
(setq scroll-margin 5)             ; and again

;; Unbind accented chars
(let ((accents "öüóőúéáűí"))
     (dotimes (num (length accents))
             (define-key viper-vi-basic-map (string (aref accents num)) 'viper-nil)))

(define-key viper-insert-basic-map "" 'delete-char)
(define-key viper-vi-basic-map "" 'delete-char)
