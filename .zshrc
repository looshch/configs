PAM_TID="pam_tid.so"
PAM_CONFIG="/etc/pam.d/sudo"
if ! grep -q "${PAM_TID}" "${PAM_CONFIG}"; then
	# Enable Touch ID for sudo.
	sudo sed -i "" $'2a\\\nauth       sufficient     '"${PAM_TID}"$'\n' \
		"${PAM_CONFIG}"
fi

export PS1="%1~ %# "
export HISTSIZE=1000000
export N_PREFIX="${HOME}/.n"; PATH+=":${N_PREFIX}/bin"
export EDITOR="v"
export RIPGREP_CONFIG_PATH="${HOME}/Projects/configs/.rgrc"
export MANPAGER="nvr --remote-tab +Man! -"
export EMPTY_FILE="$(mktemp -t empty)"
export NO_FILE="/dev/null"
CONFIGS="${HOME}/Projects/configs"

for i in {1..5}; do
	alias $(printf '.%.s' {0..$i})="cd $(printf '../%.s' {1..$i})"
done
alias cdc="cd ${CONFIGS}"
alias cdp="cd ${HOME}/Projects"
alias cdot="cd ${HOME}/Projects/ops-tools"
alias cde="cd ${HOME}/Projects/ops-tools/library/emails"
alias cdps="cd ${HOME}/Projects/ops-tools/apps/purchases-support"
alias cdcs="cd ${HOME}/Projects/converse-web-sdk"
alias g="git"
alias l="ls -AlFh"
alias q="exit"
alias uz="v -w ${HOME}/.zshrc && source ${HOME}/.zshrc"
alias uv="v ${HOME}/.config/nvim/init.lua"
alias ug="v ${HOME}/.gitconfig"
alias us="v ${CONFIGS}/setup.sh"
alias ut="v ${HOME}/.config/ghostty/config"
alias ub="brew update \
	&& brew upgrade \
	&& brew upgrade --cask \
	&& brew autoremove \
	&& brew cleanup --prune=all"
alias bi="brew install"
alias p="pnpm"
alias pbw="p build:watch"

v() {
	if (( "$#" == 0 )); then nvr --remote-tab "${PWD}"
	elif [[ "$1" = "-w" ]]; then nvr --remote-tab-wait "${@:2}"
	else nvr --remote-tab "$@"; fi
}

chpwd() {
	local pwd="fnameescape('${PWD}')"
	nvr -s --remote-expr "execute('tcd ' . ${pwd} . ' | file ' . ${pwd} . \
		' (' . nvim_get_current_tabpage() .')')" > /dev/null &!
}

FPATH="/opt/homebrew/share/zsh-completions:${FPATH}"
autoload -Uz compinit
compinit -C

[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

export GPG_TTY=$(tty)

export PNPM_HOME="/Users/l/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
