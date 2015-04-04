# PROMPT='[%n@%m]# '
PROMPT='%K{blue}%n@%m%k %B%F{cyan}%(4~|...|)%3~%F{white} %# %b%f%k'
# RPROMPT='[%d]'
autoload -Uz promptinit
promptinit
prompt adam1
 
# completion
autoload -Uz compinit
compinit
setopt correct

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

HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups
setopt share_history
setopt auto_pushd
setopt pushd_ignore_dups

source $HOME/.nvm/nvm.sh

# alias
alias ll='ls -alF --color=auto'

# prepare PATH
EXPORTS+=($PATH)
EXPORTS+=("$HOME/bin")
export PATH="$(IFS=:; echo "${EXPORTS[*]}")"

source $HOME/.zshrc.include
