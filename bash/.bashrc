#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=8000
HISTFILESIZE=8000
HISTFILE="$HOME/.bash-history"

shopt -s checkwinsize
shopt -s autocd
shopt -s globstar

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias dotenv='. env/bin/activate'
alias vi='vim'
alias json='python3 -m json.tool --no-ensure-ascii'
alias log='journalctl -u'
if rsync --version | grep zstd > /dev/null; then
    alias scp='rsync --archive --copy-links --partial --inplace --compress-choice=zstd'
else
    alias scp='rsync --archive --copy-links --partial --inplace'
fi

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

if [ -x '/usr/bin/pacman' ]; then
    alias 啊啊='sudo pacman -S'
    alias 啊='pacman -Ss'
elif [ -x '/usr/bin/apt' ]; then
    alias 啊啊='sudo apt install'
    alias 啊='apt search'
fi

if hash nvim 2> /dev/null; then
    export EDITOR='nvim'
    alias vim=nvim
    alias vi=nvim
else
    export EDITOR='vim'
    alias vi=vim
fi

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

# https://github.com/junegunn/fzf
if [[ -d '/usr/share/fzf' ]]; then
    source /usr/share/fzf/key-bindings.bash
fi

# https://github.com/cantino/mcfly
if [[ -d '/usr/share/mcfly' ]]; then
    source /usr/share/mcfly/mcfly.bash
fi

# linux brew
if [[ -d ~/.linuxbrew ]]; then
    export PATH="$HOME/.linuxbrew/bin:$PATH"
    export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
    export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
    [[ -f "$HOME/.linuxbrew/etc/openssl/certs/ca-certificates.crt" ]] && \
        export CURL_CA_BUNDLE="$HOME/.linuxbrew/etc/openssl/certs/ca-certificates.crt"
fi

# generated bash profies
if [[ -d ~/.dotfiles/bash/generated ]]; then
    for file in ~/.dotfiles/bash/generated/*; do
        source $file
    done
fi

# local bin
BIN_DIRS=".local .cargo .yarn go"
for dir in $BIN_DIRS; do
    [[ -d "$HOME/$dir/bin" ]] && export PATH="$HOME/$dir/bin:$PATH"
done

# Android
[[ -d /opt/android ]] && export ANDROID_HOME="/opt/android"

# Python
[[ -d ~/.cache/pycache ]] && export PYTHONPYCACHEPREFIX="$HOME/.cache/pycache"
. /etc/os-release
if [[ "$NAME" = "Ubuntu" ]]; then
    alias python=python3
    alias pip=pip3
    alias ipython=ipython3
fi

# Rust
[[ -x ~/.cargo/bin/sccache ]] && export RUSTC_WRAPPER="$HOME/.cargo/bin/sccache"
[[ -x /usr/bin/sccache ]] && export RUSTC_WRAPPER="/usr/bin/sccache"

# Go
[[ -x /usr/bin/go ]] && [[ -d ~/go ]] && export GOPATH="$HOME/go"

# local per-machine settings
[[ -f ~/.bash_local ]] && . ~/.bash_local

# Windows Subsystem for Linux
if [[ "`uname -r`" == *"microsoft"* ]]; then
    export LS_COLORS='tw=04;34;40:ow=04;34:';
    firefox='/mnt/c/Program Files/Mozilla Firefox/firefox.exe'
    [ -f "$firefox" ] && export BROWSER="$firefox"
    [ -f "/usr/bin/wslview" ] && export BROWSER="wslview"
    alias gpg='gpg.exe'

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

    alias dropcache='echo 1 | sudo tee /proc/sys/vm/drop_caches > /dev/null'
fi

# Rename files without typing the full name two times 
# https://gist.github.com/premek/6e70446cfc913d3c929d7cdbfe896fef
function mv() {
  if [ "$#" -ne 1 ]; then
    command mv "$@"
    return
  fi
  if [ ! -f "$1" ]; then
    command file "$@"
    return
  fi

  read -ei "$1" newfilename
  mv -v "$1" "$newfilename"
} 

