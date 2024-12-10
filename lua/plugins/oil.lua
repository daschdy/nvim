return {
    "stevearc/oil.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("oil").setup({
            view_options = {
                show_hidden = true,
            },
        })
        vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
        vim.keymap.set("n", "<space>-", require("oil").toggle_float, { desc = "Toggle oil float" })
    end,
}
