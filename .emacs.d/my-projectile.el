(defun projectile-ag ()
  "Run an `ag' search in the project"
  (interactive)
  (let ((search-regexp (if (and transient-mark-mode mark-active)
                           (buffer-substring (region-beginning) (region-end))
                         (read-string (projectile-prepend-project-name "Ag for: ") (thing-at-point 'symbol))))
        (root-dir (expand-file-name (projectile-project-root))))
    (ag/search search-regexp root-dir)))

(setq projectile-show-paths-function 'projectile-hashify-with-relative-paths)
(global-set-key '[f1] 'helm-projectile)
(global-set-key '[f2] 'projectile-ag)
(global-set-key "\C-xb" 'helm-mini)
