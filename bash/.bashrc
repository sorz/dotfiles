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

PS1='[\u@\h \W]\$ '
[ -r ~/.byobu/prompt ] && . ~/.byobu/prompt   #byobu-prompt#
