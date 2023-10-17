#!/bin/bash

# Homebrew
if ! command -v brew > /dev/null; then
	echo "Installing Homebrew..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

	echo "Adding brew (Homebrew) to the path"
	(echo; echo "eval '$(/opt/homebrew/bin/brew shellenv)'") >> /Users/"${USER}"/.zprofile
	eval "$(/opt/homebrew/bin/brew shellenv)"
else
	echo "Homebrew is already installed."
fi

# Packages
printf "\nInstalling packages...\n"
packages=(
	git
	wget
	nvim
	tmux
	tmuxp
	stow
	exa
	bat
	htop
	wakeonlan
	ripgrep
	ripgrep-all
	fd
	npm
	fzf
)
current_packages=$(brew list --formulae)
for package in "${packages[@]}"; do
	if  echo "$current_packages" | grep -q "$package" || brew list "$package" > /dev/null 2>&1; then
		echo "$package is already installed."
	else
		brew install --formulae "$package" 
	fi
done

# Casks
printf "\nInstalling casks...\n"
casks=(
	visual-studio-code
	iterm2
	google-chrome
	onedrive
	discord
	spotify
	mos
	aldente
	hammerspoon
	appcleaner
	microsoft-word
	microsoft-powerpoint
	microsoft-excel
	blender
	jdownloader
	plex
	openvpn-connect
	notion
	mactex
	bettermouse
	the-unarchiver
)
#bitwarden # Installed via App Store to have Safari Extension
current_casks=$(brew list --cask)
for cask in "${casks[@]}"; do
	if  echo "$current_casks" | grep -q "$cask" || brew list "$cask" > /dev/null 2>&1; then
		echo "$cask is already installed."
	else
		#brew install --formulae "$cask" 
		true
	fi
done

exit
# MacOS App Store (mas)
mas_apps=(
    whatsapp
    telegram
    slack
    mattermost
    notion
    microsoft remote desktop 
)
# mas search whatsapp Desktop
# mas install 1147396723

# mas search telegram
# mas install 747648890

# mas install slack 803453959

# mas install bitwarden 1352778147

# Others

# Install Nerd Fonts
if [ ! -f "$HOME/Library/Fonts/Droid Sans Mono for Powerline Nerd Font Complete.otf" ]; then
    curl -sS https://webi.sh/nerdfont | sh
    source ~/.config/envman/PATH.env
else
	printf "\nNerdFonts already installed."
fi

# ZSH Configs
printf "\nInstalling ZSH configs...\n"

# Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "Oh My Zsh is already installed."
fi

# ZSH autosuggestions
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions ]; then
	git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions
else
  echo "zsh-autosuggestions is already installed."
fi

# ZSH syntax highlighting
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting ]; then
	echo "Installing zsh-syntax-highlighting..."
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting
else
  echo "zsh-syntax-highlighting is already installed."
fi

# CONFIG (dotfiles)

if [ ! -d "$HOME/.dotfiles" ]; then # TODO
	git clone https://github.com/neves-nvs/dotfiles "$HOME/.dotfiles"
	cd "$HOME/.dotfiles" || exit
	./install.sh
	cd "$HOME" || exit
else
	echo "dotfiles are already installed."
fi

printf "\n"

# Hamerspoon

# ControlEscape

if [ ! -d ~/.hammerspoon/Spoons/ControlEscape.spoon ]; then
	git clone https://github.com/jasonrudolph/ControlEscape.spoon.git ~/.hammerspoon/Spoons/ControlEscape.spoon
	cd ~/.hammerspoon/Spoons/ControlEscape.spoon || exit # TODO probably return do previous directory
	script/setup
	# TODO still needs
	# With one more bit of setup, you'll be able to hold caps lock for control, and tap caps lock for escape:
	# Open System Preferences, navigate to Keyboard > Modifier Keys, and set the caps lock key to control.
else
	echo "ControlEscape is already installed."
fi



# Docker

# Safari Extensions (Install using mas)
# Bitwarden
# AdBlock
# Super Agent

