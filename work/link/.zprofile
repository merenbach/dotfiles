alias mbrew="brew update && brew upgrade && brew cask upgrade && brew cleanup && brew doctor"

export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="$PATH:/usr/local/opt/go/libexec/bin"
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
export GOPATH=`go env GOPATH`
. ~/.zshrc

#export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$PATH:$HOME/bin"

# [ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
# if [ -f $(brew --prefix)/etc/bash_completion ]; then
#     . $(brew --prefix)/etc/bash_completion
# fi
