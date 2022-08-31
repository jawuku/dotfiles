 --[[
            88                         88                        
            88                         ""                        
            88                                                   
8b,dPPYba,  88 88       88  ,adPPYb,d8 88 8b,dPPYba,  ,adPPYba,  
88P'    "8a 88 88       88 a8"    `Y88 88 88P'   `"8a I8[    ""  
88       d8 88 88       88 8b       88 88 88       88  `"Y8ba,   
88b,   ,a8" 88 "8a,   ,a88 "8a,   ,d88 88 88       88 aa    ]8I  
88`YbbdP"'  88  `"YbbdP'Y8  `"YbbdP"Y8 88 88       88 `"YbbdP"'  
88                          aa,    ,88                           
88                           "Y8bbdP"                            

ASCII art from https://ascii.co.uk/text
style: Default Font	   

 new config style inspired by Christian Chiarulli's options page
 https://github.com/ChristianChiarulli/nvim/blob/master/lua/user/options.lua
]]
-- Automatically run :PackerCompile when plugins.lua altered
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function(use)
-- Packer can manage itself
  use "wbthomason/packer.nvim"

-- Tender vim colourscheme
  use "jacoborus/tender"

-- LunarVim's Dark+ colourscheme
  use "LunarVim/darkplus.nvim"

-- Treesitter
  use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}

-- Neovim Treesitter Rainbow brackets
  use "p00f/nvim-ts-rainbow"

-- Lualine status line
  use {"nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true }}

-- Bufferline
  use {"noib3/nvim-cokeline",
    requires = "kyazdani42/nvim-web-devicons"} -- If you want devicons

-- Nvim Tree - file explorer
  use {"kyazdani42/nvim-tree.lua",
    config = function() require("nvim-tree").setup{} end,
    requires = {"kyazdani42/nvim-web-devicons"}, -- optional, for file icons
    tag = "nightly"} -- optional, updated every week. (see issue #1193)

-- close brackets automatically i.e. ( ), [ ], { }
  use {"windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {
      disable_filetype = { "TelescopePrompt" , "vim" },
      check_ts = true,
    }
  end
  }

-- Nvim-Telescope : fuzzy file finder
  use {"nvim-telescope/telescope.nvim", tag = "0.1.0",
  -- or                            , branch = '0.1.x',
    requires = { {"nvim-lua/plenary.nvim"} }
  }
-- Nvim-Telescope fzf-native
  use {"nvim-telescope/telescope-fzf-native.nvim", run = "make" }

-- Which-key : configure keybindings
  use "folke/which-key.nvim"

-- Nvim-cmp : autocompletion
  use "neovim/nvim-lspconfig"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "hrsh7th/nvim-cmp"

-- Snippets
  use "L3MON4D3/LuaSnip"
  use "saadparwaiz1/cmp_luasnip"

-- Display completion icons
  use "onsails/lspkind.nvim"
end)
