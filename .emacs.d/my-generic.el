(require 'color-theme)
(color-theme-dark-laptop)     ; Nice, dark, easy on the eyes
(tool-bar-mode -1)            ; No toolbar, thanks
(set-default 'fill-column 80) ; 80. standard. good.
(setq visible-bell t)         ; Can't go beeping around at midnight, now can I?
(show-paren-mode)
(load "toggle-fullscreen")
;(nix-fullscreen)  Not needed - tiling WM ftw :)
(setq-default indent-tabs-mode nil)     ;I always want spaces instead of tabs
(setq default-tab-width 4)
(setq confirm-kill-emacs 'y-or-n-p)
(mouse-avoidance-mode 'exile)           ;Move mouse when cursor is over it
(defalias 'yes-or-no-p 'y-or-n-p)

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


;;
;; Wombat theme ported from Vim
;; Gotta move this into color-themes sometime
;;
(set-background-color "#242424")
(set-foreground-color "#f6f3e8")
(set-cursor-color "#656565")
(set-face-foreground 'font-lock-comment-face "#99968b")
(set-face-italic-p 'font-lock-comment-face t)
(set-face-foreground 'font-lock-doc-face "#99968b")
(set-face-italic-p 'font-lock-doc-face t)
(set-face-foreground 'font-lock-constant-face "#e5786d")
(set-face-foreground 'font-lock-string-face "#95e454")
(set-face-italic-p 'font-lock-string-face t)
(set-face-foreground 'font-lock-variable-name-face "#cae682")
(set-face-foreground 'font-lock-function-name-face "#cae682")
(set-face-foreground 'font-lock-type-face "#cae682")
(set-face-foreground 'font-lock-builtin-face "#8ac6f2")
(set-face-foreground 'font-lock-keyword-face "#8ac6f2")
(set-face-foreground 'font-lock-preprocessor-face "#e5786d")
(set-face-foreground 'font-lock-negation-char-face "#e7f6da")
(set-face-foreground 'link "#8ac6f2")
(set-face-bold-p 'link t)
(set-face-underline-p 'link t)
(set-face-foreground 'show-paren-match "#f6f3e8")
(set-face-background 'show-paren-match "#857b6f")
(set-face-bold-p 'show-paren-match t)
(set-face-foreground 'region "#f6f3e8")
(set-face-background 'region "#444444")
(set-face-foreground 'lazy-highlight "black")
(set-face-background 'lazy-highlight "yellow")
