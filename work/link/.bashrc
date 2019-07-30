# User specific aliases and functions

# be paranoid
alias cp='cp -ip'
alias mv='mv -i'
alias rm='rm -i'

# search path for go
GOPATH=$HOME/go

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
PATH="$HOME/.local/bin:$HOME/bin:$PATH"
export PATH
. /usr/local/etc/profile.d/z.sh
