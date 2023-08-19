-- This makes neovim load faster
vim.loader.enable()

-- Setup environment
local utils = require 'frank.utils'
local env_file = os.getenv('HOME') .. '/.private/nvim_env.lua'

if (utils.file_exists('env_file')) then
    vim.cmd('luafile ' .. env_file)
end

require 'frank.options'
require 'frank.lazyload'
require 'frank.ui'
require('frank.keymaps').init()
