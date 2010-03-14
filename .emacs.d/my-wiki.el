(require 'dokuwiki)
(add-hook 'simple-wiki-mode-hook 'turn-on-auto-fill)
(add-hook 'simple-wiki-mode-hook 'longlines-mode)
(setq dokuwiki-username "abesto"
      dokuwiki-password "nzpd2004"
      dokuwiki-base-url "localhost/wiki")
