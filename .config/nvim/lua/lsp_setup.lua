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
--[[
-- Julia language server - to install:
julia --project=~/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.add("LanguageServer")'

-- Clojure language server - to install:
sudo bash < <(curl -s https://raw.githubusercontent.com/clojure-lsp/clojure-lsp/blob/master/install)
or alternatively if using Homebrew: homebrew install clojure-lsp

-- Language server for Python - to install:
npm install -g pyright

-- R language server - to install:
R
install.packages("languageserver")

]]--

local servers = {'julials', 'clojure_lsp', 'pyright', 'r_language_server' }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
end

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
