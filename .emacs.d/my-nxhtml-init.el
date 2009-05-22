(defun load-nxhtml ()
  (interactive)
  (load (expand-file-name "~/.emacs.d/site/nxhtml/autostart.el"))  ;Load nxhtml
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
 ;(setq ido-execute-command-cache nil) ;Update ido-mode command-completion
  (tabkey2-mode t)

  ;; yasnippet
  (require 'yasnippet)
  (yas/initialize)
  (yas/load-directory "~/.emacs.d/site/yasnippet")

  ;; doxymacs
  (require 'doxymacs)
  (add-hook 'c-mode-common-hook 'doxymacs-mode)
  (defun ensure-doxymacs-mode ()
    (doxymacs-mode 1)
  )
  (add-hook 'php-mode-hook 'ensure-doxymacs-mode)
  )
