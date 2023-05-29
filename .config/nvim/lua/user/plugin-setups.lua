--[[
                       ,d                                       
                       88                                       
,adPPYba,  ,adPPYba, MM88MMM 88       88 8b,dPPYba,  ,adPPYba,  
I8[    "" a8P_____88   88    88       88 88P'    "8a I8[    ""  
 `"Y8ba,  8PP"""""""   88    88       88 88       d8  `"Y8ba,   
aa    ]8I "8b,   ,aa   88,   "8a,   ,a88 88b,   ,a8" aa    ]8I  
`"YbbdP"'  `"Ybbd8"'   "Y888  `"YbbdP'Y8 88`YbbdP"'  `"YbbdP"'  
                                         88                     
                                         88                     
ASCII art from https://ascii.co.uk/text
style: Default Font	   
--]]
--[[ Treesitter Setup ]]

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query",
                       "python", "sql", "bash", "julia", "r",
                       "scala", "clojure" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  -- ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "c", "rust" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  rainbow = {
      enable = true,
      -- which query to use for finding delimiters
      query = "rainbow-parens",
      -- highlight entire buffer at once
      strategy = require("ts-rainbow").strategy.global,
  }
}

--[[ Indent Blankline ]]
require("indent_blankline").setup {
    indent_blankline_char = "┆",
    indent_blankline_buftype_exclude = { "help", "NvimTree"},
    indent_blankline_show_trailing_blankline_indent = false,
}

--[[ NvimTree ]]
require("nvim-tree").setup ({
    filters ={
        dotfiles = true,
    },
    renderer = {
        group_empty = true,
        -- Folder open and closed icons
        icons = {
            glyphs = {
                folder = {
                    arrow_closed = "▸", -- arrow when folder is closed
                    arrow_open = "▾", -- arrow when folder is open
                },
            },
        },
    },
    -- disable window_picker
    -- for explorer to work well with window splits
    actions = {
        open_file = {
            window_picker = {
                enable = false,
            },
        },
    },
})

--[[ Tokyonight Setup ]]
require("tokyonight").setup({
  -- your configuration comes here
  -- or leave it empty to use the default settings
  style = "day",
  styles = {
    -- Style to be applied to different syntax groups
    -- Value is any valid attr-list value for `:help nvim_set_hl`
    comments = { italic = true },
  },
})

--[[ Lualine Setup ]]
require("lualine").setup{
    options = { theme = "tokyonight" },
}

--[[ Telescope.nvim Setup ]]
require("telescope").setup()
require("telescope").load_extension("fzf")

--[[ Comment.nvim Setup ]]
require('Comment').setup()

--[[ Which-Key Setup ]]
require("which-key").setup {}

local wk = require("which-key")

-- mappings which are for the leader key
local mappings = {
  q = {":q<cr>", "Quit"},
  Q = {":wq<cr>", "Save and Quit"},
  w = {":w<cr>", "Save (Write)"},
  n = {":NvimTreeToggle<cr>", "Toggle Nvim Tree"},
  E = {":e ~/.config/nvim/init.lua", "Edit base config"},

  -- Find files through Telescope.nvim
  ff = {":Telescope find_files<cr>", "Telescope find files"},
  fg = {":Telescope live_grep<cr>", "Telescope live grep"},
  fb = {":Telescope buffers<cr>", "Telescope buffers"},
  fh = {":Telescope help_tags<cr>", "Telescope help tags"},

  -- Format selected text
  fo = {"<Plug>(coc-format-selected)", "Format selected text"},
  rn = {"<Plug>(coc-rename)", "Rename symbols"},

  -- Code Actions
  a  = {"<Plug>(coc-codeaction-selected)", "Selected code action"},
  ac = {"<Plug>(coc-codeaction-cursor)", "Code action cursor"},
  as = {"<Plug>(coc-codeaction-source)", "Code action source"},
  qf = {"<Plug>(coc-fix-current)", "Quick Fix current action"},

  -- Refactoring
  r  = {"<Plug>(coc-codeaction-refactor-selected)", "Selected refactor"},
  re = {"<Plug>(coc-codeaction-refactor)", "Refactor"},

  -- Code Lens actions on current line
  cl = {"<Plug>(coc-codelens-action)", "Code Lend action"},

}

local opts = {prefix = "<leader>"}

wk.register(mappings, opts)
