
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
-- set leader key to comma
vim.g.mapleader = ","

-- Telescope keys
local builtin = require("telescope.builtin")
-- <leader>ff Find Files
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
-- <leader>fg Live Grep
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
-- <leader>fb Find Buffer
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
-- <leader>fh Find Help Tags
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

local keymap = vim.api.nvim_set_keymap

-- switch to windows above / below / left / right
keymap("n", "<C-h>", "<C-w>h", {noremap = true})
keymap("n", "<C-j>", "<C-w>j", {noremap = true})
keymap("n", "<C-k>", "<C-w>k", {noremap = true})
keymap("n", "<C-l>", "<C-w>l", {noremap = true})

keymap("n", "<C-left>",  "<C-w>h", {noremap = true})
keymap("n", "<C-right>", "<C-w>l", {noremap = true})
keymap("n", "<C-up>",    "<C-w>k", {noremap = true})
keymap("n", "<C-down>",  "<C-w>j", {noremap = true})

-- '>' in Visual mode inserts an indent
-- '<' removes it
keymap("v", "<", "<gv", {noremap = true, silent = false})
keymap("v", ">", ">gv", {noremap = true, silent = false})

-- emulate <Esc> in Insert mode with 'jk' or 'kj'
keymap("i", "jk", "<ESC>", {noremap = true})
keymap("i", "kj", "<ESC>", {noremap = true})

-- select all with Ctrl-a
keymap("n", "<C-a>", "gg<S-v>G", {noremap = true})

-- split window
keymap("n", "ss", ":split<cr><C-w>w",  {noremap = true, silent = true})
keymap("n", "sv", ":vsplit<cr><C-w>w", {noremap = true, silent = true})

-- set [b to go to previous buffer
-- set ]b to go to next buffer
keymap("n", "[b", ":bprevious<cr>", {noremap = true})
keymap("n", "]b", ":bnext<cr>", {noremap = true})
