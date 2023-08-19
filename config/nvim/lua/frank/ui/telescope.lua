local telescope = require 'telescope'
local utils = require 'frank.utils'

telescope.setup {
    defaults = {
        sort_mru         = true,
        sorting_strategy = 'ascending',
        layout_config    = { prompt_position = 'top' },
        border_chars     = {
            prompt  = { '▔', '▕', ' ', '▏', '🭽', '🭾', '▕', '▏' },
            results = utils.border_chars_outer_thin_telescope,
            preview = utils.border_chars_outer_thin_telescope,
        },
        border           = true,
        multi_icon       = '',
        entry_prefix     = '   ',
        prompt_prefix    = '   ',
        selection_caret  = '  ',
        hl_result_eol    = true,
        results_title    = '',
        winblend         = 0,
        wrap_results     = false,
        mappings         = { i = { ['<Esc>'] = require('telescope.actions').close } },
    },
}

telescope.load_extension 'notify'
