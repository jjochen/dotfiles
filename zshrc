# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

#ZSH_THEME="af-magic"
ZSH_THEME="steeef"

export UPDATE_ZSH_DAYS=7

plugins=(git bundler pod osx colorize git-flow git-remote-branch github gpg-agent ssh-agent textmate svn virtualenv extract rake)

source $ZSH/oh-my-zsh.sh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Customize to your needs...

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

fpath=(/usr/local/share/zsh-completions $fpath)

#autoload -U up-line-or-beginning-search
#autoload -U down-line-or-beginning-search
#zle -N up-line-or-beginning-search
#zle -N down-line-or-beginning-search
#bindkey "^[[A" up-line-or-beginning-search # Up
#bindkey "^[[B" down-line-or-beginning-search # Down

AddToPath ()
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

AddPathTo ()
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

#AddPathTo "$HOME/.rvm/bin"
AddPathTo "/opt/local/sbin"
AddPathTo "/opt/local/bin"
AddPathTo "/usr/local/bin"
AddPathTo "/usr/texbin"
AddPathTo "/Library/TeX/texbin"
AddToPath "$HOME/bin"
AddToPath "/usr/local/texlive/2012"
AddToPath "/usr/bin"
AddToPath "/usr/sbin"
AddToPath "/bin"
AddToPath "/sw/bin"
AddToPath "/sw/sbin"
AddToPath "/sbin"
AddToPath "/usr/bin/X11"
AddToPath "/usr/X11R6/bin"
AddToPath "/usr/games"


function clang-format-ios {
    echo "\Clang-Format all files in current dir except ones in */libs/* folder and names containing *.framework.*\n\n"
    find . -name "*.[hm]" ! -path "*/libs/*" ! -path "*.framework*" ! -path "*/Pods/*" -print0 | xargs -0 clang-format -i
    echo "\nDONE\n"
}

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

eval "$(fasd --init auto)"

test -e /usr/local/share/chruby/chruby.sh && source /usr/local/share/chruby/chruby.sh
test -e /usr/local/share/chruby/auto.sh && source /usr/local/share/chruby/auto.sh
test -e ~/.aliases && source ~/.aliases
test -e "${HOME}/.zshrc.local" && source "${HOME}/.zshrc.local"
test -e ~/.fastlane/completions/completion.sh && source ~/.fastlane/completions/completion.sh

zstyle :omz:plugins:ssh-agent identities id_rsa github_rsa

unalias gm

