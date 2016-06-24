#!/bin/bash

#
# This script creates symlinks from the home directory to any 
# desired dotfiles in ~/dotfiles
#

# --------------------------------------------------------------
# Configuration
# --------------------------------------------------------------
DOT_DIR=~/dotfiles           
OLD_DOT_DIR=~/dotfiles_old       # old dotfiles backup directory


# --------------------------------------------------------------
# Dot Files to symlink
# --------------------------------------------------------------
files="bashrc bash_profile bash_prompt sensible.bash"
files="$files vimrc vim"  
files="$files gitconfig gitignore gitmessage.txt"
files="$files tmux.conf tmux"


# --------------------------------------------------------------
# Main
# --------------------------------------------------------------
echo

# Create Backup directory
if [ -d $OLD_DOT_DIR ]; then
    echo -e "Using \033[1m$OLD_DOT_DIR\033[0m for backup of existing dotfiles"
else
    echo -e "Creating \033[1m$OLD_DOT_DIR\033[0m for backup of existing dotfiles"
    mkdir -p $OLD_DOT_DIR
fi

# Create symlinks
for file in $files; do
    if [ -h ~/.$file ]; then
        if [[ "$(dirname $(readlink ~/.$file))" == "$DOT_DIR" ]]; then
            echo -e "\033[1m.$file\033[0m -- Already symlinked. Skipping"
            continue
        else 
            rm ~/.$file
        fi

    fi
    [[ -f ~/.$file || -d ~/.$file ]] && mv ~/.$file $OLD_DOT_DIR
    echo -e "\033[1m.$file\033[0m -- Symlinked"
    ln -s $DOT_DIR/$file ~/.$file
done

echo 

