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
key.set("n", "<leader>R", "<cmd>restart<CR>")

vim.pack.add({
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/nvim-mini/mini.pick" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/Saghen/blink.cmp" },
    { src = "https://github.com/rafamadriz/friendly-snippets" },
    { src = "https://github.com/christoomey/vim-tmux-navigator" },
})

for _, g in ipairs({ "Normal", "NormalNC", "NormalFloat", "SignColumn", "EndOfBuffer" }) do
    vim.api.nvim_set_hl(0, g, { bg = "none" })
end

-- autocompletion
require("blink.cmp").setup({
    keymap = { preset = 'default' },
    appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
    },
    signature = { enabled = true }
})

-- highlighting (parsers + queries live in ~/.local/share/nvim/site/{parser,queries})
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("my.treesitter", { clear = true }),
    callback = function(args)
        pcall(vim.treesitter.start, args.buf)
    end,
})

-- notification: built-in ui2 (experimental) replaces the message area/cmdline
require("vim._core.ui2").enable({
    msg = {
        -- ephemeral floating window for messages and progress, like fidget
        targets = { default = "msg" },
    },
})

-- show LSP progress (e.g. lua_ls indexing) as native progress messages
vim.api.nvim_create_autocmd("LspProgress", {
    group = vim.api.nvim_create_augroup("my.lsp-progress", { clear = true }),
    callback = function(ev)
        local value = ev.data.params.value
        vim.api.nvim_echo({ { value.message or "done" } }, false, {
            id = "lsp." .. ev.data.params.token,
            kind = "progress",
            source = "vim.lsp",
            title = value.title,
            status = value.kind ~= "end" and "running" or "success",
            percent = value.percentage,
        })
    end,
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

require("mason").setup()
vim.lsp.enable({ "lua_ls", "pyright", "clangd", "ts_ls" })

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
key.set({ "n", "v" }, "<leader>y", '"+y<CR>')
key.set("n", "<leader>yy", '"+yy<CR>')
key.set({ "n", "v" }, "<leader>d", '"+d<CR>')
key.set("n", "<leader>dd", '"+dd<CR>')
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
        vim.hl.hl_op()
    end,
})

-- picker
local pick = require("mini.pick")
pick.setup({
    window = {
        -- full-width bottom panel, similar to telescope's ivy theme
        config = function()
            return { width = vim.o.columns, height = math.floor(vim.o.lines * 0.4) }
        end,
    },
})
key.set("n", "<leader>f", function()
    pick.builtin.cli({ command = { "rg", "--files", "--hidden", "-g", "!.git" } }, {
        source = {
            name = "Files",
            show = function(buf, items, query)
                pick.default_show(buf, items, query, { show_icons = true })
            end,
        },
    })
end)
key.set("n", "<leader>g", pick.builtin.grep_live)
key.set("n", "<leader>gh", pick.builtin.help)
key.set("n", "<leader>bb", pick.builtin.buffers, { desc = "List buffers" })

-- close every saved file buffer except the current one, keeping unsaved ones open
key.set("n", "<leader>bd", function()
    local current = vim.api.nvim_get_current_buf()
    local closed = 0
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if buf ~= current and vim.bo[buf].buflisted and vim.bo[buf].buftype == "" and not vim.bo[buf].modified then
            if pcall(vim.api.nvim_buf_delete, buf, {}) then
                closed = closed + 1
            end
        end
    end
    vim.notify(("Closed %d saved buffer(s)"):format(closed))
end, { desc = "Close saved buffers" })

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

