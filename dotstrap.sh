#!/bin/bash

# create symlinks from the home directory to dotfiles in ~/dotfiles

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dotfiles="vimrc vim inputrc bashrc bash next_review hgrc gitconfig"

# download submodules
git submodule update --init --recursive

# backup existing dotfiles
for file in $dotfiles; do
    src="$HOME/.$file"
    dst="$HOME/.olddot/$(date +%s)/.$file"

    mkdir -p "$HOME/.olddot/$(date +%s)"

    if [ -e "$src" ]; then
        echo "Backing up existing file: .$file"
        cp -rf "$src" "$dst"
    fi
done

# symlink dotfiles to the the home dir, each prefixed by a dot (.)
for file in $dotfiles; do
    src="$dir/$file"
    dst="$HOME/.$file"

    rm -rf "$dst"
    ln -s "$src" "$dst"
    echo "Created $dst"
done

# install vim plugins
vim +PluginInstall +qall

# (optional) reload environment
read -p "Reload environment now? [y]es/[n]o " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    exec bash
fi

