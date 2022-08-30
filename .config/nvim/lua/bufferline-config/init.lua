--[[
88                         ad88    ad88                       
88                        d8"     d8"                         
88                        88      88                          
88,dPPYba,  88       88 MM88MMM MM88MMM ,adPPYba, 8b,dPPYba,  
88P'    "8a 88       88   88      88   a8P_____88 88P'   "Y8  
88       d8 88       88   88      88   8PP""""""" 88          
88b,   ,a8" "8a,   ,a88   88      88   "8b,   ,aa 88          
8Y"Ybbd8"'   `"YbbdP'Y8   88      88    `"Ybbd8"' 88 

88 88                         
88 ""                         
88                            
88 88 8b,dPPYba,   ,adPPYba,  
88 88 88P'   `"8a a8P_____88  
88 88 88       88 8PP"""""""  
88 88 88       88 "8b,   ,aa  
88 88 88       88  `"Ybbd8"'

Buffer line configuration for Neovim 0.7+
]]

local get_hex = require('cokeline/utils').get_hex
local keymap = vim.api.nvim_set_keymap

require('cokeline').setup({
  default_hl = {
    fg = function(buffer)
      return
        buffer.is_focused
        and get_hex('Normal', 'fg')
         or get_hex('Comment', 'fg')
    end,
    bg = 'NONE',
  },

  sidebar = {
    filetype = 'NvimTree',
    components = {
      {
        text = '  NvimTree',
        fg = yellow,
        bg = get_hex('NvimTreeNormal', 'bg'),
        style = 'bold',
      },
    }
  },

  components = {
    {
      text = function(buffer) return (buffer.index ~= 1) and '▏' or '' end,
      fg = get_hex('Normal', 'fg')
    },
    {
      text = function(buffer) return '    ' .. buffer.devicon.icon end,
      fg = function(buffer) return buffer.devicon.color end,
    },
    {
      text = function(buffer) return buffer.filename .. '    ' end,
      style = function(buffer) return buffer.is_focused and 'bold' or nil end,
    },
    {
      text = '',
      delete_buffer_on_left_click = true,
    },
    {
      text = '  ',
    },
  },
})

--[[ bufferline key mappings
Shift-Tab       goes to previous buffer
Tab             goes to next buffer
Leader p        switch with previous buffer
Leader n        switch with next buffer

FunctionKey 1-9 goes to buffer 1 to 9
Leader 1-9      switches with buffer 1 to 9
]]

keymap('n', '<S-Tab>',   '<Plug>(cokeline-focus-prev)',  { silent = true })
keymap('n', '<Tab>',     '<Plug>(cokeline-focus-next)',  { silent = true })
keymap('n', '<Leader>p', '<Plug>(cokeline-switch-prev)', { silent = true })
keymap('n', '<Leader>n', '<Plug>(cokeline-switch-next)', { silent = true })

for i = 1,9 do
  keymap('n', ('<F%s>'):format(i),      ('<Plug>(cokeline-focus-%s)'):format(i),  { silent = true })
  keymap('n', ('<Leader>%s'):format(i), ('<Plug>(cokeline-switch-%s)'):format(i), { silent = true })
end
