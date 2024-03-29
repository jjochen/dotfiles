# Fig pre block. Keep at the top of this file.
# [[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && . "$HOME/.fig/shell/zshrc.pre.zsh"
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

#ZSH_THEME="af-magic"
ZSH_THEME="steeef"

export UPDATE_ZSH_DAYS=7

plugins=(
  git
  bundler
  pod
  brew
  macos
  colorize
  git-flow
  github
  gpg-agent
  ssh-agent
  textmate
  virtualenv
  extract
  rake
  ansible
  chruby
  iterm2
)

source $ZSH/oh-my-zsh.sh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Customize to your needs...

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

ulimit -S -n 2048

export FASTLANE_USER=apple@jochen-pfeiffer.com
export KALEIDOSCOPE_DIR=${HOME}/coden/kaleidoscope/Kaleidoscope-Bundle-Keyboardio/avr/libraries/Kaleidoscope

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

fpath=(/opt/homebrew/share/zsh-completions $fpath)

#autoload -U up-line-or-beginning-search
#autoload -U down-line-or-beginning-search
#zle -N up-line-or-beginning-search
#zle -N down-line-or-beginning-search
#bindkey "^[[A" up-line-or-beginning-search # Up
#bindkey "^[[B" down-line-or-beginning-search # Down

function AddToPath ()
# Add argument to $PATH if:
# - it is not already present
# - it is a directory
# - we have execute permission on it
#
{
  _folder=$1
  echo " $PATH " | sed 's/:/ /g' | grep " $_folder " > /dev/null
  [ $? -ne 0 ] && [ -d $_folder ] && [ -x $_folder ] && PATH=$PATH:$_folder
  export PATH
}

function AddPathTo ()
# Add argument to $PATH if:
# - it is not already present
# - it is a directory
# - we have execute permission on it
{
  _folder=$1
  echo " $PATH " | sed 's/:/ /g' | grep " $_folder " > /dev/null
  [ $? -ne 0 ] && [ -d $_folder ] && [ -x $_folder ] && PATH=$_folder:$PATH
  export PATH
}

AddPathTo "$HOME/.fvm/default/bin"
AddPathTo "/opt/homebrew/sbin"
AddPathTo "/opt/homebrew/bin"
AddPathTo "/usr/texbin"
AddPathTo "/Library/TeX/texbin"
AddToPath "$HOME/bin"
AddToPath "$HOME/.pub-cache/bin"
AddToPath "$HOME/Library/Android/sdk/emulator"
AddToPath "$HOME/Library/Android/sdk/tools"
AddToPath "$HOME/Library/Android/sdk/platform-tools"
AddToPath "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
AddToPath "/usr/bin"
AddToPath "/usr/sbin"
AddToPath "/bin"
AddToPath "/sw/bin"
AddToPath "/sw/sbin"
AddToPath "/sbin"
AddToPath "$HOME/.pub-cache/bin"


export JAVA_8_HOME=$(/usr/libexec/java_home -v1.8)
export JAVA_11_HOME=$(/usr/libexec/java_home -v11)

alias java8='export JAVA_HOME=$JAVA_8_HOME'
alias java11='export JAVA_HOME=$JAVA_11_HOME'

# default to Java 11
java11


function clang-format-ios {
    echo "\Clang-Format all files in current dir except ones in */libs/* folder and names containing *.framework.*\n\n"
    find . -name "*.[hm]" ! -path "*/libs/*" ! -path "*.framework*" ! -path "*/Pods/*" -print0 | xargs -0 clang-format -i
    echo "\nDONE\n"
}


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
test -e "${HOMEBREW_DIR}/share/chruby/chruby.sh" && source "${HOMEBREW_DIR}/share/chruby/chruby.sh"
test -e "${HOMEBREW_DIR}/share/chruby/auto.sh" && source "${HOMEBREW_DIR}/share/chruby/auto.sh"
test -e ~/.aliases && source ~/.aliases
test -e "${HOME}/.zshrc.local" && source "${HOME}/.zshrc.local"
test -e ~/.fastlane/completions/completion.sh && source ~/.fastlane/completions/completion.sh

eval "$(zoxide init zsh)"

zstyle :omz:plugins:ssh-agent identities id_rsa github_rsa

unalias gm

# Fig post block. Keep at the bottom of this file.
# [[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && . "$HOME/.fig/shell/zshrc.post.zsh"
## [Completion] 
## Completion scripts setup. Remove the following line to uninstall
[[ -f /Users/jochen/.dart-cli-completion/zsh-config.zsh ]] && . /Users/jochen/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

# source <(pkgx --shellcode)  #docs.pkgx.sh/shellcode

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
