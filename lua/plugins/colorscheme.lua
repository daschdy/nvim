return {
    {
        -- "bluz71/vim-moonfly-colors",
        -- name = "moonfly",
        -- lazy = false,
        -- priority = 1000,
        -- config = function()
        --     vim.g.moonflyItalics = false
        --     vim.g.moonflyTransarent = true
        --     vim.cmd.colorscheme("moonfly")
        -- end
    },
    {
        "shaunsingh/nord.nvim",
        name = "nord",
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.nord_contrast = true
            vim.g.nord_borders = false
            vim.g.nord_disable_background = true
            vim.g.nord_italic = true
            vim.g.nord_uniform_diff_background = true
            vim.g.nord_bold = false
            require("nord").set()
            vim.cmd.colorscheme("nord")
        end
    }
}
