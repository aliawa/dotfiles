# .bashrc

# if not running interactively, don't do anything
[ -z "$PS1" ] && return

# get local settings
[ -f ~/.bash_local ] && source ~/.bash_local

# bash_sensible from https://github.com/mrzool/bash-sensible.git
[ -f ~/.sensible.bash ] && source ~/.sensible.bash

# Local path
export PATH=$PATH:~/bin


# set vim as default editor
export EDITOR=vim
set -o vi
export TERM="xterm-256color"


# alias 
case "$OSTYPE" in
     darwin*)  
            alias ls='ls -G'
            alias ll='ls -l -G'
            alias ldir='ls -G -dl */'
            alias l.='ls -G -d .*'
            alias latest='ls -G -l -F -t | head'
            ;;
      linux*) 
            alias ls='ls --color=auto'
            alias ll='ls -l --color=auto'
            alias ldir='ls --color=auto -dl */'
            alias l.='ls -lad .[^.]*'
            alias latest='ls -l -F -t | head'
            if [[ -e /usr/bin/vimx ]]; then 
                alias vi='vimx'
            else 
                alias vi='vim'
            fi
            alias minicom='sudo minicom -m -c on'
            alias grep='grep --color=auto'
            if [ -f ~/.dircolors-solarized/dircolors.ansi-dark ]; then
                eval `dircolors ~/.dircolors-solarized/dircolors.ansi-dark`
            fi
            ;;
      cygwin) ;; # Windows
        bsd*) ;; # BSD
           *) ;; # Unknown
esac



# make ls sort files with dot files first
export LC_COLLATE=C


# Colored man pages (see man 5 terminfo)
# mb -- begin blinking
# md -- begin bold
# me -- end mode
# se -- end standout-mode
# ue -- end underline
# us -- begin underline
# so -- standout statusbar/search -> magenta
man() {
    env \
        LESS_TERMCAP_md=$'\E[00;38;5;73m'  \
        LESS_TERMCAP_me=$'\E[0m'           \
        LESS_TERMCAP_se=$'\E[0m'           \
        LESS_TERMCAP_ue=$'\E[0m'           \
        LESS_TERMCAP_us=$'\E[04;38;5;146m' \
        LESS_TERMCAP_so=$'\E[01;35;47m'    \
        man "$@"
}


# git completion
[ -f ~/bin/git-completion.bash ] && . ~/bin/git-completion.bash

# prompt
if [ -f "$HOME/.bash_prompt" ] && [[ $- == *i* ]]; then
    source "$HOME/.bash_prompt"
fi


# Fix tmux DISPLAY env variable
if [ -n "$DISPLAY" ]; then
    for name in `tmux ls 2> /dev/null | sed 's/:.*//'`; do
        tmux setenv -g -t $name DISPLAY $DISPLAY
    done
fi

