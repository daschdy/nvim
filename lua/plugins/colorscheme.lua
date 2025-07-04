local M = {
    {
        -- "bluz71/vim-moonfly-colors",
        -- name = "moonfly",
        -- lazy = false,
        -- priority = 1000,
        -- config = function()
        --     vim.g.moonflyItalics = true
        --     vim.g.moonflyTransparent = false
        --     vim.cmd.colorscheme("moonfly")
        -- end
    },
    {
        -- "ilof2/posterpole.nvim",
        -- priority = 1000,
        -- config = function()
        --     require("posterpole").setup({
        --         transparent = false
        --     })
        --     vim.cmd("colorscheme posterpole")
        -- end
    },
    {
        -- "ellisonleao/gruvbox.nvim",
        -- priority = 1000,
        -- config = function()
        --     require("gruvbox").setup({
        --         terminal_colors = true,   -- add neovim terminal colors
        --         undercurl = true,
        --         underline = true,
        --         bold = true,
        --         italic = {
        --             strings = true,
        --             emphasis = true,
        --             comments = true,
        --             operators = false,
        --             folds = true,
        --         },
        --         strikethrough = true,
        --         invert_selection = false,
        --         invert_signs = false,
        --         invert_tabline = false,
        --         invert_intend_guides = false,
        --         inverse = true, -- invert background for search, diffs, statuslines and errors
        --         contrast = "", -- can be "hard", "soft" or empty string
        --         palette_overrides = {},
        --         overrides = {},
        --         dim_inactive = false,
        --         transparent_mode = true,
        --     })
        --     vim.cmd.colorscheme("gruvbox")
        -- end
    },
    {
        -- "rose-pine/neovim",
        -- name = "rose-pine",
        -- config = function()
        --     require("rose-pine").setup({
        --         styles = {
        --             transparency = true
        --         }
        --     })
        --     vim.cmd.colorscheme("rose-pine")
        -- end
    },
    {
        -- "navarasu/onedark.nvim",
        -- name = "onedark",
        -- config = function()
        --     require("onedark").setup({
        --         transparent = true
        --     })
        --     vim.cmd.colorscheme("onedark")
        -- end
    },
    {
        -- "baliestri/aura-theme",
        -- lazy = false,
        -- priority = 1000,
        -- config = function(plugin)
        --     vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
        --     vim.cmd([[colorscheme aura-dark]])
        -- end
    },
    {
        -- Disable background color
        -- vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' }),
        -- vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' }),
        -- vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'none' }),
        -- vim.api.nvim_set_hl(0, 'Pmenu', { bg = 'none' }),
    }
}

return M
