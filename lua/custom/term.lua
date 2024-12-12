local M = {}

function M.split_horizontal()
    vim.cmd("rightbelow split term://zsh")
end

function M.split_vertical()
    vim.cmd("rightbelow vsplit term://zsh")
end

return M

