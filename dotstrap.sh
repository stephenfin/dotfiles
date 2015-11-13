#!/bin/bash

# create symlinks from the home directory to dotfiles in ~/dotfiles

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dotfiles="vimrc vim inputrc bashrc bash next_review"

# download submodules
git submodule init

function cdiff() {
    diff -u $@ | sed "s/^-/\x1b[31m-/;s/^+/\x1b[32m+/;s/^@/\x1b[34m@/;s/$/\x1b[0m/"
}

# symlink dotfiles to the the home dir, each prefixed by a dot (.)
for file in $dotfiles; do
    src="$dir/$file"
    dst="$HOME/.$file"

    if [ -e "$dst" ]; then
        echo "WARNING! File already exists. Here's a comparison:"
        echo
        cdiff "$dst" "$src"
        read -p "Do you wish to overwrite file? ([y]es/[n]o) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "Skipping this file"
            continue
        fi
    fi

    rm -rf "$dst"
    ln -s "$src" "$dst"
    echo "Created $dst"
done

read -p "Reload environment now? [y]es/[n]o " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    exec bash
fi

