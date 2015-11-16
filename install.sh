#!/bin/bash
git pull

# Vim
ln -sv ~/.dotfiles/vim/.vimrc ~
mkdir -p ~/.vim/.tmp
chmod og-rwx ~/.vim/.tmp
if [ ! -e ~/.vim/bundle/Vundle.vim ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git \
        ~/.vim/bundle/Vundle.vim
fi
vim +PluginInstall +qall

# Git
ln -sv ~/.dotfiles/git/.gitconfig ~

# Mintty
if [ "$TERM" = "xterm" ]; then
    ln -sv ~/.dotfiles/mintty/.minttyrc ~
fi

# Bash
ln -sv ~/.dotfiles/bash/.bashrc ~
