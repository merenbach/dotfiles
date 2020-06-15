# User specific aliases and functions

# be paranoid
alias cp='cp -ip'
alias mv='mv -i'
alias rm='rm -i'

# search path for go
GOPATH=$HOME/go

# Source global definitions
if [ -f /etc/zshrc ]; then
	. /etc/zshrc
fi

#fpath=(/usr/local/share/zsh-completions $fpath)
#if type brew &>/dev/null; then
#  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
#
#  autoload -Uz compinit
#  compinit
#fi


# User specific environment
PATH="$HOME/.local/bin:$HOME/bin:$PATH"
export PATH

. /usr/local/etc/profile.d/z.sh