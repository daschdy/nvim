return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "saghen/blink.cmp",
        {
            "folke/lazydev.nvim",
            ft = "lua",
            opts = {
                library = {
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
            },
        },
        "williamboman/mason.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        {
            "williamboman/mason-lspconfig.nvim",
            opts = {
                auto_install = false
            }
        },
        "j-hui/fidget.nvim",
        "stevearc/conform.nvim",
    },

    config = function()
        local key = vim.keymap

        require("mason").setup({
            ui = {
                icons = {
                    package_installed = "",
                    package_pending = "",
                    package_uninstalled = "",
                },
            },
            ensure_installed = {
                "lua_ls",
                "stylua",
                "markdown",
            },
        })

        require("fidget").setup({
            notification = {
                view = {
                    stack_upwards = false,
                },
                window = {
                    border = "none",
                    align = "bottom",
                    winblend = 0,
                },
            },
        })

        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                c = { "clang-format" },
            },
        })

        key.set("n", "<leader>cf", vim.lsp.buf.format)

        local capabilities = require("blink.cmp").get_lsp_capabilities()
        local lspconfig = require("lspconfig")
        lspconfig.lua_ls.setup { capabilites = capabilities }
        lspconfig.clangd.setup { capabilites = capabilities }
        lspconfig.pyright.setup { capabilites = capabilities }

        key.set("n", "K", vim.lsp.buf.hover)
        key.set("n", "<leader>gd", vim.lsp.buf.definition)
        key.set("n", "<leader>gr", vim.lsp.buf.references)
        key.set("n", "<leader>ca", vim.lsp.buf.code_action)
        key.set("n", "<leader>rn", vim.lsp.buf.rename)
        key.set("n", "<leader>e", vim.diagnostic.open_float)


        -- Automatically format on save
        -- vim.api.nvim_create_autocmd("LspAttach", {
        --     callback = function(args)
        --         local client = vim.lsp.get_client_by_id(args.data.client_id)
        --         if not client then return end
        --
        --         ---@diagnostic disable-next-line: missing-parameter
        --         if client.supports_method("textDocument/formatting") then
        --             -- Format the current buffer on save
        --             vim.api.nvim_create_autocmd('BufWritePre', {
        --                 buffer = args.buf,
        --                 callback = function()
        --                     vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
        --                 end,
        --             })
        --         end
        --     end,
        -- })
    end,
}
