--[[
88
88
88
88   ,d8  ,adPPYba, 8b       d8
88 ,a8"  a8P_____88 `8b     d8'
8888[    8PP"""""""  `8b   d8'
88`"Yba, "8b,   ,aa   `8b,d8'
88   `Y8a `"Ybbd8"'     Y88'
                        d8'
                       d8'

88,dPYba,,adPYba,  ,adPPYYba, 8b,dPPYba,  ,adPPYba,
88P'   "88"    "8a ""     `Y8 88P'    "8a I8[    ""
88      88      88 ,adPPPPP88 88       d8  `"Y8ba,
88      88      88 88,    ,88 88b,   ,a8" aa    ]8I
88      88      88 `"8bbdP"Y8 88`YbbdP"'  `"YbbdP"'
                              88
                              88

ASCII art from https://ascii.co.uk/text
style: Default Font

Miscellaneous keymaps not covered by other plugins
]]
   -- set leader key to space
vim.g.mapleader = " "

-- Global mappings for LSP
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f',
      function() vim.lsp.buf.format { async = true } end, opts)
  end
})

-- switch to windows above / below / left / right
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true })

vim.keymap.set("n", "<C-left>", "<C-w>h", { noremap = true })
vim.keymap.set("n", "<C-right>", "<C-w>l", { noremap = true })
vim.keymap.set("n", "<C-up>", "<C-w>k", { noremap = true })
vim.keymap.set("n", "<C-down>", "<C-w>j", { noremap = true })

-- '>' in Visual mode inserts an indent
-- '<' removes it
vim.keymap.set("v", "<", "<gv", { noremap = true, silent = false })
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = false })

-- emulate <Esc> in Insert mode with 'jk' or 'kj'
vim.keymap.set("i", "jk", "<ESC>", { noremap = true })
vim.keymap.set("i", "kj", "<ESC>", { noremap = true })

-- increment/decrement numbers with <leader>= and <leader>- respectively
vim.keymap.set("n", "<leader>=", "<C-a>")
vim.keymap.set("n", "<leader>-", "<C-x>")

-- select all with Ctrl-a
vim.keymap.set("n", "<C-a>", "gg<S-v>G", { noremap = true })

-- [[ Which-key ]]
require("which-key").setup {}

local wk = require("which-key")

-- mappings which are for the leader key
local mappings = {
  q = { ":q<cr>", "Quit" },
  Q = { ":wq<cr>", "Save and Quit" },
  w = { ":w<cr>", "Save (Write)" },
  n = { ":NvimTreeToggle<cr>", "Toggle Nvim Tree" },
  E = { ":e ~/.config/nvim/init.vim<cr>", "Edit base config" },

  -- Find files through Telescope.nvim
  ff = { ":Telescope find_files<cr>", "Telescope find files" },
  fg = { ":Telescope live_grep<cr>", "Telescope live grep" },
  fb = { ":Telescope buffers<cr>", "Telescope buffers" },
  fh = { ":Telescope help_tags<cr>", "Telescope help tags" },

  -- split screens (horizontal and vertical reversed, in Python Numpy style)
  sh = { ":vsplit<cr>", "Horizontal Split(Python Style)" },
  sv = { ":split<cr>", "Vertical Split(Python Style)" },
  sd = { ":close<cr>", "Close current split" },
  se = { "<C-w>=", "Resize splits equally" },

  -- buffer actions
  bp = { ":bprevious<cr>", "Jump to previous buffer" },
  bn = { ":bnext<cr>", "Jump to next buffer" },
  be = { ":enew<cr>", "Create new buffer" },
  bd = { ":bdelete<cr>", "Close current buffer" },

  bf = { ":lua vim.lsp.buf.format({ timeout = 2000 })<cr>", "Format buffer" }
}

local opts = { prefix = "<leader>" }

wk.register(mappings, opts)
