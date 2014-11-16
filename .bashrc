## .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Variables
PATH=$PATH:/usr/local/sbin:/usr/sbin:/sbin:/usr/local/bin:$HOME/bin

# Aliases
export LANG=en_US.UTF-8
export HISTSIZE=5000
alias ls='ls --color=always'; export ls

# Show git path
source ~/.bash/git-prompt
source ~/.bash/git-completion
PS1='\[\e[0;32m\]\u@\h \[\e[0;33m\]\w\[\e[0;36m\]$(__git_ps1 " (%s)")\n\[\e[m\]$ '

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

# Enable 256 colors
if [ -e /usr/share/terminfo/x/xterm-256color ]; then
    export TERM='xterm-256color'
else
    export TERM='xterm-color'
fi

# Enable UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

#SHELL=/bin/bash
