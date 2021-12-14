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

local keymap = vim.api.nvim_set_keymap

-- Remap space as leader key
keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Remap for dealing with word wrap
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

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

keymap('n', '<C-H>', '<C-W><C-H>', {noremap = true})
keymap('n', '<C-J>', '<C-W><C-J>', {noremap = true})
keymap('n', '<C-K>', '<C-W><C-K>', {noremap = true})
keymap('n', '<C-L>', '<C-W><C-L>', {noremap = true})

--[[ Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy
]]--

keymap('v', '<leader>y', '"+y', {noremap = true})
keymap('n', '<leader>Y', '"+yg_', {noremap = true})
keymap('n', '<leader>y', '"+y', {noremap = true})
keymap('n', '<leader>yy', '"+yy', {noremap = true})

--[[ Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P
]]--

keymap('n', '<leader>p', '"+p', {noremap = true})
keymap('n', '<leader>P', '"+P', {noremap = true})
keymap('v', '<leader>p', '"+p', {noremap = true})
keymap('v', '<leader>P', '"+P', {noremap = true})

--[[ Telescope.nvim mappings
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
]]--
keymap('n', '<leader>ff', '<cmd>lua require('telescope.builtin').find_files()<cr>', {noremap = true})
keymap('n', '<leader>fg', '<cmd>lua require('telescope.builtin').live_grep()<cr>', {noremap = true})
keymap('n', '<leader>fb', '<cmd>lua require('telescope.builtin').buffers()<cr>', {noremap = true})
keymap('n', '<leader>fh', '<cmd>lua require('telescope.builtin').help_tagss()<cr>', {noremap = true})

-- LSP keybindings
local nvim_lsp = require 'lspconfig'
local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end
