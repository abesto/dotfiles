;;;###autoload
(defun my-ruby-init ()
  (load "inf-ruby")
  (setq standard-indent 2)
    (autoload 'run-ruby "inf-ruby"
      "Run an inferior Ruby process")
    (add-hook 'ruby-mode-hook
          '(lambda ()
             (inf-ruby-keys)
    ))
)
