#!/usr/bin/env bash
## .bashrc

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi


#################################################################
# Variables
#################################################################

NPM_PACKAGES="$HOME/.npm-packages"

PATH="$PATH:/usr/local/sbin:/usr/sbin:/sbin:/usr/local/bin:$HOME/bin:$HOME/.local/bin:$HOME/go/bin/:$NPM_PACKAGES/bin"

# make podman use docker's config.json
REGISTRY_AUTH_FILE="$HOME/.docker/config.json"

################################################################
# Aliases
################################################################

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias dd='dd status=progress'
alias _='sudo'
alias vi=vim

function cdiff() {
    diff -u $@ | sed "s/^-/\x1b[31m-/;s/^+/\x1b[32m+/;s/^@/\x1b[34m@/;s/$/\x1b[0m/"
}
alias diff='cdiff'
alias less='less -R'

if command -v bat &> /dev/null; then
    alias cat='bat'
fi

alias qag='ag --ignore tests --python'
alias pag='ag --ignore tests --python'
alias gag='ag --ignore "*_test.go" --ignore vendor --ignore tests --ignore test --go'

function pipver() {
    curl -s https://pypi.org/rss/project/$1/releases.xml | sed -n 's/\s*<title>\([0-9.]*\).*/\1/p'
}

if [[ -x $(command -v jq) ]]; then
function jwtd() {
     jq -R 'split(".") | .[0],.[1] | @base64d | fromjson' <<< "${1}"
     echo "Signature: $(echo "${1}" | awk -F'.' '{print $3}')"
}
fi

################################################################
# Shell config
################################################################

# Enable sane home/pgup/pgdown/end keys
# http://askubuntu.com/a/206722
stty sane

# Enable UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000
HISTFILESIZE=10000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# enable X11 forwarding
if [ -z "$DISPLAY" ]; then
    IP_ADDR=$(echo $SSH_CLIENT | awk '{{print $1}}')
    export DISPLAY=$(echo $IP_ADDR:0)
fi


################################################################
# Shell prompt
################################################################

# use starship if available, but fallback to bash if not
if command -v starship &> /dev/null; then
    eval "$(starship init bash)"
else
    source ~/.bash/vcs-prompt

    PS1="\[\e[1;33m\]\u"
    PS1+="\[\e[1;37m\] at \[\e[1;31m\]\h"
    PS1+="\[\e[1;37m\] in \[\e[1;32m\]\w"
    PS1+="\$(prompt_vcs \"\e[1;37m on \e[1;35m\")\n"
    PS1+="\[\e[1;37m\]\$ \[\e[0m\]"

    PS2="\[\e[1;33m\]→ \[\e[0m\]"

    # Show process name in tab title bar
    #   source: http://stackoverflow.com/q/10546217

    # If this is an xterm set the title to user@host: dir
    case "$TERM" in
    linux|xterm*|rxvt*)
        # don't print full PWD path or HOSTNAME:
        #   source: https://stackoverflow.com/q/1371261
        #   source: https://stackoverflow.com/q/5268513
        export PROMPT_COMMAND='echo -ne "\033]0;${HOSTNAME%%.*}: ${PWD##*/}\007"'
        ;;
    screen*)
        # tmux equivalent of the above
        export PROMPT_COMMAND='echo -ne "\033k${HOSTNAME%%.*}: ${PWD##*/}\033\\" '
        ;;
    *)
        ;;
    esac
fi

###############################################################
# Additional settings
###############################################################

if [ -e ~/.bash/internals ]; then
    source ~/.bash/internals
fi
