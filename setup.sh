#!/bin/zsh

fancy_echo() {
	local fmt="$1"; shift
	printf "\n$fmt\n" "$@"
}

set -e


# install xcode command line tools
if ! command -v xcodebuild >/dev/null; then
	fancy_echo "Installing Xcode command line tools ..."
	xcode-select --install
	fancy_echo "Exiting for now ..."
	exit
else
	fancy_echo "Xcode command line tools already installed."
fi


# change shell to zsh
case "$SHELL" in
	*/zsh) :
	fancy_echo "zsh is already current shell."
	;;
*)
	fancy_echo "Changing to zsh ..."
	chsh -s "$(which zsh)"
	;;
esac


# checkout dotfiles
dotfiles_directory="$HOME/.dotfiles"
if [ ! -d $dotfiles_directory ]; then
	fancy_echo "Checking out dotfiles repository ..."
	git clone git@github.com:jjochen/dotfiles.git "$dotfiles_directory"
else 
	fancy_echo "Dotfiles directory already exists."
fi


# install homebrew
if ! command -v brew >/dev/null; then
	fancy_echo "Installing Homebrew ..."
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
	fancy_echo "Homebrew already installed."
fi


# bundle Brewfile
fancy_echo "Installing formulas and casks from the Brewfile ..."
if brew bundle --file="$dotfiles_directory/Brewfile"; then
	fancy_echo "All formulas and casks were installed successfully."
else
	fancy_echo "Some formulas or casks failed to install."
fi


# link dotfiles
fancy_echo "Linking dotfiles ..."
rcup -v


# install ruby
latest_installed_ruby() {
	find "$HOME/.rubies" -maxdepth 1 -name 'ruby-*' | tail -n1 | egrep -o '\d+\.\d+\.\d+'
}

if [ -z "$(latest_installed_ruby)" ]; then
	fancy_echo 'Installing ruby ...'
	ruby-install ruby
else
	fancy_echo "ruby already installed ..."
fi


# install bundler
fancy_echo "Installing Bundler ..."
gem install bundler

fancy_echo "Configuring Bundler ..."
number_of_cores=$(sysctl -n hw.ncpu)
bundle config --global jobs $((number_of_cores - 1))


# install oh-my-zsh
oh_my_zsh_dir="$HOME/.oh-my-zsh"
if [ ! -d $oh_my_zsh_dir ]; then
	fancy_echo "Installing oh-my-zsh ..."
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
	fancy_echo "oh-my-zsh already installed."
fi


# install janus
fancy_echo "Installing janus ..."
curl -L https://bit.ly/janus-bootstrap | bash


exit 


if [ -z "$(latest_installed_ruby)" ]; then
	fancy_echo 'Installing latest ruby ...'
	ruby-install ruby
else
	fancy_echo 'Checking if a newer version of Ruby is available ...'

	. /usr/local/share/chruby/chruby.sh
	chruby "ruby-$(latest_installed_ruby)"

	ruby-install --latest > /dev/null
	latest_stable_ruby="$(cat < "$HOME/.cache/ruby-install/ruby/stable.txt" | tail -n1)"

	if ! [ "$latest_stable_ruby" = "$(latest_installed_ruby)" ]; then
		fancy_echo "Installing latest stable Ruby version: $latest_stable_ruby"
		ruby-install ruby
	else
		fancy_echo 'You have the latest version of Ruby'
	fi
fi