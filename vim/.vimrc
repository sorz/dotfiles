set nocompatible
filetype off

" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')
Plug 'Lokaltog/vim-easymotion'
Plug 'bling/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
"Plug 'nathangrigg/vim-beancount'
Plug 'rust-lang/rust.vim'
Plug 'avakhov/vim-yaml'
Plug 'nfnty/vim-nftables'
Plug 'flazz/vim-colorschemes'
Plug 'fcpg/vim-osc52'
Plug 'chr4/nginx.vim'
Plug 'neoclide/jsonc.vim'
call plug#end()

try
    colorscheme molokai
catch /^Vim\%((\a\+)\)\=:E185/
    " Ignore it
endtry

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
set mouse=a
set ttymouse=xterm2

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
set backupdir=~/.cache/vim/
set viewdir=~/.cache/vim/
set undodir=~/.cache/vim/

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
autocmd FileType v2ray setlocal filetype=jsonc et sta sw=2 sts=2

autocmd BufRead,BufNewFile /etc/v2ray/*.json setlocal filetype=v2ray
autocmd BufRead,BufNewFile /opt/v2ray/*.json setlocal filetype=v2ray

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

" https://github.com/fcpg/vim-osc52
xmap Y y:call SendViaOSC52(getreg('"'))<CR>
