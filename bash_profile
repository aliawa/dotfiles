# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/bin:.:$HOME/project/bin
PATH=$PATH:/usr/local/brecis/bin
PATH=$PATH:/usr/local/i686-linux/bin
PATH=$PATH:/usr/local/powerpc-linux/bin
PATH=$PATH:/rsdk/bin

if [ "$DEV_VER" = "" ]; then
    export DEV_VER=".ali"
fi

export PATH
unset USERNAME
