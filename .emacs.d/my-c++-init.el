;;;###autoload
(defun my-c++-init ()
  (require 'doxymacs)
  (require 'my-yasnippet)
  (doxymacs-mode 1)
  (yas/minor-mode)
  (font-lock-add-keywords 'c++-mode doxymacs-doxygen-keywords)
  (local-set-key "\M-/" 'complete-semantic)
)
