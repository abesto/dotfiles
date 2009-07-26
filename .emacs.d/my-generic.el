;; Appearance
;(require 'color-theme)
;(color-theme-dark-laptop)     ; Nice, dark, easy on the eyes
;(color-theme-arjen)     ; Nice, dark, easy on the eyes
(color-theme-clarity)
(tool-bar-mode -1)            ; No toolbar, thanks
(set-default 'fill-column 80) ; 80. standard. good.
(setq visible-bell t)         ; Can't go beeping around at midnight, now can I?
(show-paren-mode)
(load "toggle-fullscreen")
;(nix-fullscreen) don't need this using AwesomeWM

;; This is me
(setq user-full-name "Zoltán Nagy")
(setq user-mail-address "abesto0@gmail.com")

;; Indenting
(setq-default indent-tabs-mode nil)     ; I always want spaces instead of tabs
(setq default-tab-width 4)
(setq-default c-basic-offset 4)

;; %s/yes/y, %s/no/n
(setq confirm-kill-emacs 'y-or-n-p)
(defalias 'yes-or-no-p 'y-or-n-p)

(mouse-avoidance-mode 'exile)           ; Move mouse when point is under it

;; keybindings
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\M-n" 'linum-mode)
(global-set-key (kbd "\C-c <tab>") 'align-regexp)

;; highlight current line
(global-hl-line-mode 1)
(set-face-background 'hl-line "#222")

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

(require 'ledger)

(autoload 'wikipedia-mode
  "wikipedia-mode.el"
  "Major mode for editing documents in Wikipedia markup." t)

(add-to-list 'auto-mode-alist '("mutt-keyrit_notepad" . mail-mode))
(add-to-list 'auto-mode-alist '("vimperator.*" . blog-init))
(add-to-list 'auto-mode-alist '("abesto\.host22.*" . blog-init))
(add-to-list 'auto-mode-alist '(".*blogger-com-post.*" . blog-init))
(add-to-list 'auto-mode-alist '("\\.*mutt-*\\|.article\\|\\.followup" . post-mode))
(add-to-list 'auto-mode-alist '(".*wiki.*" . my-wiki-init))
(setq auto-mode-alist (cons '("\\.lua$" . lua-mode) auto-mode-alist))
