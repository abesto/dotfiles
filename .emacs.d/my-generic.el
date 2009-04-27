(require 'color-theme)
(color-theme-dark-laptop)     ; Nice, dark, easy on the eyes
(tool-bar-mode -1)            ; No toolbar, thanks
(set-default 'fill-column 80) ; 80. standard. good.
(setq visible-bell t)         ; Can't go beeping around at midnight, now can I?
(show-paren-mode)
(load "toggle-fullscreen")
;(nix-fullscreen)
(setq-default indent-tabs-mode nil)     ;I always want spaces instead of tabs
(setq default-tab-width 4)
(setq confirm-kill-emacs 'y-or-n-p)
(mouse-avoidance-mode 'exile)           ;Move mouse when cursor is over it
(defalias 'yes-or-no-p 'y-or-n-p)

(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\M-n" 'linum-mode)

;; mode-compile
(autoload 'mode-compile "mode-compile"
"Command to compile current buffer file based on the major mode" t)
(global-set-key "\C-cc" 'mode-compile)
(autoload 'mode-compile-kill "mode-compile"
"Command to kill a compilation launched by `mode-compile'" t)
(global-set-key "\C-ck" 'mode-compile-kill)
(setq mode-compile-expert-p t)
(require 'epa)
(epa-file-enable)
