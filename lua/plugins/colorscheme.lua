return {
    {
        "bluz71/vim-moonfly-colors",
        name = "moonfly",
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.moonflyItalics = true
            vim.g.moonflyTransparent = false
            vim.cmd.colorscheme("moonfly")
        end
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
    }
}
