local T = {}

T.config = {
    cmd = { vim.o.shell },
    winopt = {
        relative = "editor",
        col = math.floor(vim.o.columns * 0.1),
        row = math.floor(vim.o.lines * 0.1),
        width = math.floor(vim.o.columns * 0.8),
        height = math.floor(vim.o.lines * 0.8),
        border = "none",
        style = "minimal",
        hide = true,
    }
}

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

    local win = vim.api.nvim_open_win(buf, true,
    {
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

function T.toggle_terminal()
    if not vim.api.nvim_buf_is_valid(T.buf or -1) then
        T.buf = vim.api.nvim_create_buf(false, false)
    end
    T.win = vim.iter(vim.fn.win_findbuf(T.buf)):find(function(b_wid)
        return vim.iter(vim.api.nvim_tabpage_list_wins(0)):any(function(t_wid)
            return b_wid == t_wid
        end)
    end) or vim.api.nvim_open_win(T.buf, false, T.config.winopt)

    if vim.api.nvim_win_get_config(T.win).hide then
        vim.api.nvim_win_set_config(T.win, { hide = false })
        vim.api.nvim_set_current_win(T.win)
        if vim.bo[T.buf].channel <= 0 then
            vim.fn.termopen(T.config.cmd)
        end
        vim.cmd('startinsert')
    else
        vim.api.nvim_win_set_config(T.win, { hide = true })
        vim.api.nvim_set_current_win(vim.fn.win_getid(vim.fn.winnr('#')))
    end
end

return T
