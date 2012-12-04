# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="dieter-mod"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias linode1="ssh linode230533@london468.linode.com"
alias linode2="ssh linode230801@london463.linode.com"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
 COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git osx python autojump rvm npm extract zsh-syntax-highlighting screen taskwarrior)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
PATH=$HOME/bin                                                     # Mine, all mine!
PATH=$PATH:/Library/Perl/5.12/auto/share/dist/Cope                 # Cope: color wrapper for some gnu core utils (OSX path)
PATH=$PATH:$HOME/.rvm/bin:$HOME/.cabal/bin:/usr/local/go/bin       # language-specific stuff
PATH=$PATH:/usr/X11/bin                                            # X11
PATH=$PATH:/sbin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin  # System-wide binaries
PATH=$PATH:/usr/local/Cellar/gettext/0.18.1.1/bin                  # gettext from homebrew
export PATH
export FLEX_HOME='/Applications/Adobe Flash Builder 4.6/sdks/3.6.0'
export EDITOR='emacsclient'

unsetopt correct_all

