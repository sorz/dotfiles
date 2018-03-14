#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=8000
HISTFILESIZE=8000

shopt -s checkwinsize
shopt -s autocd

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias dotenv='. env/bin/activate'
alias vi='vim'
alias json='python -m json.tool'

if which systemctl > /dev/null 2>&1; then
    alias sys='sudo systemctl'
    syses() {
        sudo systemctl enable $@ && \
        sudo systemctl start $@ && \
        sudo systemctl status $@
    }
    sysds() {
        sudo systemctl disable $@ && \
        sudo systemctl stop $@
    }
fi

啊啊啊() {
    if [ -x '/usr/bin/pacman' ]; then
        sudo pacman -Syu
    elif [ -x '/usr/bin/apt' ]; then
        sudo apt update && sudo apt upgrade
    fi
}

export EDITOR="vim"

# For Debain, Cygwin & CentOS
[[ -f /etc/bash_completion ]] && . /etc/bash_completion
[[ -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion
[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases

# For Arch Linux
[[ -f /usr/share/doc/pkgfile/command-not-found.bash ]] && \
    . /usr/share/doc/pkgfile/command-not-found.bash

export PROMPT_DIRTRIM=3
PS1='\[\e[00;32m\]\u\[\e[00m\]@\[\e[00;31m\]\h\[\e[00m\]:\[\e[00;36m\]\w\[\e[00m\]\$ '
[ -r ~/.byobu/prompt ] && . ~/.byobu/prompt   #byobu-prompt#

# bind the up and down arrow keys to search
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Set GPG TTY
export GPG_TTY=$(tty)

# Refresh gpg-agent tty in case user switches into an X session
#gpg-connect-agent updatestartuptty /bye >/dev/null

# Sync bash history
# http://unix.stackexchange.com/questions/1288/
#   preserve-bash-history-in-multiple-terminal-windows
_bash_history_sync() {
  builtin history -a         #1
  HISTFILESIZE=$HISTSIZE     #2
  builtin history -c         #3
  builtin history -r         #4
}

history() {                  #5
  _bash_history_sync
  builtin history "$@"
}

PROMPT_COMMAND=_bash_history_sync

# linux brew
if [[ -d ~/.linuxbrew ]]; then
    export PATH="$HOME/.linuxbrew/bin:$PATH"
    export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
    export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
    [[ -f "~/.linuxbrew/etc/openssl/certs/ca-certificates.crt" ]] && \
        export CURL_CA_BUNDLE="$HOME/.linuxbrew/etc/openssl/certs/ca-certificates.crt"
fi

# local bin
[[ -d ~/.local/bin ]] && export PATH="$HOME/.local/bin:$PATH"
[[ -d ~/.cargo/bin ]] && export PATH="$HOME/.cargo/bin:$PATH"

# local per-machine settings
[[ -f ~/.bash_local ]] && . ~/.bash_local

# Windows Subsystem for Linux
if [[ "`uname -r`" == *"Microsoft" ]]; then
    export LS_COLORS='tw=04;34;40:ow=04;34:';
    export BROWSER='/mnt/c/Program Files/Mozilla Firefox/firefox.exe'

    # Set title on terminal
    # https://unix.stackexchange.com/a/341277
    function _set_window_title() {
        printf "\033]0;$USER@$HOSTNAME (WSL)\007"
    }
    _set_window_title
    function ssh() {
        /usr/bin/ssh "$@"
        _set_window_title
    }
    function mosh() {
        /usr/bin/mosh "$@"
        _set_window_title
    }
fi

