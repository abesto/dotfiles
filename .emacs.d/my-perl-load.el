(fset 'perl-mode 'cperl-mode)

(setq cperl-tabs-always-indent t)

(add-hook 'cperl-mode-hook '(lambda ()
                              (setq indent-tabs-mode t
                                    c-basic-indent 8
                                    cperl-indent-level 8
                                    tab-width 8)))
