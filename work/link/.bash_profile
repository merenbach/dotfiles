export PATH="/usr/local/sbin:$PATH"
export PATH="$PATH:/usr/local/opt/go/libexec/bin"
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
export GOPATH=$HOME/go
[ -f ~/.bashrc ] && . ~/.bashrc

export PATH="$HOME/.cargo/bin:$PATH"

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
