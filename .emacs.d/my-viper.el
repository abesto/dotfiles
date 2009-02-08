(require 'viper)                   ; load Viper
(require 'vimpulse)                ; load Vimpulse
(setq viper-mode t)                ; enable Viper
(setq viper-ex-style-editing nil)  ; can backspace past start of insert / line
(setq woman-use-own-frame nil      ; don't create new frame for manpages
      woman-use-topic-at-point t   ; don't prompt upon K key (manpage display)
      viper-vi-style-in-minibuffer nil ; don't.
      viper-want-ctl-h-help 1)       ; yes I do

(define-key viper-insert-global-user-map "\C-d" 'delete-char)
(require 'redo)                    ; redo
(require 'rect-mark)               ; nice block mode
