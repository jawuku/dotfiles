--[[
  ,d                                      
  88                                      
MM88MMM 8b,dPPYba,  ,adPPYba,  ,adPPYba,  
  88    88P'   "Y8 a8P_____88 a8P_____88  
  88    88         8PP""""""" 8PP"""""""  
  88,   88         "8b,   ,aa "8b,   ,aa  
  "Y888 88          `"Ybbd8"'  `"Ybbd8"' 

                                                   
          88                                       
          ""   ,d      ,d                          
               88      88                          
,adPPYba, 88 MM88MMM MM88MMM ,adPPYba, 8b,dPPYba,  
I8[    "" 88   88      88   a8P_____88 88P'   "Y8  
 `"Y8ba,  88   88      88   8PP""""""" 88          
aa    ]8I 88   88,     88,  "8b,   ,aa 88          
`"YbbdP"' 88   "Y888   "Y888 `"Ybbd8"' 88          

ASCII art from https://ascii.co.uk/text
style: Default Font
]]--

require "nvim-treesitter.configs".setup {

  -- A list of parser names, or "all"
  ensure_installed = "all",

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  -- ignore_install = { "erlang" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "erlang" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

  rainbow = {
    enable = true,
    -- disable = {"vim", "jsx"} -- list of languages to disable plugin for
    extended_mode = false,
    max_file_lines = nil,
    -- colors = {} -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },

  autopairs = {
    enable = true,
  },
}
