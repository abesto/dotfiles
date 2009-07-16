(require 'modal-mode)
(require 'redo)

(add-hook 'emacs-startup-hook 'modal-mode)
(defun modal-ins-handle-escape ()
  (interactive)
  (let ((event last-input-event)
        (ESC-keys '(?\e (control \[) escape)))
        (modal-cmd-mode)))

(define-key modal-cmd-mode-map (kbd "u") 'undo)
(define-key modal-cmd-mode-map (kbd "\C-r") 'redo)
(define-key modal-cmd-mode-map (kbd "p") 'yank)
