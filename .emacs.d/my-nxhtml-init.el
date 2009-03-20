(defun load-nxhtml ()
  (interactive)
  (load (expand-file-name "~/.emacs.d/site/nxhtml/autostart.el"))  ;Load nxhtml
  (setq ido-execute-command-cache nil) ;Update ido-mode command-completion
  (tabkey2-mode t)

  ;; yasnippet
  (require 'yasnippet)
  (yas/initialize)
  (yas/load-directory "~/.emacs.d/site/yasnippet")

  ;; doxymacs
  (require 'doxymacs)
)
