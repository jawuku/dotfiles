-- neovim options in lua
-- inspired by https://oroques.dev/notes/neovim-init/

-- functions and variables to set options
-- equivalent to vimscript's set command
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

-- Put your favorite colour scheme here
vim.cmd 'colorscheme tender'

-- local buffer options
local indent = 2
opt('b', 'expandtab', true)           -- Use spaces instead of tabs
opt('b', 'shiftwidth', indent)        -- Size of an indent
opt('b', 'smartindent', true)         -- Insert indents automatically
opt('b', 'tabstop', indent)           -- Number of spaces tabs count for

-- global options
opt('o', 'autochdir', true)           -- automatically change directory
opt('o', 'cmdheight', 2)
opt('o', 'completeopt' = 'menuone,noselect') -- enable nvim.compe 
opt('o', 'confirm', true)
opt('o', 'hidden', true)              -- Enable modified buffers in background
opt('o', 'ignorecase', true)          -- Ignore case
opt('o', 'joinspaces', false)         -- No double spaces with join after a dot
opt('o', 'scrolloff', 4)              -- Lines of context
opt('o', 'shiftround', true)          -- Round indent
opt('o', 'sidescrolloff', 8)          -- Columns of context
opt('o', 'smartcase', true)           -- Don't ignore case with capitals
opt('o', 'splitbelow', true)          -- Put new windows below current
opt('o', 'splitright', true)          -- Put new windows right of current
opt('o', 'termguicolors', true)       -- True color support
opt('o', 'wildmode', 'list:longest')  -- Command-line completion mode

-- local window options
opt('w', 'foldmethod', 'expr')        -- tree-sitter folding mode
opt('w', 'foldexpr', 'nvim_treesitter#foldexpr()')
opt('w', 'list', true)                -- Show some invisible characters (tabs...)
opt('w', 'number', true)              -- Show line number
opt('w', 'relativenumber', true)      -- Relative line numbers
opt('w', 'signcolumn', 'auto')        -- show sign column 

-- Set Python executable binary
vim.g['python3_host_prog'] = '$HOME/nvim/bin/python3'

-- Set indent-line character
vim.g['indentLine_char'] = '┆'

-- Rainbow parentheses on
vim.g['rainbow_active'] = 1
