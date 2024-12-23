#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

PS1='\n  \[\e[97;1m\]\t \[\e[22m\](\!, \#) \[\e[93;1m\]\u@\h \[\e[0;37m\]in \[\e[38;5;39;1m\]\w\n\[\e[0m\]\$ '

export PATH="$PATH:$HOME/.local/bin"
