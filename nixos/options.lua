local myoptions = {
  expandtab = true,          -- Use spaces instead of tabs
  modeline = false,          -- don't display mode, as status bar does this
  shiftwidth = 4,            -- Size of an indent
  smartindent = true,        -- Insert indents automatically
  tabstop = 4,               -- Number of spaces tabs count for
  softtabstop = 4,
  autochdir = true,          -- automatically change directory
  clipboard = 'unnamed,unnamedplus', -- clipboard integrates with desktop
  cmdheight = 2,             -- allows displaying of error messages below 
  confirm = true,            -- Confirm to save file on exit
  hidden = true,             -- Enable modified buffers in background
  ignorecase = true,         -- Ignore case
  joinspaces = false,        -- No double spaces with join after a dot
  scrolloff = 4,             -- Lines of context
  shiftround = true,         -- Round indent
  showmode = false,          -- remove --INSERT-- notifications
  sidescrolloff = 8,         -- Columns of context
  smartcase = true,          -- Don't ignore case with capitals
  splitbelow = true,         -- Put new windows below current
  splitright = true,         -- Put new windows right of current
  termguicolors = true,      -- True color support
  wildmode = 'list:longest', -- Command-line completion mode
  foldmethod = 'expr',       -- tree-sitter folding mode
  foldexpr = 'nvim_treesitter#foldexpr()',
  list = true,               -- Show some invisible characters (tabs...)
  number = true,             -- Show line number
  relativenumber = true,     -- Relative line numbers
  signcolumn = 'auto',       -- show sign column 
  undofile = true,
  background = 'dark',
  completeopt = {'menu', 'menuone', 'noselect'} -- for nvim-cmp
  }

for k, v in pairs(myoptions) do
  vim.opt[k] = v
end

