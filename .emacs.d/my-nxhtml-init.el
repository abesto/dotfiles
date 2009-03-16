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

  ;; js2.el instead of javascript.el
  (setq mumamo-major-modes '((asp-js-mode javascript-mode)
                             (javascript-mode js2-mode js2-fl-mode ecmascript-mode)
                             (java-mode jde-mode java-mode)))

)
