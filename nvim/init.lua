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
    -- https://gist.github.com/andersevenrud/015e61af2fd264371032763d4ed965b6#neovim
    termguicolors = true;
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

-- Plugin
-- https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    'ggandor/leap.nvim',
    'nvim-lualine/lualine.nvim',
    'lewis6991/gitsigns.nvim',
    'nvim-treesitter/nvim-treesitter',
    'Mofiqul/vscode.nvim',
    'farmergreg/vim-lastplace',
    'nmac427/guess-indent.nvim',
    'nfnty/vim-nftables',
    'chr4/nginx.vim',
    'neovim/nvim-lspconfig',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-vsnip',
    'hrsh7th/vim-vsnip',
}
require("lazy").setup(plugins, {
    checker = { enabled = true },
})
-- Leap (EasyMotion alt.)
-- https://github.com/ggandor/leap.nvim
require('leap').set_default_keymaps()

-- Suda
-- https://github.com/lambdalisue/suda.vim
vim.g.suda_smart_edit = 1

-- vscode (theme)
-- https://github.com/Mofiqul/vscode.nvim
vim.o.background = 'dark'
require('vscode').setup {
    transparent = true,
    italic_comments = true,
    disable_nvimtree_bg = true,
    color_overrides = {
        vscBack = '#121212',
        vscCursorDarkDark = '#000000',
    },
}
require('vscode').load()

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

local capabilities = require('cmp_nvim_lsp')
    .default_capabilities(vim.lsp.protocol.make_client_capabilities())
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

