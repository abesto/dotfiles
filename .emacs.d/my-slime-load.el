(defun load-slime ()
  (interactive)
  (setq inferior-lisp-program "lisp")
  (add-to-list 'load-path (expand-file-name "~/.emacs.d/site/slime"))
  (require 'slime)
  (slime-setup)
)