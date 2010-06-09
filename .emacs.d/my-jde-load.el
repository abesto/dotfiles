(defun load-jde ()
  (interactive)
  (require 'cedet)
  (autoload 'jde-mode "jde" "JDE mode." t)
  (setq auto-mode-alist
        (append
         '(("\\.java\\'" . jde-mode))
          auto-mode-alist))
)
