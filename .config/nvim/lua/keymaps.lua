--[[
    /                                         
---/-__----__---------_--_----__------__---__-
  /(     /___) /   / / /  ) /   )   /   ) (_ `
_/___\__(___ _(___/_/_/__/_(___(___/___/_(__)_
                 /                /           
             (_ /                /            
keymaps.lua

ASCII art from https://ascii.co.uk/text
style: Big Chief
]]--

-- set leader and localleader keys to ',' and '\' respectively
local kmap = vim.api.nvim_set_keymap

kmap('n', ',', '<NOP>', {noremap = true, silent = true})
vim.g.mapleader = ','

kmap('n', '\\', '<NOP>', {noremap = true, silent = true})
vim.g.maplocalleader = '\\'


--[[  Key combos for split screens:

  Ctrl+J move to the split below
  Ctrl+K move to the split above
  Ctrl+L move to the split to the right
  Ctrl+H move to the split to the left
Original Vimscript commands are commented out:
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
]]--

kmap('n', '<C-H>', '<C-W><C-H>', {noremap = true})
kmap('n', '<C-J>', '<C-W><C-J>', {noremap = true})
kmap('n', '<C-K>', '<C-W><C-K>', {noremap = true})
kmap('n', '<C-L>', '<C-W><C-L>', {noremap = true})

--[[ Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy
]]--

kmap('v', '<leader>y', '"+y', {noremap = true})
kmap('n', '<leader>Y', '"+yg_', {noremap = true})
kmap('n', '<leader>y', '"+y', {noremap = true})
kmap('n', '<leader>yy', '"+yy', {noremap = true})

--[[ Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P
]]--

kmap('n', '<leader>p', '"+p', {noremap = true})
kmap('n', '<leader>P', '"+P', {noremap = true})
kmap('v', '<leader>p', '"+p', {noremap = true})
kmap('v', '<leader>P', '"+P', {noremap = true})
