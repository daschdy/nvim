return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "j-hui/fidget.nvim",
        "stevearc/conform.nvim",
        {
            -- vim omnicompletions
            -- triggered with ctrl+x ctrl+o
            -- checkout :help ins-completion
            "folke/lazydev.nvim",
            ft = "lua", -- only load on lua files
            opts = {
                library = {
                    -- See the configuration section for more details
                    -- Load luvit types when the `vim.uv` word is found
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
            },
        },
        {
            "williamboman/mason-lspconfig.nvim",
            opts = {
                auto_install = false
            }
        },

    },

    config = function()
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

        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local lspconfig = require("lspconfig")
        local servers = {
            "lua_ls",
            "clangd",
            "gopls"
        }

        for _, server in ipairs(servers) do
            lspconfig[server].setup({
                capabilities = capabilities,
            })
        end

        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                c = { "clang-format" },
            },
        })

        -- check servers with: :help lspconfig-all
        require("lspconfig").lua_ls.setup {}

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
