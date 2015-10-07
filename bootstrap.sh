#!/bin/bash

# create symlinks from the home directory to dotfiles in ~/dotfiles

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dotfiles="vimrc inputrc bash"

# symlink dotfiles to the the home dir, each prefixed by a dot (.)
for file in $dotfiles; do
    rm -rf ~/.$file
    ln -s $dir/$file ~/.$file
done
