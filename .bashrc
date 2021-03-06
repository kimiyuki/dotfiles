unset module
unset scl
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
function post_command {
  history -a
  history -c
  history -r
  last_command=`history 1| cut -c 8-|sed -e "s/^/'/;s/$/'/"`
  jobsname=$(jobs -l|sed -E 's/.* +//g')
  #$HOME/bin/bq-insert-cmd.sh $PWD "$last_command" 1>/dev/null &
}
PROMPT_COMMAND='post_command'
shopt -s histappend
export HISTSIZE=10000000
export HISTFILESIZE=20000000
export HISTTIMEFORMAT="%Y-%m-%d %T "
#export PROMPT_COMMAND="history -a"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
#shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar
\
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
export LESS='-i -M -R'
#https://superuser.com/questions/117841/get-colors-in-less-or-more
#export LESS='-R'
#export EDITOR=emacs
#export LESSOPEN='|~/lessfilter'


# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi
##https://unix.stackexchange.com/questions/35728/is-it-possible-to-customise-the-prompt-to-show-the-if-there-are-any-background-j : show (background) jobs name
if [ "$color_prompt" = yes ]; then
  PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w(\$(git branch 2>/dev/null | grep '^*' | colrm 1 2))\[\033[00m\]\j:\$jobsname\$ "
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\\j$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep -i --color=auto'
    alias fgrep='fgrep -i --color=auto'
    alias egrep='egrep -i --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alrthF'
alias s='git status --short --branch'
alias lh='tree -d -L 1'
alias la='ls -A'
alias l='ls -CF'
alias rm='rm -i'
alias locate='locate -b'
alias dirs='dirs -v'
alias 'dp=docker ps --format "table {{.Names}}\t{{.Ports}}\t{{.Status}}\t{{.Command}}"'
alias lll='find ./ -type f -not -path ".\/.git*" -printf "%T@ %p\n" -ls | sort -n | cut -d" " -f 2- | xargs -r ls -la|peco'
alias fn='cd "$(find . -type d|grep -v "\/\."|peco)"'
alias ff='find . -type f -not -path ".\/.*"|peco'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi

fi

# added by Miniconda3 4.3.21 installer
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:$HOME/google_appengine/"
export PATH="$PATH:$HOME/src/go_appengine/"
export PATH="$PATH:$HOME/google-cloud-sdk/bin"
export PATH="$PATH:$HOME/.local/bin"

#do not logout with key carelessly
set -o ignoreeof


##GO and peco 
#https://teratail.com/questions/41746
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

peco-select-history() {
    local l=$(\history |\
               sort -r -k 2|\
               uniq -1 |\
               sort -nr -k 1|\
               awk '{$1="";print}' |\
               cut -d' ' -f 2- |\
	       peco)
    local ll=$(echo $l|cut -d' ' -f3-) 
    READLINE_LINE=${ll}
    READLINE_POINT=${#l}
}
bind -x '"\C-r": peco-select-history'

gcfg(){
    configuration_name=$(gcloud config configurations list | peco | awk '{print $1}')
    gcloud config configurations activate "${configuration_name}"
}

set -o ignoreeof

#export LD_LIBRARY_PATH=/usr/lib:/usr/local/lib:/usr/lib:/usr/lib/x86_64-linux-gnu:/usr/lib/libreoffice/program

export LESS='-i -M -R'
if [ `hostname` == 'wordpress' ]; then
    export PYTHONPATH="/usr/local/python370/bin"
fi
# [[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh
#. /usr/share/autojump/autojump.sh

# If not running interactively, return
case $- in
    *i*) ;;
      *) return;;
esac
if [ -f "/google/devshell/bashrc.google" ]; then
  source "/google/devshell/bashrc.google"
fi

#http://forco.hateblo.jp/entry/2015/04/05/035621
JAVA_HOME=$(readlink -f /usr/bin/javac | sed "s:/bin/javac::")
export JAVA_HOME
PATH=$PATH:$JAVA_HOME/bin
export PATH

