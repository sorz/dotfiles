-- Options
-- https://neovim.io/doc/user/options.html
local opts = {
    undofile = true;
    shada = "'100,<1000";
    fileencoding = "utf-8";
    cursorline = true;
    number = true;
    scrolloff = 3;
    mouse = "a";
    list = true;
    listchars = "tab:▸ ,eol:¬,extends:❯,precedes:❮";
    smartindent = true;
    ignorecase = true;
    foldlevel = 99;
}
for k, v in pairs(opts) do vim.opt[k] = v end

-- Reset cursor on leave
-- https://github.com/neovim/neovim/wiki/FAQ#cursor-
-- style-isnt-restored-after-exiting-or-suspending-and-resuming-nvim
vim.cmd(
    'au VimEnter,VimResume * set ' ..
    'guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,' ..
    'a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,' ..
    'sm:block-blinkwait175-blinkoff150-blinkon175'
)
vim.cmd('au VimLeave,VimSuspend * set guicursor=a:ver25')

-- Plug
local Plug = vim.fn['plug#']
vim.call('plug#begin')
Plug 'phaazon/hop.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
Plug 'Mofiqul/vscode.nvim'
Plug 'farmergreg/vim-lastplace'
Plug 'nmac427/guess-indent.nvim'
Plug 'nfnty/vim-nftables'
Plug 'chr4/nginx.vim'
-- https://github.com/hrsh7th/nvim-cmp
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
vim.call('plug#end')

-- Hop (EasyMotion alt.)
-- https://github.com/phaazon/hop.nvim
require('hop').setup {
    case_insensitive = false,
}
vim.api.nvim_set_keymap('n', 's', ':HopChar1\n', {})

-- vscode (theme)
-- https://github.com/Mofiqul/vscode.nvim
vim.o.background = 'dark'
require('vscode').setup {
    italic_comments = true,
    color_overrides = {
        vscBack = '#121212',
        vscCursorDarkDark = '#000000',
    },
}

-- Lualine (status line)
-- https://github.com/nvim-lualine/lualine.nvim
require('lualine').setup {
    options = {
        icons_enabled = false,
        theme = 'vscode',
        section_separators = '',
        component_separators = '',
    }
}

-- gitsigns.nvim (Git)
-- https://github.com/lewis6991/gitsigns.nvim
require('gitsigns').setup()

-- GuessIndent
-- https://github.com/NMAC427/guess-indent.nvim
require('guess-indent').setup()

-- Treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter
require('nvim-treesitter.configs').setup {
    sync_install = false,
    auto_install = true,
}

-- nvim-cmp
-- https://github.com/hrsh7th/nvim-cmp
vim.opt.completeopt = 'menu,menuone,noselect'
local cmp = require('cmp')
cmp.setup {
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert {
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
    }, {
        { name = 'buffer' },
    }),
}

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
require('lspconfig')['pyright'].setup {
    flags = lsp_flags,
    on_attach = on_attach,
}
require('lspconfig')['rust_analyzer'].setup {
    flags = lsp_flags,
    on_attach = on_attach,
}
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

