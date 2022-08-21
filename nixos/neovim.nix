{ pkgs, inputs, system, ... }:
let
  lunarvim-darkplus = callPackage ./lunarvim-darkplus.nix { };
in
{
  imports = [
    telescope.nix
  ];
  
  programs.neovim = {
    enable = true;

    extraPackages = with pkgs; [
      (nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars))
    ];

# Full list here,
# https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/editors/vim/plugins/generated.nix
    plugins = with pkgs.vimPlugins; [
      # completion using language servers
      
      nvim-lspconfig
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      nvim-cmp
      luasnip
      cmp_luasnip
       
      # telescope nvim - loaded in telescope.nix

      # other plugins
      plenary-nvim
      nvim-web-devicons

      # tree-sitter plugins
      nvim-ts-rainbow

      # Preferred themes
      tender-vim
      gruvbox-nvim
      lunarvim-darkplus # custom plugin from LunarVim/darkplus.nvim from github
      # status bar
      {
        plugin = lualine-nvim;
        type = "lua";
        config = ''
          require('lualine').setup {
            options = {
              theme = 'papercolor_light'
            }
          }
        '';
      }

      # Buffer tabs
      {
        plugin = bufferline-nvim;
        type = "lua";
        config = ''
          require("bufferline").setup{ }
          nmap("<leader>b", ":BufferLineCycleNext<cr>")
          nmap("<leader>B", ":BufferLineCyclePrev<cr>")
        '';
      }

      # Autopairs
      {
        plugin = nvim-autopairs;
        type = "lua";
        config = ''
          require("nvim-autopairs").setup {}
        '';
        }

      # Indent line marker
      {
        plugin = indent-blankline-nvim;
        type = "lua";
        config = ''
          indent_blankline.setup {
            char = "┆",
            show_trailing_blankline_indent = false,
            show_first_indent_level = true,
            use_treesitter = true,
            show_current_context = true,
            buftype_exclude = { "terminal", "nofile" },
            filetype_exclude = {
              "help",
              "packer",
              "NvimTree",
            },
          }
        '';
      }
      # Language support
      vim-nix

      vim-markdown
    ];

    # Add library code here for use in the Lua config from the
    # plugins list above.
    extraConfig = ''
      lua << EOF
      ${builtins.readFile ./neovim/options.lua}
      ${builtins.readFile ./neovim/treesitter.lua}
      ${builtins.readFile ./neovim/lsp.lua}
      vim.cmd [[colorscheme darkplus]]
      EOF
    '';
  };

}
