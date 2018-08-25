# .bash_profile

# These are normally set through /etc/login.conf.  You may override them here
# if wanted.
# PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:$HOME/bin; export PATH
# BLOCKSIZE=K;	export BLOCKSIZE
PATH=$PATH:$HOME/go/bin:$HOME/.cabal/bin

# Setting TERM is normally done through /etc/ttys.  Do only override
# if you're sure that you'll never log in via telnet or xterm or a
# serial line.
# TERM=xterm; 	export TERM

EDITOR=vim;   	export EDITOR
PAGER=less;  	export PAGER
CLICOLOR=1;	export CLICOLOR

# set ENV to a file invoked each time sh is started for interactive use.
if [ -x /usr/bin/fortune ] ; then /usr/bin/fortune freebsd-tips ; fi

# Get the aliases and functions
[ -f $HOME/.bashrc ] && . $HOME/.bashrc
