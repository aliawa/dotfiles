# .bashrc

# Source global definitions
[ -f /etc/bashrc ] && . /etc/bashrc

# use vim
export EDITOR=vim

# functions
[ -e $HOME/.bash_functions ] && . $HOME/.bash_functions

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
            alias ldir='ls -dl */'
            alias latest='ls -l -F -t | head'
            alias vi='vimx'
            alias minicom='sudo minicom -m -c on'
            ;;
      cygwin) ;; # Windows
        bsd*) ;; # BSD
           *) ;; # Unknown
esac

# System alias


# Spelling alias
alias mke='make'
alias gt='git'

# make ls sort files with dot files first
export LC_COLLATE=C

# HISTORY OPTIMIZATION
# save multiline commands as multiline (to disable:shopt -u cmdhist)
#shopt -s cmdhist
export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it


set -o vi
export TERM="xterm-256color"

# Colored man pages (see man 5 terminfo)
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[00;38;5;73m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline
export LESS_TERMCAP_so=$'\E[01;35;47m'    # standout statusbar/search -> magenta


# git
[ -f ~/bin/git-completion.bash ] && . ~/bin/git-completion.bash

# prompt
if [ -f "$HOME/.bash_prompt" ] && [[ $- == *i* ]]; then
    source "$HOME/.bash_prompt"
fi


