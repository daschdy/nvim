require("config.lazy")

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

local key = vim.keymap
key.set("n", "<space><space>r", "<cmd>source %<CR>")
key.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

key.set("n", "K", vim.lsp.buf.hover, { desc = "Show hover" })
key.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Go to definition" })
key.set("n", "<leader>gr", vim.lsp.buf.references, { desc = "Go to references" })
key.set("n", "<leader>crr", vim.lsp.buf.code_action, { desc = "Code action" })
key.set("n", "<leader>crn", vim.lsp.buf.rename, { desc = "Rename" })
key.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "Format" })

key.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
key.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
key.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open diagnostic float" })
key.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostic to loclist" })

vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<M-CR>", "copilot#Accept()", { expr = true, silent = true, script = true })

key.set("n", "<leader>tt", "<cmd>split term://zsh", { desc = "Horizontal Terminal" })

-- custom term plugin
--  opens a terminal window in the current buffer
--  remap terminal exit to <Esc> in terminal mode
--  close terminal buffer when the terminal is closed
local term = require("custom.term")
key.set("n", "<leader>tv", function() term.split_vertical() end, { desc = "Split Terminal vertically" })
key.set("n", "<leader>th", function() term.split_horizontal() end, { desc = "Split Terminal horizontally" })
key.set("n", "<leader>tf", function() term.float_terminal() end, { desc = "Float Terminal" })
key.set("n", "<leader>tt", function() term.toggle_terminal() end, { desc = "Toggle Terminal" })
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })
vim.api.nvim_create_augroup("CloseTerminals", { clear = true })
vim.api.nvim_create_autocmd("TermClose", {
    group = "CloseTerminals",
    pattern = "*",
    callback = function()
        vim.cmd("bdelete")
    end,
})


-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
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
