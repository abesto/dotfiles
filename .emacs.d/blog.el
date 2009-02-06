;;;###autoload
(defun blog-init ()
  (interactive)
  (html-mode)
  (auto-fill-mode)
  (ispell-change-dictionary "american" t)
  (flyspell-mode)
)
