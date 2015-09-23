# .bashrc

# if not running interactively, don't do anything
[ -z "$PS1" ] && return

# get local settings
[ -f ~/.bash_local ] && source ~/.bash_local

# Local path
export PATH=$PATH:~/bin


# set vim as default editor
export EDITOR=vim
set -o vi
export TERM="xterm-256color"


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
            alias ldir='ls --color=auto -dl */'
            alias latest='ls -l -F -t | head'
            alias vi='vimx'
            alias minicom='sudo minicom -m -c on'
            alias grep='grep --color=auto'
            ;;
      cygwin) ;; # Windows
        bsd*) ;; # BSD
           *) ;; # Unknown
esac



# make ls sort files with dot files first
export LC_COLLATE=C

# HISTORY OPTIMIZATION
# save multiline commands as multiline (to disable:shopt -u cmdhist)
#shopt -s cmdhist
export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it



# Colored man pages (see man 5 terminfo)
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[00;38;5;73m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline
export LESS_TERMCAP_so=$'\E[01;35;47m'    # standout statusbar/search -> magenta

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


# git completion
[ -f ~/bin/git-completion.bash ] && . ~/bin/git-completion.bash

# prompt
if [ -f "$HOME/.bash_prompt" ] && [[ $- == *i* ]]; then
    source "$HOME/.bash_prompt"
fi


# work specific
export P4DIFF=vimdiff
export P4EDITOR=vim


