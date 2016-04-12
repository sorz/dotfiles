set nocompatible
filetype off

" https://github.com/gmarik/Vundle.vim
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'bling/vim-airline'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
"Plugin 'nathangrigg/vim-beancount'
"Plugin 'rust-lang/rust.vim'
call vundle#end()

set history=1000
set undofile
set undoreload=1000
set backup
set noswapfile
set viminfo='20,<1000,s1000

set t_Co=256

set encoding=utf-8
set fileencoding=utf-8
set ch=1
set ruler
set cursorline
set nu
set scrolloff=3
set mouse=v

hi Search cterm=NONE ctermfg=black ctermbg=yellow

syntax on
set list
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set autoindent
"set textwidth=80
set hlsearch
set ignorecase
set showmatch
set backupskip=/tmp/*,/private/tmp/*
set backupdir=~/.vim/.tmp
set viewdir=~/.vim/.tmp
set undodir=~/.vim/.tmp

augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

set foldlevel=99

filetype plugin indent on
autocmd FileType python setlocal et sta sw=4 sts=4
autocmd FileType c setlocal et sta sw=4 sts=4
autocmd FileType python setlocal foldmethod=indent
autocmd FileType java setlocal et sta sw=4 sts=4
autocmd FileType html setlocal et sta ts=2 sts=2 sw=2
autocmd FileType django setlocal et sta ts=2 sts=2 sw=2
autocmd FileType htmldjango setlocal et sta ts=2 sts=2 sw=2
autocmd FileType css setlocal et sta ts=4 sts=4 sw=4
autocmd FileType javascript setlocal et sta ts=2 sts=2 sw=2

" https://github.com/bling/vim-airline
set laststatus=2

" https://github.com/airblade/vim-gitgutter
set updatetime=1000

" https://github.com/easymotion/vim-easymotion
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
nmap s <Plug>(easymotion-s)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" https://github.com/nathangrigg/vim-beancount
"let b:beancount_root = '~/beancount/main.bean'
"autocmd FileType beancount inoremap . .<C-O>:AlignCommodity<CR>
"autocmd FileType beancount inoremap <Tab> <c-x><c-o>
