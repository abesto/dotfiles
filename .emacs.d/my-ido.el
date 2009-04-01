;; (setq ido-execute-command-cache nil)

;; (defun ido-execute-command ()
;;   (interactive)
;;   (call-interactively
;;    (intern
;;     (ido-completing-read
;;      "M-x "
;;      (progn
;;        (unless ido-execute-command-cache
;;          (mapatoms (lambda (s)
;;                      (when (commandp s)
;;                        (setq ido-execute-command-cache
;;                              (cons (format "%S" s) ido-execute-command-cache))))))
;;        ido-execute-command-cache)))))

;; (setq ido-enable-flex-matching t)
;; (global-set-key "\M-x" 'ido-execute-command)
;; (global-set-key "\C-x\C-m" 'ido-execute-command)

(ido-mode t)
