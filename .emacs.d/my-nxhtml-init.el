(defun load-nxhtml ()
  (interactive)
  (load (expand-file-name "~/.emacs.d/site/nxhtml/autostart.el"))
  (setq ido-execute-command-cache nil)
  (tabkey2-mode)
  (require 'yasnippet)
  (yas/initialize)
  (yas/load-directory "~/.emacs.d/site/yasnippet")
  (add-hook 'php-mode-hook 'my-php-init)
)
