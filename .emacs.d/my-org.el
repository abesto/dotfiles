;; Activate org-mode: http://orgmode.org/manual/Activation.html#Activation
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(add-hook 'org-mode-hook 'turn-on-font-lock)

;; Set up remember mode: http://orgmode.org/manual/Remember.html#Remember
(org-remember-insinuate)
(setq org-directory "~/org/")
(setq org-default-notes-file (concat org-directory "~/org/notes.org"))
(define-key global-map "\C-cr" 'org-remember)

(defun insert-note-link ()
  (interactive)
  (insert
   (org-make-link-string
    (concat "./" (read-from-minibuffer "Note: ") ".org")
    (read-from-minibuffer "Description: "))
   )
)
(org-defkey org-mode-map "\C-cn" 'insert-note-link)

;; Templates
;(setq org-remember-templates)

;; Startup options
(setq org-hide-leading-stars t)
