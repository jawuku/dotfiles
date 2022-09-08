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

-- Tender colourscheme
-- use "jacoborus/tender"
use {"lanej/tender",
  config = function() require("tender") end,
  requires = { "rkjmp/lush.nvim" } }

-- LunarVim's Dark+ colourscheme
use "LunarVim/darkplus.nvim"

-- Solarized nvim colourscheme
use "shaunsingh/solarized.nvim"

-- Treesitter
use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}

-- Neovim Treesitter Rainbow brackets
use "p00f/nvim-ts-rainbow"

-- Lualine status line
use {"nvim-lualine/lualine.nvim",
  config = function() require("lualine").setup {
    options = { theme = "papercolor_light" } } end,
  requires = { "kyazdani42/nvim-web-devicons", opt = true } }

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
 -- or                           , branch = '0.1.x',
  requires = { {"nvim-lua/plenary.nvim"} }
}

-- Nvim-Telescope fzf-native
use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }

-- Which-key : configure keybindings
use "folke/which-key.nvim"

-- Lsp-Zero
use {
   "VonHeikemen/lsp-zero.nvim",
  requires = {
  -- LSP Support    
  {"williamboman/mason.nvim",
    config = function() require("mason").setup()
                        require("mason-lspconfig").setup()
    end},
  {"williamboman/mason-lspconfig.nvim"},
  {"neovim/nvim-lspconfig"},

  -- Nvim-cmp : autocompletion
  {"hrsh7th/nvim-cmp"},
  {"hrsh7th/cmp-buffer"},
  {"hrsh7th/cmp-path"},
  {"hrsh7th/cmp-cmdline"},
  {"hrsh7th/cmp-nvim-lsp"},
  {"hrsh7th/cmp-nvim-lua"},

  -- Snippets
  {"L3MON4D3/LuaSnip"},
  {"saadparwaiz1/cmp_luasnip"},
  {"rafamadriz/friendly-snippets"},
  }
}

-- Display completion icons
use "onsails/lspkind.nvim"

end)
