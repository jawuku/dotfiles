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
lsp_setup.lua

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
    

-- Julia language server - to install:
-- julia --project=~/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.add("LanguageServer")'
require'lspconfig'.julials.setup{lsp_flags}

-- Clojure language server - to install:
-- sudo bash < <(curl -s https://raw.githubusercontent.com/clojure-lsp/clojure-lsp/blob/master/install)
-- or alternatively if using Homebrew: homebrew install clojure-lsp
require'lspconfig'.clojure_lsp.setup{lsp_flags}

-- Language server for Python - to install:
--npm install -g pyright
require'lspconfig'.pyright.setup{lsp_flags}

-- R language server - to install:
-- R
-- install.packages("languageserver")
require'lspconfig'.r_language_server.setup{lsp_flags}


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
