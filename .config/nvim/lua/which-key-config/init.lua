--[[
                   88          88            88           
                   88          ""            88           
                   88                        88           
8b      db      d8 88,dPPYba,  88  ,adPPYba, 88,dPPYba,   
`8b    d88b    d8' 88P'    "8a 88 a8"     "" 88P'    "8a  
 `8b  d8'`8b  d8'  88       88 88 8b         88       88  
  `8bd8'  `8bd8'   88       88 88 "8a,   ,aa 88       88  
    YP      YP     88       88 88  `"Ybbd8"' 88       88

88                                         
88                                         
88                                         
88   ,d8  ,adPPYba, 8b       d8 ,adPPYba,  
88 ,a8"  a8P_____88 `8b     d8' I8[    ""  
8888[    8PP"""""""  `8b   d8'   `"Y8ba,   
88`"Yba, "8b,   ,aa   `8b,d8'   aa    ]8I  
88   `Y8a `"Ybbd8"'     Y88'    `"YbbdP"'  
                        d8'                
                       d8'

ASCII art from https://ascii.co.uk/text
style: Default Font        
--]]
require("which-key").setup {}

local wk = require("which-key")

-- mappings which are for the leader key
local mappings = {
  q = {":q<cr>", "Quit"},
  Q = {":wq<cr>", "Save and Quit"},
  w = {":w<cr>", "Save (Write)"},
  e = {":NvimTreeToggle<cr>", "Toggle Nvim Tree"},
  E = {":e ~/.config/nvim/init.lua", "Edit base config"},

  -- Find files through Telescope.nvim
  ff = {":Telescope find_files<cr>", "Telescope find files"},
  fg = {":Telescope live_grep<cr>", "Telescope live grep"},
  fb = {":Telescope buffers<cr>", "Telescope buffers"},
  fh = {":Telescope help_tags<cr>", "Telescope help tags"}
}

local opts = {prefix = "<leader>"}

wk.register(mappings, opts)
