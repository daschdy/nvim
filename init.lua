vim.g.mapleader = " "

local set = vim.opt
local key = vim.keymap

set.number = true
set.relativenumber = true
set.tabstop = 4
set.shiftwidth = 4
set.expandtab = true

set.incsearch = true
set.ignorecase = true

set.termguicolors = true
set.wrap = false
set.cursorline = true
set.winborder = "rounded"

set.autoread = true
set.autowrite = false

key.set("n", "<space>r", "<cmd>source %<CR>")

vim.pack.add({
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/ibhagwan/fzf-lua" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/Saghen/blink.cmp" },
    { src = "https://github.com/rafamadriz/friendly-snippets" },
    { src = "https://github.com/j-hui/fidget.nvim" },
    { src = "https://github.com/rose-pine/neovim" },
    { src = "https://github.com/github/copilot.vim" }
})

-- colorscheme
require("rose-pine").setup({
    styles = {
        transparency = true,
    },
})
vim.cmd("colorscheme rose-pine")

-- autocompletion
require("blink.cmp").setup({
    keymap = { preset = 'default' },
    appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
    },
    signature = { enabled = true }
})

-- Copilot
vim.g.copilot_no_tab_map = true
key.set({ "n", "i" }, "<c-y>", "copilot#Accept()", { expr = true, silent = true, script = true })

-- highlighting
require("nvim-treesitter.configs").setup({
    auto_install = false,
    sync_install = false,
    ignore_install = {},
    modules = {},
    ensure_installed = {
        "c",
        "lua",
        "markdown",
        "python",
        "rust",
        "svelte",
        "typescript",
        "html",
        "css",
    },
    highlight = { enable = true }
})

-- notification
require("fidget").setup({
    notification = {
        override_vim_notify = true,
        view = {
            stack_upwards = false,
        },
        window = {
            border = "none",
            align = "top",
            winblend = 0,
        },
    },
})

-- lsp
vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            }
        }
    }
})

require("Mason").setup()
vim.lsp.enable({ "lua_ls", "texlab", "pyright", "clangd", "svelte", "tsserver", "ts_ls"})

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp', {}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        if client:supports_method('textDocument/completion') then
            -- Optional: trigger autocompletion on EVERY keypress. May be slow!
            local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
            client.server_capabilities.completionProvider.triggerCharacters = chars
            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
        end
    end,
})
vim.cmd [[set completeopt+=menuone,noselect,popup]]


key.set("n", "K", vim.lsp.buf.hover)
key.set("n", "<leader>gd", vim.lsp.buf.definition)
key.set("n", "<leader>gr", vim.lsp.buf.references)
key.set("n", "<leader>ca", vim.lsp.buf.code_action)
key.set("n", "<leader>cr", vim.lsp.buf.rename)
key.set("n", "<leader>cf", vim.lsp.buf.format)
key.set("n", "<leader>dn", function()
    vim.diagnostic.jump({ count = 1, float = true })
end)
key.set("n", "<leader>dp", function()
    vim.diagnostic.jump({ count = -1, float = true })
end)
key.set("n", "<leader>df", vim.diagnostic.open_float)
key.set("n", "<leader>dl", vim.diagnostic.setloclist)

-- general
key.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
key.set({ "n", "v" }, "<leader>y", '"+y<CR')
key.set("n", "<leader>yy", '"+yy<CR')
key.set({ "n", "v" }, "<leader>d", '"+d<CR')
key.set("n", "<leader>dd", '"+dd<CR')
key.set("n", "<leader>up", "<cmd>lua vim.pack.update()<CR>")


key.set("n", "<leader>bh", "<C-w>h", { desc = "Move to left window" })
key.set("n", "<leader>bj", "<C-w>j", { desc = "Move to below window" })
key.set("n", "<leader>bk", "<C-w>k", { desc = "Move to above window" })
key.set("n", "<leader>bl", "<C-w>l", { desc = "Move to right window" })

-- highlight when yanking
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

-- fzf
key.set("n", "<leader>f", ":FzfLua files<CR>")
key.set("n", "<leader>g", ":FzfLua grep<CR>")
key.set("n", "<leader>h", ":FzfLua helptags<CR>")

-- file explorer
key.set("n", "<leader>e", ":Explore<CR>")

-- git
require("gitsigns").setup({
    signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
    },
})
