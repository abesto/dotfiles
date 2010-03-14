;; Appearance
(require 'zenburn)
(color-theme-zenburn)

(set-default 'fill-column 80) ; 80. standard. good.
(tool-bar-mode -1)            ; No toolbar, thanks
(scroll-bar-mode -1)          ; No scrollbar either
(setq visible-bell t)         ; Can't go beeping around at midnight, now can I?
(show-paren-mode)
(load "toggle-fullscreen")
(column-number-mode 1)
;(nix-fullscreen) don't need this using AwesomeWM

;; This is me
(setq user-full-name "Nagy Zoltán")
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

(setq auto-mode-alist
      (append
       (list
        '("mutt-keyrit_notepad" . mail-mode)
        '("vimperator.*" . blog-init)
        '("abesto\.host22.*" . blog-init)
        '(".*blogger-com-post.*" . blog-init)
        '("\\.*mutt-*\\|.article\\|\\.followup" . post-mode)
        '(".*wiki.*" . my-wiki-init)
        '("\\.*mutt-*\\|.article\\|\\.followup" . post-mode)
        '(".*\.mako" . html-mode)
        '("\\.lua$" . lua-mode)
	) auto-mode-alist )
)

(require 'uniquify)

(require 'my-yasnippet)
(require 'zencoding-mode)
(add-hook 'sgml-mode-hook 'zencoding-mode)
