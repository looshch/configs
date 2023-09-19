export PS1="%1~ %# "

export N_PREFIX="${HOME}/.n"; PATH+=":${N_PREFIX}/bin"
export EDITOR="v"
export RIPGREP_CONFIG_PATH="${HOME}/Projects/configs/.rgrc"
export MANPAGER="nvim +Man!"

CONFIGS="${HOME}/Projects/configs"

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
alias ut="v ${HOME}/.config/ghostty/config"
alias ub="brew update \
	&& brew upgrade \
	&& brew upgrade --cask \
	&& brew autoremove \
	&& brew cleanup --prune=all"
alias bi="brew install"

export HISTSIZE=1000000

FPATH="/opt/homebrew/share/zsh-completions:${FPATH}"
autoload -Uz compinit
compinit -C
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

PAM_TID="pam_tid.so"
PAM_CONFIG="/etc/pam.d/sudo"
if ! grep -q "${PAM_TID}" "${PAM_CONFIG}"; then
	# Enable Touch ID for sudo.
	sudo sed -i "" $'2a\\\nauth       sufficient     '"${PAM_TID}"$'\n' \
		"${PAM_CONFIG}"
fi

alias p="git diff head --name-only | xargs -r npx prettier --prose-wrap=always \
	--single-quote --write"
alias ys="yarn start"
alias yj="yarn jest"

ysas() {
	ys https://admin.staging.injuryprofiler.net \
		"$(op read 'op://Employee/Injuryprofiler/username')" \
		"$(op read 'op://Employee/Injuryprofiler/password')" \
		$1
}

ysap() {
	ys https://admin.injuryprofiler.com
		"$(op read 'op://Employee/Injuryprofiler/username')" \
		"$(op read 'op://Employee/Injuryprofiler/password')" \
		$1
}
