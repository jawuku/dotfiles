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

-- [[ Set up nvim-cmp ]]
local cmp = require 'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end
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
    ['<CR>'] = cmp.mapping.confirm({ select = true }) -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' }, { name = 'luasnip' } -- For luasnip users.
  }, { { name = 'buffer' } })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' } -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
  }, { { name = 'buffer' } })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = { { name = 'buffer' } }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } })
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local langservers = { 'pyright', 'bashls', 'nil_ls', 'sqls', 'clojure_lsp', 'julials' }

for _, lsp in ipairs(langservers) do
  require('lspconfig')[lsp].setup { capabilities = capabilities }
end

-- separate configs for jsonls and luals
-- Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require 'lspconfig'.jsonls.setup { capabilities = capabilities }

require 'lspconfig'.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT'
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' }
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true)
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = { enable = false }
    }
  }
}

-- [[ Friendly Snippets Setup ]]
require("luasnip.loaders.from_vscode").lazy_load()

-- [[ lualine ]]
require('lualine').setup {
   options = { theme = "tokyonight" },
  --options = { theme = "papercolor_light" }
}

-- [[ Bufferline ]]
require("bufferline").setup{}

-- [[ Nvim-Tree ]]
require("nvim-tree").setup({
  filters = { dotfiles = true },
  renderer = {
    group_empty = true,
    -- Folder open and closed icons
    icons = {
      glyphs = {
        folder = {
          arrow_closed = "▸", -- arrow when folder is closed
          arrow_open = "▾"  -- arrow when folder is open
        }
      }
    }
  },
  -- disable window_picker
  -- for explorer to work well with window splits
  actions = { open_file = { window_picker = { enable = false } } }
})

-- [[ TokyoNight ]]
require("tokyonight").setup({
  styles = {
    -- Style to be applied to different syntax groups
    -- Value is any valid attr-list value for `:help nvim_set_hl`
    comments = { italic = true }
  }
})

-- [[ Tree-sitter ]]
require 'nvim-treesitter.configs'.setup {
  highlight = { enable = true, additional_vim_regex_highlighting = false },
  rainbow = {
    enable = true,
    -- which query to use for finding delimiters
    query = "rainbow-parens",
    -- highlight entire buffer at once
    strategy = require("ts-rainbow").strategy.global
  }
}

--[[ Telescope.nvim ]]
require("telescope").setup()
require("telescope").load_extension("fzf")

-- [[ Comment-nvim ]]
require('Comment').setup()

-- [[ Noice ]]
require("noice").setup({
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
})

-- [[ Null-ls ]]
local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.trail_space, -- eliminate whitespace
    null_ls.builtins.completion.luasnip,      -- integrate snippets
    null_ls.builtins.diagnostics.pylint,      -- Python linter
    null_ls.builtins.formatting.isort,        -- Python sort imports
    null_ls.builtins.formatting.black,        -- Python general formatter
    null_ls.builtins.diagnostics.tidy,        -- HTML and XML linter
    null_ls.builtins.formatting.tidy,         -- and formatter
    null_ls.builtins.diagnostics.sqlfluff.with({
      extra_args = { "--dialect", "sqlite" }
    }),                                           -- sqlite linter
    null_ls.builtins.formatting.sqlfluff.with({
      extra_args = { "--dialect", "sqlite" }
    }),                                           -- and formatter
    null_ls.builtins.diagnostics.statix,          -- nix linter
    null_ls.builtins.formatting.alejandra,        -- nix formatter
    null_ls.builtins.formatting.beautysh,         -- bash formatter
    null_ls.builtins.formatting.lua_format.with({ -- lua formatter
      extra_args = { "--indent-width=2" }
    }), null_ls.builtins.diagnostics.clj_kondo,   -- clojure linter
    null_ls.builtins.formatting.joker,            -- clojure formatter
    null_ls.builtins.diagnostics.jsonlint,        -- json linter
    null_ls.builtins.formatting.rome,             -- json, js formatter
    null_ls.builtins.formatting.markdownlint      -- markdown linter
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
          -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
          vim.lsp.buf.format({ async = false })
        end
      })
    end
  end
})

-- [[Lspkind Setup ]]
local lspkind = require('lspkind')
cmp.setup {
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function (entry, vim_item)
        ...
        return vim_item
      end
    })
  }
}
