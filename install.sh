#!/bin/bash
cd ~/.dotfiles
T=`stat -c %Y install.sh`
git pull
if [ $T != `stat -c %Y install.sh` ]; then
    exec ./install.sh
fi

# Git
ln -svf ~/.dotfiles/git/.gitconfig ~
ln -svf ~/.dotfiles/git/.gitattributes ~

# Mintty
if [ "$TERM" = "xterm" ]; then
    ln -svf ~/.dotfiles/mintty/.minttyrc ~
fi

# Cache dir
mkdir -pm 700 ~/.cache
touch ~/.cache/.nobackup

# Bash
ln -svf ~/.dotfiles/bash/.bashrc ~
BASHD="$HOME/.dotfiles/bash/generated"
mkdir -p $BASHD
touch -a "$BASHD/empty"

# Python
mkdir -p ~/.cache/pycache
if hash pip 2> /dev/null; then
    pip completion --bash > $BASHD/pip_completion
fi

# GnuPG
mkdir -p ~/.gnupg
chmod 700 ~/.gnupg
ln -svf ~/.dotfiles/gnupg/gpg-agent.conf ~/.gnupg/
ln -svf ~/.dotfiles/gnupg/gpg.conf ~/.gnupg/

# Byobu
if [ -d "$HOME/.byobu" ]; then
    ln -svf ~/.dotfiles/byobu/.tmux.conf ~/.byobu/
fi

# Vim
ln -svf ~/.dotfiles/vim/.vimrc ~
mkdir -pm 700 ~/.cache/vim
PLUG="$HOME/.vim/autoload/plug.vim"
PLUGURL="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
if [ -f "$PLUG" ]; then
    echo update curl -Lo $PLUG -z $PLUG $PLUGURL
    curl -Lo $PLUG -z $PLUG $PLUGURL
else
    echo install curl -Lo $PLUG --create-dirs $PLUGURL
    curl -Lo $PLUG --create-dirs $PLUGURL
fi
vim +PlugUpdate! +qall

# neovim
if hash nvim 2> /dev/null; then
    ln -svf ~/.dotfiles/nvim ~/.config/nvim
    mkdir -pm 700 ~/.cache/nvim
    nvim +PlugUpdate! +qall
fi
