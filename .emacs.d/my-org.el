;; Activate org-mode: http://orgmode.org/manual/Activation.html#Activation
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(add-hook 'org-mode-hook 'turn-on-font-lock)

;; Set up remember mode: http://orgmode.org/manual/Remember.html#Remember
(org-remember-insinuate)
(setq org-directory "~/gtd/")
(setq org-default-notes-file (concat org-directory "/notes.org"))
(define-key global-map "\C-cr" 'org-remember)

;; Templates
(setq org-remember-templates
      '(("Hotel" ?h
         "** ÚJ %^{Hotel neve}\n   Kérés érkezett: %t\n   Feltöltve: \n   Fizetve: \n   %?"
         "~/proj/shop/hotelek.org" "Hotelek")
        ("Timestamp" ?s "%T %?%&")
        ("Task" ?t "** TODO %? %^G" "~/gtd/main.org" "Tasks")
        ("Project" ?p "** TODO %^{Project name} %^G\n*** %?" "~/gtd/main.org" "Projects")
        ))

;; Startup options
(setq org-hide-leading-stars t)
