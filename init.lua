require("config.lazy")

local key = vim.keymap
local set = vim.opt

set.relativenumber = true
set.number = true
set.tabstop = 4
set.softtabstop = 4
set.expandtab = true
set.shiftwidth = 4
set.breakindent = true
set.incsearch = true
set.hlsearch = true
set.ignorecase = true
set.smartcase = true
set.wrap = false
set.undofile = true
set.termguicolors = true
set.clipboard = "unnamedplus"
set.cursorline = true
set.guicursor = ""
set.mouse = "a"
set.showmode = false
set.updatetime = 200
set.timeoutlen = 250
set.cmdheight = 0

key.set("n", "<space><space>r", "<cmd>source %<CR>")
key.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

key.set("n", "K", vim.lsp.buf.hover, { desc = "Show hover" })
key.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Go to definition" })
key.set("n", "<leader>gr", vim.lsp.buf.references, { desc = "Go to references" })
key.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
key.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
key.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostics" })
key.set("n", "<leader>{", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
key.set("n", "<leader>}", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
key.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "Format" })


-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- no padding around the window
vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
    callback = function()
        local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
        if not normal.bg then return end
        io.write(string.format("\027]11;#%06x\027\\", normal.bg))
    end,
})

vim.api.nvim_create_autocmd("UILeave", {
    callback = function() io.write("\027]111\027\\") end,
})
