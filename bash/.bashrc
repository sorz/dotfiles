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
alias dotenv='. env/bin/activate'
alias vi='vim'

export EDITOR="vim"

# For Debain, Cygwin & CentOS
[[ -f /etc/bash_completion ]] && . /etc/bash_completion
[[ -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion
[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases

# For Arch Linux
[[ -f /usr/share/doc/pkgfile/command-not-found.bash ]] && \
    . /usr/share/doc/pkgfile/command-not-found.bash

PS1='\[\e[00;32m\]\u\[\e[00m\]@\[\e[00;31m\]\h\[\e[00m\]:\[\e[00;36m\]\w\[\e[00m\]\$ '
[ -r ~/.byobu/prompt ] && . ~/.byobu/prompt   #byobu-prompt#


# Set GPG TTY
export GPG_TTY=$(tty)

# Refresh gpg-agent tty in case user switches into an X session
#gpg-connect-agent updatestartuptty /bye >/dev/null
