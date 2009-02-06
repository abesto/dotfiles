;;;###autoload
(defun my-python-init ()
	;; Python must always be indented, so why not bind Return to that?
	(local-set-key "\r" 'newline-and-indent)
)
