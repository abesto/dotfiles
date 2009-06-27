(defun load-nxhtml ()
  (interactive)
  (load (expand-file-name "~/.emacs.d/site/nxhtml/autostart.el"))  ;Load nxhtml
  (require 'js2-mode)
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  (add-to-list 'auto-mode-alist '("\\.php\\'" . nxhtml-mumamo-mode))
 ;(setq ido-execute-command-cache nil) ;Update ido-mode command-completion
  (tabkey2-mode t)

  ;; yasnippet
  (require 'yasnippet)
  (yas/initialize)
  (yas/load-directory "~/.emacs.d/site/yasnippet")

  ;; doxymacs
  (require 'doxymacs)
  (add-hook 'font-lock-mode-hook 'doxymacs-font-lock)
  (add-hook 'php-mode-user-hook 'ensure-doxymacs-mode)
  (defun ensure-doxymacs-mode ()
    (doxymacs-mode 1)
    (font-lock-add-keywords 'php-mode doxymacs-doxygen-keywords)
   )
  )
