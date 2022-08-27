set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

set backupdir=~/.cache/nvim/
set viewdir=~/.cache/nvim/
set undodir=~/.cache/nvim/

call plug#begin(stdpath('data') . '/plugged')
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'Lokaltog/vim-easymotion'
" https://github.com/hrsh7th/nvim-cmp
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
call plug#end()

" Reset cursor on leave
" https://github.com/neovim/neovim/wiki/FAQ#cursor-
" style-isnt-restored-after-exiting-or-suspending-and-resuming-nvim
au VimEnter,VimResume * set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
  \,sm:block-blinkwait175-blinkoff150-blinkon175
au VimLeave,VimSuspend * set guicursor=a:ver25

autocmd FileType html setlocal et sta ts=2 sts=2 sw=2

" Treesitter
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

" nvim-cmp
" https://github.com/hrsh7th/nvim-cmp
set completeopt=menu,menuone,noselect
lua <<EOF
  local cmp = require'cmp'
  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
    }, {
      { name = 'buffer' },
    })
  })
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  local lsp_flags = {
    debounce_text_changes = 150,
  }
  local on_attach = function(client, bufnr)
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
  end
  require('lspconfig')['pyright'].setup{
    flags = lsp_flags,
    on_attach = on_attach,
  }
  require('lspconfig')['rust_analyzer'].setup{
    flags = lsp_flags,
    on_attach = on_attach,
  }
  local opts = { noremap=true, silent=true }
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
EOF
