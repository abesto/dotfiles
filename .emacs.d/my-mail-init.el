;;;###autoload
(defun my-mail-init ()
  (flyspell-mode)
  (auto-fill-mode t)
  (setq fill-column 72)    ; rfc 1855 for usenet messages
  (footnote-mode t)
  (require 'boxquote)
)
