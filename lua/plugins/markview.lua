return {
    "OXY2DEV/markview.nvim",
    lazy = false,
    config = function()
        vim.keymap.set("n", "<space>mt", "<CMD>Markview Toggle<CR>")
    end
}
