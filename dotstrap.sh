#!/bin/bash

# create symlinks from the home directory to dotfiles in ~/dotfiles

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dotfiles="bashrc bash devcontainer gitconfig gitconfig-redhat gitconfig-personal gitignore inputrc tmux.conf vimrc vim"
packages="vim diff less awk"
backup_dir=""

# GNU diff does not colour side-by-side output, even with --color=always.
# Expand tabs so awk can identify the fixed-position gutter reliably.
show_diff() {
    local width="${COLUMNS:-160}"
    LC_ALL=C diff --recursive --side-by-side --expand-tabs --width="$width" -- "$1" "$2" |
        LC_ALL=C awk -v width="$width" '
            BEGIN {
                gutter = int((width + 1) / 2)
                red = "\033[31m"; green = "\033[32m"
                cyan = "\033[36m"; reset = "\033[0m"
            }
            /^(diff |Only in |Binary files |File |Symbolic links )/ {
                print cyan $0 reset
                next
            }
            {
                marker = substr($0, gutter, 1)
                if (marker == "|")
                    print red substr($0, 1, gutter - 1) reset cyan marker reset green substr($0, gutter + 1) reset
                else if (marker == "<" || marker == "\\")
                    print red $0 reset
                else if (marker == ">" || marker == "/")
                    print green $0 reset
                else
                    print
            }
        ' | less -R -S
}

# Preview and confirm replacements, preserving the existing entry before linking.
deploy_link() {
    local src="$1" dst="$2" reply backup

    if [ ! -e "$src" ]; then
        echo "Source does not exist: $src" >&2
        return 1
    fi

    if [ -L "$dst" ] && [ "$(readlink -- "$dst")" = "$src" ]; then
        echo "Already linked: $dst"
        return 0
    fi

    if [ -e "$dst" ] || [ -L "$dst" ]; then
        if diff --recursive --brief -- "$dst" "$src" >/dev/null; then
            echo "Contents are identical: $dst (can be replaced with a symlink)."
        else
            # Status 1 means differences; other statuses indicate a comparison error.
            if [ "$?" -ne 1 ]; then
                echo "Cannot compare $dst; leaving it unchanged." >&2
                return 1
            fi
            echo "Comparing existing $dst (left/red) with $src (right/green). Press q to continue."
            # Differences and quitting the pager early are not fatal.
            show_diff "$dst" "$src"
        fi

        read -r -p "Replace $dst? [y/N] " reply
        case "$reply" in
            [Yy]|[Yy][Ee][Ss]) ;;
            *) echo "Keeping $dst"; return 0 ;;
        esac

        if [ -z "$backup_dir" ]; then
            mkdir -p "$HOME/.olddot" || return 1
            backup_dir=$(mktemp -d "$HOME/.olddot/$(date +%s).XXXXXX") || return 1
        fi
        backup="$backup_dir/${dst#"$HOME/"}"
        mkdir -p "$(dirname "$backup")" || return 1
        cp -a -- "$dst" "$backup" || return 1
        echo "Backed up $dst to $backup"
        rm -rf -- "$dst" || return 1
    fi

    mkdir -p "$(dirname "$dst")" || return 1
    ln -s -- "$src" "$dst" || return 1
    echo "Created $dst"
}

# ensure all required packages have been installed
for package in $packages; do
    if ! command -v "$package" >/dev/null 2>&1; then
        echo "You need to install $package"
        exit 1
    fi
done

# symlink dotfiles to the home dir, each prefixed by a dot (.)
for file in $dotfiles; do
    deploy_link "$dir/$file" "$HOME/.$file" || exit 1
done

# symlink config entries, except Sublime Text which needs special handling
(
    shopt -s dotglob nullglob
    for src in "$dir/config/"*; do
        file="${src##*/}"
        if [ "$file" = "sublime-text-3" ]; then
            continue
        fi
        deploy_link "$src" "$HOME/.config/$file" || exit 1
    done
) || exit 1

read -p "Do you want to install Sublime Text configuration? [y]es/[n]o " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    # install sublime text package manager
    out="$HOME/.config/sublime-text-3/Installed Packages/"
    if [ ! -f "$out/Package Control.sublime-package" ]; then
        mkdir -p "$out"
        wget "https://packagecontrol.io/Package%20Control.sublime-package" -P "$out"
        echo "Installed Package Control"
    else
        echo "Package Control already installed"
    fi

    # symlink configfiles to the home dir
    src="$dir/config/sublime-text-3/Packages/User"
    out="$HOME/.config/sublime-text-3/Packages/"
    dst="$out/User"
    deploy_link "$src" "$dst" || exit 1
fi

# set vim as default editor using the distro's supported mechanism
if [ -r /etc/os-release ]; then
    (
        # shellcheck source=/dev/null
        . /etc/os-release
        case "${ID:-}" in
            debian|ubuntu)
                sudo update-alternatives --set editor /usr/bin/vim.basic
                ;;
            fedora)
                sudo dnf install vim-default-editor --allowerasing
                ;;
        esac
    )
fi

# install vim plugins
vim +PlugInstall +qall

# (optional) reload environment
read -p "Reload environment now? [y]es/[n]o " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    exec bash
fi
