(defun proj ()
  (interactive)
  (desktop-change-dir
  (concat "/home/abesto/proj/"
          (completing-read
           "Project name: "
           (remove-if-not
            (lambda (d)
              (file-exists-p
               (concat "/home/abesto/proj/" d "/.emacs.desktop")))
            (directory-files "/home/abesto/proj" nil "^[^.]+.*"))
          )
  )))
