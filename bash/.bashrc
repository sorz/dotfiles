#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=2000
HISTFILESIZE=4000

shopt -s checkwinsize

alias ls='ls --color=auto'
alias grep='grep --color=auto'

export EDITOR="vim"

# For Debain & Cygwin
[[ -f /etc/bash_completion ]] && . /etc/bash_completion
[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases

PS1='\[\e[00;32m\]\u\[\e[00m\]@\[\e[00;31m\]\h\[\e[00m\]:\[\e[00;36m\]\w\[\e[00m\]\$ '
[ -r ~/.byobu/prompt ] && . ~/.byobu/prompt   #byobu-prompt#
