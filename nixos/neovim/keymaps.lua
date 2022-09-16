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

Key combos for split screens:
Ctrl+J move to the split below
Ctrl+K move to the split above
Ctrl+L move to the split to the right
Ctrl+H move to the split to the left
]]
local keymap = vim.api.nvim_set_keymap

-- Map leader key to space
vim.g.mapleader = " "

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



--[[ Telescope.nvim keys: Find files using Telescope command-line sugar.
keymap("n", "<leader>ff", ":Telescope find_files<cr>", {noremap = true})
keymap("n", "<leader>fg", ":Telescope live_grep<cr>", {noremap = true})
keymap("n", "<leader>fb", ":Telescope buffers<cr>", {noremap = true})
keymap("n", "<leader>fh", ":Telescope help_tags<cr>", {noremap = true})
]]