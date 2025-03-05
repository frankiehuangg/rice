#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

PS1='\n  \[\e[97;1m\]\t \[\e[22m\](\!, \#) \[\e[93;1m\]\u@\h \[\e[0;37m\]in \[\e[38;5;39;1m\]\w\n\[\e[0m\]\$ '

export PATH="$PATH:$HOME/.local/bin"
export MAKEFLAGS=-j

# CTFs related
# alias pwninit='pwninit --template-path ~/Documents/CTFs/.template/solve.py'
# alias pwnsetup='sudo docker rm --force pwn22; sudo docker run -d -p 25000:22 --name=pwn22 -v $(pwd):/CTF -v /tmp/.X11-unix:/tmp/.X11-unix pwnenv_ubuntu22'
# alias pwndocker='docker exec -w /CTF -e TERM=xterm-256color -e display=$DISPLAY -it pwn22 bash'
# export PYTHONPATH='$HOME/Documents/CTFs/.library'
