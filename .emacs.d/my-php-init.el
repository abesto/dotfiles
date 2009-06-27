(defun load-php ()
  (interactive)
  (require 'php-mode)
  (add-hook 'php-mode-hook
            '(lambda () (define-abbrev php-mode-abbrev-table "ex" "extends")))
  ;(require 'html-php)
  ;(add-to-list 'auto-mode-alist '("\\.php\\'" . html-php-mode))

  (require 'yasnippet)
  (yas/initialize)
  (yas/load-directory "~/.emacs.d/site/yasnippet")

  ;; Load the php-imenu index function
  (autoload 'php-imenu-create-index "php-imenu" nil t)
  ;; Add the index creation function to the php-mode-hook
  (add-hook 'php-mode-user-hook 'php-imenu-setup)
  (defun php-imenu-setup ()
    (setq imenu-create-index-function (function php-imenu-create-index))
    ;; uncomment if you prefer speedbar:
                                        ;(setq php-imenu-alist-postprocessor (function reverse))
    (imenu-add-menubar-index)
    )

  (require 'doxymacs)
  (add-hook 'php-mode-hook 'ensure-doxymacs-mode)
  (defun ensure-doxymacs-mode ()
    (doxymacs-mode 1)
    (font-lock-add-keywords 'php-mode doxymacs-doxygen-keywords)
   )
  )
