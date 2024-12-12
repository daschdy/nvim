local T = {}

function T.win_opts(win)
    vim.api.nvim_win_call(win, function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
    end)
end

function T.split_horizontal()
    vim.cmd("rightbelow split term://zsh")
    T.win_opts(0)
end

function T.split_vertical()
    vim.cmd("rightbelow vsplit term://zsh")
    T.win_opts(0)
end

function T.float_terminal()
    local buf = vim.api.nvim_create_buf(false, true)
    if not buf then
        print("Failed to create buffer")
        return
    end

    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.6)
    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)

    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        col = col,
        row = row,
        border = "none",
    })

    vim.fn.termopen("/bin/zsh")
    vim.api.nvim_win_set_buf(win, buf)
    T.win_opts(win)
end

return T
