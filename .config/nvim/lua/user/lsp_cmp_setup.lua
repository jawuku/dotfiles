--[[ Language Server configuration
 
Follow installation notes below before running the neovim LSP.

    _        __     ____                                   __     _   _    ____           __                            
    /      /    )   /    )                       /       /    )   /  /|    /    )       /    )                          
---/-------\-------/____/--------__----__----__-/-------/--------/| /-|---/____/--------\--------__--_/_-------------__-
  /         \     /            /   ) /   ) /   /       /        / |/  |  /               \     /___) /    /   /    /   )
_/____/_(____/___/____________(___(_/___/_(___/_______(____/___/__/___|_/____________(____/___(___ _(_ __(___(____/___/_
                                                                                                                 /      
                                                                                                                /        
lsp_cmp_setup.lua

ASCII art from https://ascii.co.uk/text
style: Big Chief
]]--

-- nvim-cmp (completion engine)
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lsp_flags = {
        on_attach = on_attach,
        capabilities = capabilities
}
    

--[[ Julia language server - to install:

julia --project=~/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.add("LanguageServer")'

where ~/.julia/environments/nvim-lspconfig is the location where the default configuration expects LanguageServer.jl to be installed.

To update an existing install, use the following command:

julia --project=~/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.update()'
]]--
require'lspconfig'.julials.setup{lsp_flags}

-- Clojure language server - to install:
-- sudo bash < <(curl -s https://raw.githubusercontent.com/clojure-lsp/clojure-lsp/blob/master/install)
-- or alternatively if using Homebrew: brew install clojure-lsp/brew/clojure-lsp-native
-- or if on NixOS install the package clojure-lsp
require'lspconfig'.clojure_lsp.setup{lsp_flags}

-- Language server for Python - to install:
-- npm install -g pyright
-- or if on NixOS install the package nodePackages.pyright
require'lspconfig'.pyright.setup{lsp_flags}

-- R language server - to install:
-- R
-- install.packages("languageserver")
-- or if on NixOS install the package rPackages.languageserver
require'lspconfig'.r_language_server.setup{lsp_flags}

-- bash language server
-- on NixOS install package nodePackages.bash-language-server
-- otherwise: npm i -g bash-language-server
require'lspconfig'.bashls.setup{lsp_flags}

--[[ Lua language server - to install:
 if using homebrew (easy) : brew install lua-language-server
 NixOS : install the package sumneko-lua-language-server
 
-- otherwise (more involved)
git clone https://github.com/sumneko/lua-language-server

cd lua-language-server

git submodule update --init --recursive

cd 3rd/luamake
./compile/install.sh
cd ../..
./3rd/luamake/luamake rebuild

sudo ln -s ~/lua-language-server/bin/lua-language-server /usr/local/bin/lua-language-server

]]--

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require'lspconfig'.sumneko_lua.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
      -- { name = 'vsnip' }, -- For vsnip users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })
