local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

local indent = 2
vim.cmd 'colorscheme tender'              -- Put your favorite colorscheme here
opt('b', 'expandtab', true)           -- Use spaces instead of tabs
opt('b', 'shiftwidth', indent)        -- Size of an indent
opt('b', 'smartindent', true)         -- Insert indents automatically
opt('b', 'tabstop', indent)           -- Number of spaces tabs count for

opt('o', 'autochdir', true)           -- automatically change directory
opt('o', 'cmdheight', 2)
opt('o', 'confirm', true)
opt('o', 'hidden', true)              -- Enable modified buffers in background
opt('o', 'ignorecase', true)          -- Ignore case
opt('o', 'joinspaces', false)         -- No double spaces with join after a dot
opt('o', 'scrolloff', 4 )             -- Lines of context
opt('o', 'shiftround', true)          -- Round indent
opt('o', 'shortmess', 'filnxtToOFc')  -- don't give [ins-completion-menu] messages
opt('o', 'sidescrolloff', 8 )         -- Columns of context
opt('o', 'smartcase', true)           -- Don't ignore case with capitals
opt('o', 'splitbelow', true)          -- Put new windows below current
opt('o', 'splitright', true)          -- Put new windows right of current
opt('o', 'termguicolors', true)       -- True color support
opt('o', 'updatetime', 300)           -- in milliseconds
opt('o', 'wildmode', 'list:longest')  -- Command-line completion mode
opt('w', 'list', true)                -- Show some invisible characters (tabs...)
opt('w', 'number', true)              -- Show line number
opt('w', 'relativenumber', true)      -- Relative line numbers
opt('w', 'signcolumn', 'auto')        -- show sign column 

vim.g['python3_host_prog'] = '/home/bookiboo/nvim/bin/python3'
