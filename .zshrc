# User configuration
# Set up the prompt
autoload -Uz promptinit
promptinit
prompt adam1
# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

##HISTORY
setopt histignorealldups sharehistory
HISTSIZE=1000000
SAVEHIST=1000000
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history
HISTFILE=~/.zsh_history
function peco-history-selection() {
    BUFFER=`history -n 1 | tac | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N peco-history-selection
bindkey '^R' peco-history-selection


# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'


## PATH
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$PATH:$HOME/google_appengine/"
export PATH="$PATH:$HOME/src/go_appengine/"
export PATH="$PATH:$HOME/google-cloud-sdk/bin"
export PATH="$PATH:$HOME/.local/bin"

export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

JAVA_HOME=$(readlink -f /usr/bin/javac | sed "s:/bin/javac::")
export JAVA_HOME
PATH=$PATH:$JAVA_HOME/bin
export PATH


##npm
## https://github.com/sindresorhus/guides/blob/master/npm-global-without-sudo.md
NPM_PACKAGES="${HOME}/.npm-packages"
if [ ! -L ${my_link} ]; then
  ln -s $HOME/dotfiles/.npmrc $HOME/.npmrc
fi
export NODE_PATH=`npm root -g`
export PATH="$NPM_PACKAGES/bin:$PATH"

# Unset manpath so we can inherit from /etc/manpath via the `manpath` command
unset MANPATH # delete if you already modified MANPATH elsewhere in your config
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

##aliases
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
alias h='fc -lnd'


#GCP
# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then source "$HOME/google-cloud-sdk/path.zsh.inc"; fi
# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then source "$HOME/google-cloud-sdk/completion.zsh.inc"; fi


##symlinks for dotfiles
ln -fs $HOME/dotfiles/fix_some.sh $HOME/bin/fix_some.sh
ln -fs ~/dotfiles/.npmrc  $HOME/.npmrc
ln -fs ~/dotfiles/.vimrc  $HOME/.vimrc
ln -fs ~/dotfiles/.tmux.conf  $HOME/.tmux.conf
ln -fs ~/dotfiles/.gitconfig  $HOME/.gitconfig
ln -fs ~/dotfiles/.Xmodmap  $HOME/.Xmodmap

#extra
. $HOME/bin/z.sh

if [ "$HOSTNAME" = 'ub2' ];then
  echo 'trackbacll setting'
  xinput --set-prop "Logitech USB Trackball" "libinput Accel Speed" 0.9
fi
sleep 2 && xmodmap $HOME/.Xmodmap


#gcfg(){
#     configuration_name=$(gcloud config configurations list | peco | awk '{print $1}')
#    gcloud config configurations activate "${configuration_name}"
#}

#gsettings set org.gnome.desktop.peripherals.touchpad tap-and-drag false


function rprompt-git-current-branch {
  local branch_name st branch_status

  if [ ! -e  ".git" ]; then
    # the case where the directory is not managed by git
    return
  fi
  branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    # clean
    branch_status="%F{green}"
  elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
    # untracked
    branch_status="%F{red}?"
  elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
    # modified
    branch_status="%F{red}+"
  elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
    # staged
    branch_status="%F{yellow}!"
  elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
    # the case where there is some actions such as conflict
    echo "%F{red}!(no branch)"
    return
  else
    # other case
    branch_status="%F{blue}"
  fi

  echo "${branch_status}[$branch_name]"
}

##PROMPT
autoload -Uz colors
colors
setopt prompt_subst
#PROMPT='%{$fg[red]%}[%n@%j]%{$reset_color%}'
PROMPT_COMMAND='hasjobs=$(jobs -p)'
PS1='${hasjobs:+\j }\$ '
RPROMPT='`rprompt-git-current-branch`'
sleep 1 && xmodmap $HOME/.Xmodmap

ln -s $HOME/dotfiles/.ripgreprc $HOME/.ripgreprc
