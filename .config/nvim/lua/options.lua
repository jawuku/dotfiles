--[[
                       ,                 
----__------__--_/_--------__----__---__-
  /   )   /   ) /    /   /   ) /   ) (_ `
_(___/___/___/_(_ __/___(___/_/___/_(__)_
        /                                
       / 
options.lua

ASCII art from https://ascii.co.uk/text
style: Big Chief	   
]]--

local o = vim.o
local wo = vim.wo
local bo = vim.bo

-- Put your favorite colour scheme here
-- Choices: tender, dark_plus, NeoSolarized
vim.cmd 'colorscheme tender'

-- local buffer options --
local indent = 2
bo.expandtab = true          -- Use spaces instead of tabs
bo.modeline = false          -- don't display mode, as status bar does this
bo.shiftwidth = indent       -- Size of an indent
bo.smartindent = true        -- Insert indents automatically
bo.tabstop = indent          -- Number of spaces tabs count for

-- global options --
o.autochdir = true           -- automatically change directory
o.clipboard = 'unnamed,unnamedplus' -- clipboard integrates with desktop
o.cmdheight = 2              -- allows displaying of error messages below
o.completeopt = 'menuone,noselect' -- enable nvim.compe 
o.confirm = true             -- Confirm to save file on exit
o.hidden = true              -- Enable modified buffers in background
o.ignorecase = true          -- Ignore case
o.joinspaces = false         -- No double spaces with join after a dot
o.scrolloff = 4              -- Lines of context
o.shiftround = true          -- Round indent
o.sidescrolloff = 8          -- Columns of context
o.smartcase = true           -- Don't ignore case with capitals
o.splitbelow = true          -- Put new windows below current
o.splitright = true          -- Put new windows right of current
o.termguicolors = true       -- True color support
o.wildmode = 'list:longest'  -- Command-line completion mode

-- local window options --
wo.foldmethod = 'expr'       -- tree-sitter folding mode
wo.foldexpr = 'nvim_treesitter#foldexpr()'
wo.list = true               -- Show some invisible characters (tabs...)
wo.number = true             -- Show line number
wo.relativenumber = true     -- Relative line numbers
wo.signcolumn = 'auto'       -- show sign column 

-- Set Python executable binary
vim.g.python3_host_prog = '$HOME/nvim/bin/python3'

-- Set indent-line character
vim.g.indentLine_char = '┆'

-- Rainbow parentheses on
vim.g.rainbow_active = 1
