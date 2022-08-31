--[[
                        88                     
                        ""                     
                                               
8b,dPPYba,  8b       d8 88 88,dPYba,,adPYba,   
88P'   `"8a `8b     d8' 88 88P'   "88"    "8a  
88       88  `8b   d8'  88 88      88      88  
88       88   `8b,d8'   88 88      88      88  
88       88     "8"     88 88      88      88  
                                           
 ,adPPYba, 88,dPYba,,adPYba,  8b,dPPYba,   
a8"     "" 88P'   "88"    "8a 88P'    "8a  
8b         88      88      88 88       d8  
"8a,   ,aa 88      88      88 88b,   ,a8"  
 `"Ybbd8"' 88      88      88 88`YbbdP"'   
                              88           
                              88                                                          
ASCII art from https://ascii.co.uk/text
style: Default Font	   
--]]

-- Setup nvim-cmp.
  local cmp = require'cmp'
  local lspkind = require('lspkind')

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        --vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    }),
    formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function (entry, vim_item)
        ...
        return vim_item
      end
      })
    },
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  --require('lspconfig')['<YOUR_LSP_SERVER>'].setup { capabilities = capabilities }

--[[ Julia language server - to install:
julia --project=~/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.add("LanguageServer")'
where ~/.julia/environments/nvim-lspconfig is the location where the default configuration expects LanguageServer.jl to be installed.
To update an existing install, use the following command:
julia --project=~/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.update()'
]]--
require('lspconfig')['julials'].setup {capabilities = capabilities}

-- Clojure language server - to install:
-- sudo bash < <(curl -s https://raw.githubusercontent.com/clojure-lsp/clojure-lsp/blob/master/install)
-- or alternatively if using Homebrew: brew install clojure-lsp/brew/clojure-lsp-native
-- or if on NixOS install the package clojure-lsp
require('lspconfig')['clojure_lsp'].setup {capabilities = capabilities}

-- Language server for Python - to install:
-- npm install -g pyright
-- or if on NixOS install the package nodePackages.pyright
require('lspconfig')['pyright'].setup {capabilities = capabilities}

-- R language server - to install:
-- R
-- install.packages("languageserver")
-- or if on NixOS install the package rPackages.languageserver
require('lspconfig')['r_language_server'].setup {capabilities = capabilities}

-- bash language server
-- on NixOS install package nodePackages.bash-language-server
-- otherwise: npm install -g bash-language-server
require('lspconfig')['bashls'].setup {capabilities = capabilities}

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

-- from https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua
require'lspconfig'.sumneko_lua.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
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
