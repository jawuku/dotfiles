--[[
                                               /                ,           
---__----__--_/_-------------__----------__---/-----------__--------__---__-
  (_ ` /___) /    /   /    /   )       /   ) /   /   /  /   ) /   /   ) (_ `
_(__)_(___ _(_ __(___(____/___/_______/___/_/___(___(__(___/_/___/___/_(__)_
                         /           /                    /                 
                        /           /                 (_ / 
setup_plugins.lua	

ASCII art from https://ascii.co.uk/text
style: Big Chief					
]]--

-- Treesitter - enable modules
require('nvim-treesitter.configs').setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  
    highlight = {
    enable = true              -- false will disable the whole extension
  },

  indent = {
    enable = true
  },
  
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  },
  
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}

-- Telescope.nvim setup
require('telescope').setup()
require('telescope').load_extension('fzy_native')

-- Developer Icons
require('nvim-web-devicons').setup {
 default = true;
}

-- Bufferline setup
require'bufferline'.setup()

-- Comment.nvim
require('Comment').setup()

-- Lualine setup
require('lualine').setup()
