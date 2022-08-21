-- Treesitter - enable modules
require('nvim-treesitter.configs').setup {
--  ensure_installed = "all", -- one of "all", or a list of languages

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
