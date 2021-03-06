#!/bin/bash

# create symlinks from the home directory to dotfiles in ~/dotfiles

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dotfiles="vimrc vim inputrc bashrc bash next_review hgrc gitconfig gitignore tmux.conf"
packages="vim"

# ensure all required packages have been installed
for package in $packages; do
    if ! command -v $package >/dev/null 2>&1; then
        echo "You need to install $package"
        exit 1
    fi
done

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

# symlink dotfiles to the home dir, each prefixed by a dot (.)
for file in $dotfiles; do
    src="$dir/$file"
    dst="$HOME/.$file"

    rm -rf "$dst"
    ln -s "$src" "$dst"
    echo "Created $dst"
done

# symlink configfiles to the home dir
# TODO(stephenfin): Make this generic once we synchronize more config options
src="$dir/config/sublime-text-3/Packages/User"
out="$HOME/.config/sublime-text-3/Packages/"
dst="$out/User"
mkdir -p "$out"
ln -s "$src" "$dst"
echo "Created $dst"

# set vim as default editor
update-alternatives --set editor /usr/bin/vim.basic

# install vim plugins
vim +PlugInstall +qall

# (optional) reload environment
read -p "Reload environment now? [y]es/[n]o " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    exec bash
fi
