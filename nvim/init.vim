set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

set backupdir=~/.cache/nvim/
set viewdir=~/.cache/nvim/
set undodir=~/.cache/nvim/

call plug#begin(stdpath('data') . '/plugged')
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'Lokaltog/vim-easymotion'
call plug#end()

" Reset cursor on leave
" https://github.com/neovim/neovim/wiki/FAQ#cursor-
" style-isnt-restored-after-exiting-or-suspending-and-resuming-nvim
au VimEnter,VimResume * set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
  \,sm:block-blinkwait175-blinkoff150-blinkon175
au VimLeave,VimSuspend * set guicursor=a:ver25

autocmd FileType html setlocal et sta ts=2 sts=2 sw=2

lua << EOF
  require'nvim-treesitter.configs'.setup {
    ensure_installed = {
      "c", "python", "rust", "bash", "css", "gitignore", "html", "javascript",
      "json", "make", "typescript", "vim", "yaml", "go", "cpp", "markdown",
    },
    sync_install = false,
    auto_install = true,
  }


EOF
