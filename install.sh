#!/bin/bash
cd ~/.dotfiles
git pull

# Git
ln -sv ~/.dotfiles/git/.gitconfig ~
ln -sv ~/.dotfiles/git/.gitattributes ~

# Mintty
if [ "$TERM" = "xterm" ]; then
    ln -sv ~/.dotfiles/mintty/.minttyrc ~
fi

# Bash
ln -sv ~/.dotfiles/bash/.bashrc ~
BASHD=~/.dotfiles/bash/generated
mkdir -p $BASHD
if hash pip 2> /dev/null; then
    pip completion --bash > $BASHD/pip_completion
fi

# GnuPG
mkdir -p ~/.gnupg
chmod 700 ~/.gnupg
ln -sv ~/.dotfiles/gnupg/gpg-agent.conf ~/.gnupg/
ln -sv ~/.dotfiles/gnupg/gpg.conf ~/.gnupg/

# Byobu
if [ -d "$HOME/.byobu" ]; then
    ln -sv ~/.dotfiles/byobu/.tmux.conf ~/.byobu/
fi

# Vim
ln -sv ~/.dotfiles/vim/.vimrc ~
mkdir -p -m 700 ~/.cache
mkdir -p -m 700 ~/.cache/vim
if [ ! -e ~/.vim/bundle/Vundle.vim ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git \
        ~/.vim/bundle/Vundle.vim
else
    git -C ~/.vim/bundle/Vundle.vim pull
fi
vim +PluginInstall! +qall