if [ $LOGNAME == 'chronos' ]; then
  export PAGER=/usr/local/bin/less
  # XDG Base Directory Specification Environment Variables
  # See https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html.
  export XDG_DATA_HOME=$HOME/.local/share
  export XDG_CONFIG_HOME=$HOME/.config
  export XDG_DATA_DIRS=/usr/local/share
  export XDG_CONFIG_DIRS=/usr/local/etc/xdg
  export XDG_CACHE_HOME=$HOME/.cache
  # nodebrew completion
  if [ -f /usr/local/share/nodebrew/completions/bash/nodebrew-completion ]; then
    source /usr/local/share/nodebrew/completions/bash/nodebrew-completion
  fi
  export PATH=$HOME/.nodebrew/current/bin:$PATH
  # The next line updates PATH for the Google Cloud SDK.
  if [ -f '/home/chronos/user/src/google-cloud-sdk/path.bash.inc' ]; then source '/home/chronos/user/src/google-cloud-sdk/path.bash.inc'; fi

  # The next line enables shell command completion for gcloud.
  if [ -f '/home/chronos/user/src/google-cloud-sdk/completion.bash.inc' ]; then source '/home/chronos/user/src/google-cloud-sdk/completion.bash.inc'; fi
fi

eval "$(direnv hook bash)"

. ~/bin/z.sh
# added by Anaconda3 installer
#export PATH="/home/shirai/anaconda3/bin:$PATH"
#xinput --set-prop "Logitech USB Trackball" "libinput Accel Speed" 0.9
export PYTHONPATH=/usr/lib/python3.7/site-packages
export PATH="$PATH:/opt/apache-maven-3.5.4/bin"
export PIPENV_VENV_IN_PROJECT=1
if [ $HOSTNAME == 'ub2' ];then
  echo 'trackbacll setting'
  xinput --set-prop "Logitech USB Trackball" "libinput Accel Speed" 0.9
fi

sleep 2 && xmodmap $HOME/.Xmodmap


##npm
# https://github.com/sindresorhus/guides/blob/master/npm-global-without-sudo.md
NPM_PACKAGES="${HOME}/.npm-packages"
if [ ! -L ${my_link} ]; then
  ln -s $HOME/dotfiles/.npmrc $HOME/.npmrc
fi
export NODE_PATH=`npm root -g`
export PATH="$NPM_PACKAGES/bin:$PATH"
# Unset manpath so we can inherit from /etc/manpath via the `manpath` command
unset MANPATH # delete if you already modified MANPATH elsewhere in your config
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

##symlinks for dotfiles
ln -fs $HOME/dotfiles/fix_some.sh $HOME/bin/fix_some.sh
ln -fs ~/dotfiles/.npmrc  $HOME/.npmrc
ln -fs ~/dotfiles/.vimrc  $HOME/.vimrc
ln -fs ~/dotfiles/.tmux.conf  $HOME/.tmux.conf
ln -fs ~/dotfiles/.gitconfig  $HOME/.gitconfig
ln -fs ~/dotfiles/.Xmodmap  $HOME/.Xmodmap
ln -fs ~/dotfiles_secret/vscode_user_settings.json  $HOME/.config/Code/User/settings.json


##fix trackball
if [ $HOSTNAME == 'ub2' ];then
  echo 'trackbacll setting'
  xinput --set-prop "Logitech USB Trackball" "libinput Accel Speed" 0.9
fi
##fix touchpad
if [ $HOSTNAME == 'mb2' ];then
  $HOME/bin/fix_some.sh
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.bash.inc" ]; then source "$HOME/google-cloud-sdk/path.bash.inc"; fi
# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.bash.inc" ]; then source "$HOME/google-cloud-sdk/completion.bash.inc"; fi


export C_INCLUDE_PATH=/usr/include/python3.6m/
gsettings set org.gnome.desktop.peripherals.touchpad tap-and-drag false

export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"


man(){
  env LESS_TERMCAP_mb=$'\E[01;31m' \
  LESS_TERMCAP_md=$'\E[01;38;5;74m' \
  LESS_TERMCAP_me=$'\E[0m' \
  LESS_TERMCAP_se=$'\E[0m' \
  LESS_TERMCAP_so=$'\E[38;5;246m' \
  LESS_TERMCAP_ue=$'\E[0m' \
  LESS_TERMCAP_us=$'\E[04;38;5;146m' \
  man "$@"
}

export NVM_DIR="/home/shirai/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
