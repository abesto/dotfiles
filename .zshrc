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
plugins=(git osx python autojump rvm npm extract zsh-syntax-highlighting screen taskwarrior sublime)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
PATH=$HOME/bin                                                     # Mine, all mine!
PATH=$PATH:/Library/Perl/5.12/auto/share/dist/Cope                 # Cope: color wrapper for some gnu core utils (OSX path)
PATH=$PATH:$HOME/.rvm/bin:$HOME/.cabal/bin:/usr/local/go/bin       # language-specific stuff
PATH=$PATH:/usr/X11/bin                                            # X11
PATH=$PATH:/sbin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin  # System-wide binaries
PATH=$PATH:/usr/local/Cellar/gettext/0.18.1.1/bin                  # gettext from homebrew
PATH=$PATH:/Users/abesto/.prezi/simply
export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH
export PATH
export EDITOR='vim'

# GNU Tools
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"  
MANPATH="/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH"

# JVM, Java, Scala
#export JAVA_HOME=$(/usr/libexec/java_home)
#export SCALA_HOME=/usr/local/Cellar/scala/2.9.2/libexec
#export JAVACMD=drip
#export DRIP_SHUTDOWN=30
export SBT_OPTS="-XX:+UseConcMarkSweepGC -XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=256M"
export MAVEN_OPTS='-Xms384M -Xmx512M -XX:MaxPermSize=256M'

export FLEX_HOME='/Applications/Adobe Flash Builder 4.6/sdks/3.6.0'

# AWS
export EC2_PRIVATE_KEY="$(/bin/ls "$HOME"/.ec2/pk-*.pem | /usr/bin/head -1)"
export EC2_CERT="$(/bin/ls "$HOME"/.ec2/cert-*.pem | /usr/bin/head -1)"
export EC2_HOME="/usr/local/Cellar/ec2-api-tools/1.6.12.0/libexec"
export AWS_CREDENTIAL_FILE="$HOME"/.ec2/aws-credential
export AWS_CLOUDFORMATION_HOME="/usr/local/Library/LinkedKegs/aws-cfn-tools/jars"
export AWS_AUTO_SCALING_HOME="/usr/local/Library/LinkedKegs/auto-scaling/jars"
export AWS_ELASTICACHE_HOME="/usr/local/Cellar/aws-elasticache/1.9.000/libexec"
export AWS_SNS_HOME="/usr/local/Library/LinkedKegs/aws-sns-cli/jars"
export AWS_CLOUDWATCH_HOME="/usr/local/Library/LinkedKegs/cloud-watch/jars"
export SERVICE_HOME="$AWS_CLOUDWATCH_HOME"
export EC2_AMITOOL_HOME="/usr/local/Library/LinkedKegs/ec2-ami-tools/jars"
export AWS_ELB_HOME="/usr/local/Cellar/elb-tools/1.0.23.0/libexec"
export AWS_RDS_HOME="/usr/local/Cellar/rds-command-line-tools/1.14.001/libexec"

# Diary config
#export DIARY_EDITOR=/Applications/Mou.app/Contents/MacOS/Mou
export DIARY_FILE=$HOME/Dropbox/diary.gpg
export DIARY_SYMMETRIC=yes

unsetopt correct_all

# LANG!
export LANG=en_US.UTF-8

