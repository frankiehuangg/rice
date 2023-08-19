local name = 'frank'

return {
    -- UI/UX
    {
        'glepnir/dashboard-nvim',
        name         = 'dashboard-nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        lazy         = false,
        config       = function() require (name .. '.ui.dashboard') end,
    },
    {
        'norcalli/nvim-colorizer.lua',
        name   = 'colorizer-nvim',
        event  = { 'User NvimStartupDone' },
        config = function() require (name .. '.ui.colorizer') end,
    },
    {
        'nvim-telescope/telescope.nvim',
        name         = 'telescope-nvim',
        dependencies = { 'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim' }, 
        cmd          = 'Telescope',
        config       = function() require (name .. '.ui.telescope') end,
    },
    {
        'nvim-lualine/lualine.nvim',
        name         = 'lualine-nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        event        = { 'BufWinEnter' },
        config       = function() require (name .. '.ui.lualine') end,
    },
    {
        'romgrk/barbar.nvim',
        name         = 'barbar-nvim',
        dependencies = {
            'lewis6991/gitsigns.nvim',
            'nvim-tree/nvim-web-devicons',
        },
        config       = function() require (name .. '.ui.barbar') end,
    },
    {
        'folke/noice.nvim',
        name         = 'noice-nvim',
        dependencies = { 'MunifTanjim/nui.nvim', 'rcarriga/nvim-notify' },
        event        = { 'User NvimStartupDone' },
        config       = function() require (name .. '.ui.noice') end,
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        name   = 'indent-blankline-nvim',
        event  = { 'VeryLazy' },
        config = function() require (name .. '.ui.indent-blankline') end,
    },
    {
        'RRethy/vim-illuminate',
        name   = 'illuminate-vim',
        event  = { 'User NvimStartupDone' },
        config = function() require (name .. '.ui.illuminate') end,
    },
    {
        'lewis6991/gitsigns.nvim',
        name   = 'gitsigns-nvim',
        event  = { 'User NvimStartupDone' },
        config = function() require (name .. '.ui.gitsigns') end,
    },
    {
        'folke/which-key.nvim',
        name   = 'whichkey-nvim',
        event  = { 'User NvimStartupDone' },
        config = function() require (name .. '.ui.whichkey') end,
    },
    {
        'nvim-tree/nvim-tree.lua',
        name         = 'tree-nvim',
        version      = '*',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config       = function() require (name .. '.ui.tree') end,
    },

    -- Language/Tools/LSP/Comp
    {
        'williamboman/mason.nvim',
        name   = 'mason-nvim',
        build  = ':MasonUpdate',
        event  = { 'User NvimStartupDone' },
        config = function() require (name .. '.lang.mason') end,
    },
    {
        'mfussenegger/nvim-dap',
        name         = 'dap-nvim',
        dependencies = { 'rcarriga/nvim-dap-ui' },
        event        = { 'User NvimStartupDone' },
        config       = function() require (name .. '.lang.debugger') end,
    },
    {
        'folke/trouble.nvim',
        name         = 'trouble-nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        cmd          = { 'TroubleToggle' },
        config       = function() require (name .. '.lang.lsp.trouble') end,
    },
    {
        'mfussenegger/nvim-lint',
        name   = 'lint-nvim',
        event  = { 'User NvimStartupDone' },
        config = function() require (name .. '.lang.linter') end,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        name         = 'treesitter-nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects', 'nvim-treesitter/playground' },
        event        = { 'User NvimStartupDone' },
        build        = { ':TSUpdate' },
        config       = function() require (name .. '.lang.treesitter') end,
    },
    {
        'neovim/nvim-lspconfig',
        name         = 'lspconfig-nvim',
        event        = { 'User NvimStartupDone' },
        dependencies = {
            {
                'folke/neodev.nvim',
                event  = { 'VeryLazy' },
                config = function() require (name .. '.lang.tools.neodev') end,
            },
            {
                'linux-cultist/venv-selector.nvim',
                dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim' },
                config       = true,
                event        = { 'User NvimStartupDone' },
            },
        },
        config       = function() require (name .. '.lang.lsp') end,
    },
    {
        'glepnir/lspsaga.nvim',
        name   = 'lspsaga-nvim',
        event  = { 'User NvimStartupDone' },
        config = function() require (name .. '.lang.lsp.lspsaga') end,
    },
    {
        'hrsh7th/nvim-cmp',
        name         = 'cmp-nvim',
        dependencies = {
            'hrsh7th/cmp-omni',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'saadparwaiz1/cmp_luasnip',
            {
                'L3MON4D3/LuaSnip',
                dependencies = { 'rafamadriz/friendly-snippets' },
                build = 'make install_jsregexp',
            },
        },
        event        = { 'User NvimStartupDone' },
        config       = function() require (name .. '.lang.completion') end,
    },
    {
        'ray-x/lsp_signature.nvim',
        name   = 'lspsignature-nvim',
        event  = { 'User NvimStartupDone' },
        config = function() require (name .. '.lang.lsp.signature') end,
    },

    -- Compability
    {
        'fladson/vim-kitty',
        name  = 'kitty-vim',
        event = { 'User NvimStartupDone' },
    },
    {
        'lervag/vimtex',
        name   = 'vimtex-vim',
        ft     = { 'tex', 'latex' },
        config = function() require (name .. '.lang.tools.latex') end,
    },

    -- Editing
    {
        'preservim/nerdcommenter',
        event = { 'User NvimStartupDone' },
    },

    { 
        'catppuccin/nvim', 
        name     = 'catppuccin-nvim', 
        priority = 1000,
        config   = function() require (name .. '.themes.catppuccin') end,
    },
}
