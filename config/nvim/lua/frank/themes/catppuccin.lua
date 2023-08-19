require('catppuccin').setup({
    flavour      = 'latte',
    term_colors  = true,
    background   = {
        light = 'latte',
        dark  = 'mocha',
    },
    integrations = {
        dashboard  = true,
        illuminate = true,
        noice      = true,
        nvimtree   = true,

        indent_blankline = {
            enabled               = true,
            colored_indent_levels = true,
        },
        telescope        = {
            enabled = true,
        },
    },
})

vim.cmd.colorscheme 'catppuccin'

-- require("dap")

-- local sign = vim.fn.sign_define

-- sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = ""})
-- sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = ""})
-- sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = ""})
