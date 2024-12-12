return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release"
        }
    },
    config = function()
        require('telescope').setup {
            pickers = {
                find_files = {
                    find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
                    theme = "ivy",
                },
                live_grep = {
                    theme = "ivy",
                }
            },
        }
        vim.keymap.set("n", "<space>ff", require("telescope.builtin").find_files)
        -- find files in confifg
        vim.keymap.set("n", "<space>fc", function()
            require("telescope.builtin").find_files {
                cwd = vim.fn.stdpath("config")
            }
        end)
        vim.keymap.set("n", "<space>fg", require("telescope.builtin").live_grep)
    end
}
