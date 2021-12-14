-- Language Server configuration
-- Follow installation notes below before running the neovim LSP.

--[[
    _        __     ____                                     
    /      /    )   /    )                                   
---/-------\-------/____/-------__----__--_/_-------------__-
  /         \     /            (_ ` /___) /    /   /    /   )
_/____/_(____/___/____________(__)_(___ _(_ __(___(____/___/_
                                                      /      
                                                     /       
lspsetup.lua

ASCII art from https://ascii.co.uk/text
style: Big Chief
]]--

-- Julia language server - to install:
-- julia --project=~/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.add("LanguageServer")'
require'lspconfig'.julials.setup{}

-- Clojure language server - to install:
-- sudo bash < <(curl -s https://raw.githubusercontent.com/clojure-lsp/clojure-lsp/blob/master/install)
require'lspconfig'.clojure_lsp.setup{}

-- Language server for Python
-- npm install -g pyright
require'lspconfig'.pyright.setup{}

-- R language server - to install:
-- R
-- install.packages("languageserver")
require'lspconfig'.r_language_server.setup{}
