set PATH $HOME/bin $PATH                                               # Mine, all mine!
set PATH $PATH $HOME/.rvm/bin                                          # language-specific stuff
test -d /usr/X11/bin; and set PATH $PATH /usr/X11/bin                  # X11
set PATH $PATH /sbin /usr/local/bin /usr/local/sbin /usr/bin /bin /usr/sbin  # System-wide binaries
test -d ~/.prezi/simply; and set PATH $PATH $HOME/.prezi/simply

# GNU Tools
if test -d /usr/local/opt/coreutils
    set PATH /usr/local/opt/coreutils/libexec/gnubin $PATH
    set MANPATH /usr/local/opt/coreutils/libexec/gnuman $MANPATH
end
test -d /usr/local/opt/gnu-tar; and set PATH /usr/local/opt/gnu-tar/libexec/gnubin $PATH
