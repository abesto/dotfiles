(defun load-nxhtml ()
  (interactive)
  (load (expand-file-name "~/.emacs.d/site/nxhtml/autostart.el"))  ;Load nxhtml
  (setq ido-execute-command-cache nil) ;Update ido-mode command-completion
  (tabkey2-mode)

  ;; yasnippet
  (require 'yasnippet)
  (yas/initialize)
  (yas/load-directory "~/.emacs.d/site/yasnippet")

  ;; doxymacs
  (require 'doxymacs)
  (defun php-doxymacs-font-lock-hook ()
    (if (eq major-mode 'php-mode)
        (doxymacs-font-lock)))
  (add-hook 'font-lock-mode-hook 'php-doxymacs-font-lock-hook)
)
