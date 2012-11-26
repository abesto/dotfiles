(add-to-list 'load-path (concat "/Users/abesto/.emacs.d/site/haskell-mode"))
(add-to-list 'load-path "/Users/abesto/.cabal/share/ghc-mod-1.11.0")
(add-to-list 'exec-path "/Users/abesto/.cabal/bin")
(load "haskell-site-file")

(defun scion-hook ()
  (scion-mode 1)
  (scion-flycheck-on-save 1))

(defun ghc-mod-hook ()
  (ghc-init)
  (flymake-mode))

(defun my-haskell-hook ()
  (turn-on-haskell-doc-mode)
  (turn-on-haskell-indent)
  (ghc-mod-hook))

(add-hook 'haskell-mode-hook 'my-haskell-hook)

                                        ; ghc-mod
(autoload 'ghc-init "ghc" nil t)

                                        ; scion
                                        ;(require 'scion)
                                        ;(setq scion-completing-read-function 'ido-completing-read))
                                        ;(setq scion-program "/Users/abesto/.cabal/bin/scion-server")
                                        ;(add-to-list 'load-path "/Users/abesto/scion/emacs")
