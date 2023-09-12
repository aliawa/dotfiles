# .bashrc

# if not running interactively, don't do anything
[ -z "$PS1" ] && return

# ----------------------------------------------------------------------
# Basic settings
# ----------------------------------------------------------------------

# bash_sensible -> https://github.com/mrzool/bash-sensible.git
[ -f ~/Tools/bash-sensible/sensible.bash ] && source ~/Tools/bash-sensible/sensible.bash

# RUPA/z -> https://github.com/rupa/z
[ -f ~/Tools/z/z.sh ] && source $HOME/Tools/z/z.sh

# disable terminal flow control (Ctrl-S, Ctrl-Q)
stty -ixon 

# A function to avoid adding duplicate or non-existent directories to PATH
addToPath() {
    if [ -d "$1" ] ; then
        [[ ":$PATH:" != *":$1:"* ]] && export PATH="$1:${PATH}"
    fi
}
addToPath $HOME/pan/pan_bin
addToPath $HOME/bin
export PATH


# ----------------------------------------------------------------------
# Linux Alias
# ----------------------------------------------------------------------
alias ls='ls --color=auto'
alias ll='ls -l --color=auto'
alias ldir='ls --color=auto -dl */'
alias l.='ls -lad --group-directories-first .[^.]*'
alias latest='ls -l -F -t | head'
if [[ -e /usr/bin/vimx ]]; then 
    alias vi='vimx'
else 
    alias vi='vim'
fi
alias minicom='sudo minicom -m -c on'
alias grep='grep --color=auto'
alias info='info --vi-keys'


# ----------------------------------------------------------------------
# exports
# ----------------------------------------------------------------------
export EDITOR=vim             # set vim as default editor
export TERM="xterm-256color"
export LC_COLLATE=C           # make ls sort files with dot files first


# ----------------------------------------------------------------------
# custom colors
# ----------------------------------------------------------------------
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



# Colored ls output -> https://github.com/seebi/dircolors-solarized
if [ -f ~/Tools/dircolors-solarized/dircolors.ansi-dark ]; then
    eval `dircolors ~/Tools/dircolors-solarized/dircolors.ansi-dark`
fi


# ----------------------------------------------------------------------
# fuzzy finder
# ----------------------------------------------------------------------
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export FZF_DEFAULT_COMMAND='if [ -f gtags.files ]; then cat gtags.files; else fd --type f; fi' 
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}


# ----------------------------------------------------------------------
# Tmux
# ----------------------------------------------------------------------
# Fix tmux DISPLAY env variable (?? Why ??)
if [ -n "$DISPLAY" ]; then
    for name in `tmux ls 2> /dev/null | sed 's/:.*//'`; do
        tmux setenv -g -t $name DISPLAY $DISPLAY
    done
fi


# ----------------------------------------------------------------------
# Local settings
# ----------------------------------------------------------------------
[ -f ~/.bash_local ] && source ~/.bash_local


