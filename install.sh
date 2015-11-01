#!/bin/bash

ln -sv ~/.dotfiles/vim/.vimrc ~
mkdir -p ~/.vim/.tmp
chmod og-rwx ~/.vim/.tmp
if [ ! -e ~/.vim/bundle/Vundle.vim ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git \
        ~/.vim/bundle/Vundle.vim
fi
vim +PluginInstall +qall

ln -sv ~/.dotfiles/git/.gitconfig ~

if [ "$TERM" = "xterm" ]; then
    ln -sv ~/.dotfiles/mintty/.minttyrc ~
fi
