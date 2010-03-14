(defun load-php ()
  (interactive)
  (require 'php-mode)
  (add-hook 'php-mode-hook
            '(lambda () (define-abbrev php-mode-abbrev-table "ex" "extends")))
  ;(require 'html-php)
  ;(add-to-list 'auto-mode-alist '("\\.php\\'" . html-php-mode))

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
  (add-hook 'php-mode-hook 'ensure-php-modes)
  (defun ensure-php-modes ()
    (doxymacs-mode 1)
    (flymake-mode 1)
    (font-lock-add-keywords 'php-mode doxymacs-doxygen-keywords)
   )
  )
