PROMPT='[%n@%m]# '
RPROMPT='[%d]'
 
# completion
autoload -U compinit
compinit
setopt correct
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups
setopt share_history
setopt auto_pushd
setopt pushd_ignore_dups

# alias
alias ll='ls -alF --color=auto'

# prepare PATH
PATH_ARR+=($PATH)

PATH_ARR+=("$HOME/.bin/sbt/bin")

export PATH="$(IFS=:; echo "${PATH_ARR[*]}")"

source $HOME/.nvm/nvm.sh