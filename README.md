# nvim

My personal Neovim config: a single `init.lua` that leans on built-in
features (`vim.pack`, `vim.lsp`, `vim.treesitter`, `ui2`) and keeps
plugins to a minimum.

## Requirements

- **Neovim nightly** (0.13-dev). The config uses `vim.pack`, `:restart`,
  `vim.hl.hl_op` and the experimental `vim._core.ui2` message UI, which are
  not in stable releases. I install it with
  [bob](https://github.com/MordechaiHadad/bob): `bob use nightly`.
- A [Nerd Font](https://www.nerdfonts.com/), for file icons
- Tree-sitter parsers and queries installed into
  `~/.local/share/nvim/site/{parser,queries}` (nvim-treesitter is not
  used)

### CLI tools

| Tool | Needed for |
| --- | --- |
| `git` | `vim.pack` cloning and updating plugins; gitsigns |
| `rg` ([ripgrep](https://github.com/BurntSushi/ripgrep)) | `<leader>f` file search and `<leader>g` live grep |
| `node` + `npm` | Mason installing `pyright` and `typescript-language-server` |
| `curl` or `wget` | Mason downloading `lua-language-server` and `clangd`; blink.cmp downloading its prebuilt fuzzy matcher |
| `unzip`, `tar`, `gzip` | Mason extracting downloaded servers |
| `cargo` (optional) | Building blink.cmp's Rust fuzzy matcher if no prebuilt binary is available |
| `tmux` (optional) | vim-tmux-navigator pane switching |

On macOS with Homebrew:

```sh
brew install bob ripgrep node wget tmux
```

`git`, `curl`, `unzip`, `tar` and `gzip` already ship with macOS (`git`
through the Xcode Command Line Tools).

### Language servers

Install these from `:Mason`:

| Server | Mason package | Languages |
| --- | --- | --- |
| `lua_ls` | `lua-language-server` | Lua |
| `pyright` | `pyright` | Python |
| `clangd` | `clangd` | C, C++ |
| `ts_ls` | `typescript-language-server` | JavaScript, TypeScript |

Or install them all in one go: `:MasonInstall lua-language-server pyright
clangd typescript-language-server`.

## Installation

```sh
git clone <this repo> ~/.config/nvim
nvim
```

`vim.pack` installs the plugins on first launch. It writes
`nvim-pack-lock.json`, which is git-ignored. Language servers are
installed with `:Mason`.

## Plugins

| Plugin | Purpose |
| --- | --- |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | Server configs for `vim.lsp.enable` |
| [mason.nvim](https://github.com/mason-org/mason.nvim) | Installs language servers |
| [blink.cmp](https://github.com/Saghen/blink.cmp) | Completion, with signature help |
| [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) | Snippet collection for blink.cmp |
| [mini.pick](https://github.com/nvim-mini/mini.pick) | Fuzzy picker for files, grep, help and buffers |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | File icons in the picker |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git change signs in the sign column |
| [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) | `<C-h/j/k/l>` moves between Neovim splits and tmux panes |

## What's configured

- **Editing:** 4-space indentation with spaces, relative line numbers,
  no wrapping, cursorline, case-insensitive search, rounded window
  borders.
- **Appearance:** transparent backgrounds for normal, float and sign
  column highlights, so the terminal background shows through.
- **Highlighting:** a `FileType` autocmd calls `vim.treesitter.start` for
  any filetype that has a parser installed.
- **LSP:** `lua_ls`, `pyright`, `clangd` and `ts_ls` are enabled.
  `lua_ls` knows the Neovim runtime. Built-in LSP completion triggers on
  every keypress.
- **Messages:** the built-in `ui2` shows messages in a floating window
  instead of the command line, and LSP progress (such as `lua_ls`
  indexing) appears there too.
- **Picker:** mini.pick opens as a full-width panel along the bottom
  40% of the screen. File search includes hidden files but skips `.git`.
- **Yank highlight:** yanked text flashes briefly.

## Keymaps

The leader key is `<Space>`.

### General

| Key | Action |
| --- | --- |
| `<leader>r` | Source the current file |
| `<leader>R` | Restart Neovim |
| `<leader>up` | Update plugins (`vim.pack.update()`) |
| `<Esc>` | Clear search highlight |
| `<leader>y` / `<leader>yy` | Yank selection / line to the system clipboard |
| `<leader>d` / `<leader>dd` | Delete selection / line to the system clipboard |

### Files and buffers

| Key | Action |
| --- | --- |
| `<leader>f` | Find files |
| `<leader>g` | Live grep |
| `<leader>gh` | Search help |
| `<leader>bb` | List buffers |
| `<leader>bd` | Close all saved buffers except the current one |
| `<leader>e` | Open netrw (`:Explore`) |

### Windows

| Key | Action |
| --- | --- |
| `<leader>bh/bj/bk/bl` | Move to the left / below / above / right window |
| `<C-h/j/k/l>` | Move between windows and tmux panes |
| `<C-\>` | Go to the previous window or pane |

### LSP and diagnostics

| Key | Action |
| --- | --- |
| `K` | Hover documentation |
| `<leader>gd` | Go to definition |
| `<leader>gr` | List references |
| `<leader>ca` | Code action |
| `<leader>cr` | Rename symbol |
| `<leader>cf` | Format buffer |
| `<leader>dn` / `<leader>dp` | Next / previous diagnostic |
| `<leader>df` | Show diagnostic in a float |
| `<leader>dl` | Send diagnostics to the location list |

Completion uses blink.cmp's `default` preset: `<C-space>` opens the menu,
`<C-y>` accepts, `<C-n>` / `<C-p>` select, and `<C-e>` closes.
