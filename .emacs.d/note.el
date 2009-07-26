(defun curried-replace (str)
  (replace-regexp-in-string "\.org$" "" str))

(defun note ()
  (interactive)
  (find-file
   (concat
    (concat "/home/abesto/org/"
            (completing-read
             "Note file: "
             (mapcar 'curried-replace
                     (directory-files "/home/abesto/org" nil "^[^.]+.org$"))
            ))
    ".org"
    )))
