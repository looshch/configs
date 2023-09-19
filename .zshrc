export PS1="%1~ %# "

export N_PREFIX="${HOME}/.n"
export   GOPATH="${HOME}/.go"
export GEM_HOME="${HOME}/.gem"
export     PATH="${PATH}:${N_PREFIX}/bin:${GOPATH}/bin:${GEM_HOME}/gems"
CONFIGS="${HOME}/Projects/configs"
export   EDITOR="v"

alias cdd="cd ${HOME}/dev"
alias cdc="cd ${CONFIGS}"
alias cdp="cd ${HOME}/Projects"
alias v="nvim"
alias g="git"
alias l="ls -AlFh"
alias q="exit"
alias uz="v ${HOME}/.zshrc && source ${HOME}/.zshrc"
alias uv="v ${HOME}/.config/nvim/init.lua"
alias ug="v ${HOME}/.gitconfig"
alias us="v ${CONFIGS}/setup.sh"
alias ub="brew update \
          && brew upgrade \
          && brew autoremove \
          && brew cleanup --prune=all"
alias bi="brew install"

export HISTSIZE=100000

FPATH="$(brew --prefix)/share/zsh-completions:${FPATH}"
autoload -Uz compinit
compinit
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(rbenv init - zsh)"

export KITMAN_DEV_HOME=/Users/l/dev

alias kl="kitman lde"
alias ys="yarn start"
alias yj="yarn jest"
alias ow="op whoami"
alias os="op signin"
