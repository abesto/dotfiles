(require 'color-theme)
(color-theme-dark-laptop)         ; Nice, dark, easy on the eyes

(tool-bar-mode -1)            ; No toolbar, thanks
(set-default 'fill-column 80) ; 80. standard. good.
(setq visible-bell t)         ; Can't go beeping around at midnight, now can I?

(show-paren-mode)

(load "toggle-fullscreen")
(nix-fullscreen)                        ;Start maximized

(setq-default indent-tabs-mode nil)     ;I always want spaces instead of tabs
(setq confirm-kill-emacs 'yes-or-no-p)
(server-start)

(mouse-avoidance-mode 'exile)           ;Move mouse when cursor is over it


;Moved to my-ido.el (global-set-key "\C-x\C-m" 'execute-extended-command)  ;; for M-x
;(global-set-key "\C-w" 'backward-kill-word) ;instead of backspacing
;(global-set-key "\C-x\C-k" 'kill-region)    ;rebind kill-region
(setq default-tab-width 4)

;; mode-compile
(autoload 'mode-compile "mode-compile"
"Command to compile current buffer file based on the major mode" t)
(global-set-key "\C-cc" 'mode-compile)
(autoload 'mode-compile-kill "mode-compile"
"Command to kill a compilation launched by `mode-compile'" t)
(global-set-key "\C-ck" 'mode-compile-kill)
(setq mode-compile-expert-p t)
