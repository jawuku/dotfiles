--[[
                               88
                         ,d    ""
                         88
 ,adPPYba,  8b,dPPYba, MM88MMM 88  ,adPPYba,  8b,dPPYba,  ,adPPYba,
a8"     "8a 88P'    "8a  88    88 a8"     "8a 88P'   `"8a I8[    ""
8b       d8 88       d8  88    88 8b       d8 88       88  `"Y8ba,
"8a,   ,a8" 88b,   ,a8"  88,   88 "8a,   ,a8" 88       88 aa    ]8I
 `"YbbdP"'  88`YbbdP"'   "Y888 88  `"YbbdP"'  88       88 `"YbbdP"'
            88
            88

ASCII art from https://ascii.co.uk/text
style: Default Font


new config style inspired by Christian Chiarulli's options page
https://github.com/ChristianChiarulli/nvim/blob/master/lua/user/options.lua
]]
local myoptions = {
  expandtab = true, -- Use spaces instead of tabs
  modeline = false, -- don't display mode, as status bar does this
  shiftwidth = 2, -- Size of an indent
  smartindent = true, -- Insert indents automatically
  tabstop = 2, -- Number of spaces tabs count for
  softtabstop = 2,
  autochdir = true, -- automatically change directory
  clipboard = "unnamed,unnamedplus", -- clipboard integrates with desktop
  cmdheight = 2, -- allows displaying of error messages below
  confirm = true, -- Confirm to save file on exit
  hidden = true, -- Enable modified buffers in background
  ignorecase = true, -- Ignore case
  joinspaces = false, -- No double spaces with join after a dot
  scrolloff = 4, -- Lines of context
  shiftround = true, -- Round indent
  showmode = false, -- remove --INSERT-- notifications
  sidescrolloff = 8, -- Columns of context
  smartcase = true, -- Don't ignore case with capitals
  splitbelow = true, -- Put new windows below current
  splitright = true, -- Put new windows right of current
  termguicolors = true, -- True color support
  wildmode = "list:longest", -- Command-line completion mode
  foldmethod = "expr", -- tree-sitter folding mode
  foldexpr = "nvim_treesitter#foldexpr()",
  list = true, -- Show some invisible characters (tabs...)
  number = true, -- Show line number
  relativenumber = true, -- Relative line numbers
  signcolumn = "yes", -- show sign column
  undofile = true,
  background = "dark",
  completeopt = {"menu", "menuone", "noselect"}, -- for nvim-cmp
  foldenable = false, -- disable automatic folding
  mouse = "a", -- enable mouse support
  updatetime = 300 -- reduce refresh time from 4000 ms
}

for k, v in pairs(myoptions) do vim.opt[k] = v end

-- set tabs to be 4 spaces in Python and Julia
vim.cmd [[autocmd Filetype python setlocal et ts=4 sw=4 sts=4]]
vim.cmd [[autocmd Filetype julia  setlocal et ts=4 sw=4 sts=4]]

--[[ Set Python executable binary
-- Set following shell script in $PATH e.g. ~/.local/bin/runpython
-- make it executable
-- which will load the current Python environment
```sh
#!/bin/sh

python3 "$@"
```
]]
vim.g.python3_host_prog = '~/.local/bin/runpython'

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set indent blankline options
vim.g.indent_blankline_char = "┆"
vim.g.indent_blankline_buftype_exclude = {"help", "NvimTree"}
vim.g.indent_blankline_show_trailing_blankline_indent = false
