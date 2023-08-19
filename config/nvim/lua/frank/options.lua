local utils = require 'frank.utils'

vim.cmd('filetype plugin indent on')

-- Important to place this before loading plugins.
vim.g.mapleader = ' '

vim.cmd 'set noshowmode'
vim.cmd 'set mouse=a'
vim.cmd 'set hlsearch'

vim.cmd 'set ignorecase'
vim.cmd 'set smartcase'

vim.opt.tabstop     = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth  = 4
vim.opt.textwidth   = 0

vim.cmd 'set expandtab'
vim.cmd 'set autoindent'
vim.cmd 'set smartindent'

vim.opt.fillchars = {
    horiz     = utils.bottom_thin,
    horizup   = utils.bottom_thin,
    horizdown = ' ',
    vert      = utils.left_thin,
    vertleft  = utils.left_thin,
    vertright = ' ',
    verthoriz = ' ',
    eob       = ' ',
    diff      = '/',
}

vim.cmd 'set number'
vim.cmd 'set relativenumber'
vim.cmd 'set signcolumn=number'

vim.cmd 'set cursorline'
vim.cmd 'set cursorlineopt=both'
