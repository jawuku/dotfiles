# Nixos neovim configuration in Home Manager
# Adapted from Srid's Neovim config
# https://github.com/srid/nixos-config/blob/master/home/neovim.nix

{ pkgs, inputs, system, ... }:

# to get rev, define new custom plugin, clone repo and do 'git log'
# for the latest revision (top entry)

# to get sha256, put in a dummy argument,
# and replace with the correct value specified in the error message
let
  LunarVim-darkplus-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "LunarVim-darkplus-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "LunarVim";
      repo = "darkplus.nvim";
      rev = "49cfa2b2aaea0389436e6bc220a92c998249d10f";
      sha256 = "sha256-HAVHEqq//SaQ3Eblfc3T00vM5ZrT3gFr5Up+v/CybBY=";
  };
};
in

{
  imports = [
    ./telescope.nix
  ];
  
  programs.neovim = {
    enable = true;

    # extraPackages = with pkgs; [];  

    plugins = with pkgs.vimPlugins; [
      # install alltree-sitter grammars
      (nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars))

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
      nvim-ts-rainbow # rainbow brackets [] {} ()

      # Preferred themes
      tender-vim
      gruvbox-nvim
      LunarVim-darkplus-nvim # custom plugin from LunarVim/darkplus.nvim from github
      
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
      ${builtins.readFile ./options.lua}
      ${builtins.readFile ./treesitter.lua}
      ${builtins.readFile ./lsp.lua}
      EOF
      colorscheme darkplus
    '';
  };
}
