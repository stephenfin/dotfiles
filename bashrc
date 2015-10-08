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

PATH=$PATH:/usr/local/sbin:/usr/sbin:/sbin:/usr/local/bin:$HOME/bin

################################################################
# Aliases
################################################################

alias ls='ls --color=always'; export ls

################################################################
# Shell config
################################################################

# Enable 256 colors
if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
    export TERM='gnome-256color';
elif infocmp xterm-256color >/dev/null 2>&1; then
    export TERM='xterm-256color';
else
    export TERM='xterm-color'
fi

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

# Enable X11 forwarding
if [ -z "$DISPLAY" ]; then
    IP_ADDR=$(echo $SSH_CLIENT | awk '{{print $1}}')
    export DISPLAY=$(echo $IP_ADDR:0)
fi

# Enable sane home/pgup/pgdow/end keys
# http://askubuntu.com/a/206722
stty sane
export TERM=linux

#################################################################
# Keyboard bindings
#################################################################

#bind '"\e[A": history-search-backward'
#bind '"\e[B": history-search-forward'

################################################################
# Shell prompt
################################################################

source ~/.bash/git-prompt
source ~/.bash/git-completion
source ~/.bash/colours

# Set the terminal title to the current working directory.
PS1="\[\033]0;\w\007\]\[${bold}\]";
PS1+="\[${userStyle}\]\u"
PS1+="\[${white}\] at \[${hostStyle}\]\h"
PS1+="\[${white}\] in \[${green}\]\w"
PS1+="\$(prompt_git \"${white} on ${violet}\")\n"
PS1+="\[${white}\]\$ \[${reset}\]"
export PS1

PS2="\[${yellow}\]→ \[${reset}\]"
export PS2

# Show process name in tab title bar
#   source: http://stackoverflow.com/q/10546217

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    # don't print full PWD path:
    #   source: http://stackoverflow.com/q/1371261
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD##*/}\007"'
    ;;
*)
    ;;
esac

