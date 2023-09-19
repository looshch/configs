#!/usr/bin/env zsh

# Declare CONFIGS with its value from zsh config.
eval "$(curl -fsSL https://raw.githubusercontent.com/looshch/configs/master/.zshrc 2>&1 | grep CONFIGS=)"

# Enable Touch ID for sudo.
sudo sed -i "" $'2a\\\nauth      sufficient     pam_tid.so\n' /etc/pam.d/sudo

ED="${HOME}/.ssh/ed"
ssh-keygen -q -t ed25519 -C "looshch@loosh.ch" -f ${ED} -P ""
ssh-add -q --apple-use-keychain ${ED}
ssh-keyscan github.com >> ${HOME}/.ssh/known_hosts
pbcopy < ${ED}.pub
read -sk $'?paste into github.com/account/ssh\n'

xcode-select --install

mkdir -p ${CONFIGS}
git clone git@github.com:looshch/configs.git ${CONFIGS}
ln -sf ${CONFIGS}/.zshrc ${HOME}/.zshrc
ln -sf ${CONFIGS}/.gitconfig ${HOME}/.gitconfig
ln -sf ${CONFIGS}/sshconfig ${HOME}/.ssh/config
mkdir -p ${HOME}/.config/nvim/
ln -sf ${CONFIGS}/nvim.lua ${HOME}/.config/nvim/init.lua

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
export PATH="${PATH}:/opt/homebrew/bin"
chmod -R go-w '/opt/homebrew/share/zsh'
FPATH="$(brew --prefix)/share/zsh-completions:${FPATH}"
autoload -Uz compinit
compinit
rm -f ~/.zcompdump
compaudit | xargs chmod g-w
BREW_PACKAGES=(
	zsh-completions
	n
	go
	rbenv
	fzf
	ripgrep
	fd
	neovim
	tree-sitter
	docker
	docker-compose
)
BREW_CASKS=(
	iterm2
	google-chrome
	firefox
	insomnia
	telegram
	gimp
	docker
	font-ubuntu-mono-nerd-font
)
brew tap homebrew/cask-fonts
brew install ${BREW_PACKAGES[@]}
brew install --cask ${BREW_CASKS[@]}
brew completions link
brew autoremove
brew untap homebrew/core
brew untap homebrew/cask
brew cleanup --prune=all

$(brew --prefix)/opt/fzf/install

n latest
