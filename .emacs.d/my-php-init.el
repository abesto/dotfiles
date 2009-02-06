;;;###autoload
(defun my-php-init ()
  (interactive)
  (require 'doxymacs)
  (defun php-doxymacs-font-lock-hook ()
    (if (eq major-mode 'php-mode)
        (doxymacs-font-lock)))
  (add-hook 'font-lock-mode-hook 'php-doxymacs-font-lock-hook)
)
