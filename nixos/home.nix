# Configuration file for Home-Manager
{
  config,
  pkgs,
  lib,
  ...
}: let
  # Python 3.11 with packages
  my-Python-packages = pkgs.python311.buildEnv.override {
    extraLibs = with pkgs.python311Packages; [
      sympy
      seaborn
      notebook
      numpy
      matplotlib
      scikit-learn
      pandas
      scipy
      gmpy2
      isort
      black
      flake8
      statsmodels
      plotly
      pycountry
      requests
      pyyaml
      pynvim
    ];
  };

  # R Studio
  my-R-packages =
    pkgs.rstudioWrapper.override
    {
      packages = with pkgs.rPackages; [
        ggplot2
        tidyverse
        languageserver
        lintr
        styler
        devtools
      ];
    };
in {
  # Home packages
  home.packages =
    (with pkgs; [
      bat
      exa
      pfetch
      julia-bin
      my-Python-packages
      my-R-packages
      jetbrains.idea-community
      jdk17
      leiningen
      gcc
      fd
      ripgrep
      xclip
      git
      ripes # Risc-v visual simulator
      octaveFull # for x86-64 only
      # (octave.withPackages (opkgs: with opkgs;
      # [ io image statistics control optim linear-algebra dataframe symbolic ]))

      # language servers, linters, formatters
      pylint
      lua-language-server
      luaformatter
      nil
      statix
      alejandra
      sqls
      sqlfluff
      beautysh
      clojure-lsp
      clj-kondo
      joker
      rome
    ])
    # Additional nodejs packages for neovim plugins
    ++ (with pkgs.nodePackages; [
      pyright
      vscode-langservers-extracted
      jsonlint
      bash-language-server
      markdownlint-cli2
    ]);

  programs.kitty = {
    enable = true;
    settings = {
      font_size = "14.0";
      font_family      = "FiraCode";
      bold_font        = "auto";
      italic_font      = "auto";
      bold_italic_font = "auto";
      disable_ligatures = false;
      font_features = "+ss02 +ss08 +cv16 +ss05";
      scrollback_lines = 10000;
      enable_audio_bell = false;
      remember_window_size = true;
      initial_window_width  = "80c";
      initial_window_height = "25c";

      # Melange-nvim theme
      background              = "#F1F1F1";
      foreground              = "#54433A";
      cursor = "none";
      url_color               = "#7892BD";
      selection_background    = "#D9D3CE";
      selection_foreground    = "#54433A";
      tab_bar_background      = "#E9E1DB";
      active_tab_background   = "#E9E1DB";
      active_tab_foreground   = "#BC5C00";
      inactive_tab_background = "#E9E1DB";
      inactive_tab_foreground = "#54433A";
      color0                  = "#E9E1DB";
      color1                  = "#C77B8B";
      color2                  = "#6E9B72";
      color3                  = "#BC5C00";
      color4                  = "#7892BD";
      color5                  = "#BE79BB";
      color6                  = "#739797";
      color7                  = "#7D6658";
      color8                  = "#A98A78";
      color9                  = "#BF0021";
      color10                 = "#3A684A";
      color11                 = "#A06D00";
      color12                 = "#465AA4";
      color13                 = "#904180";
      color14                 = "#3D6568";
      color15                 = "#54433A";
    };
  };

  programs.bash = {
    enable = true;
    historyControl = [ "ignoredups" ];
    shellAliases = {
      ls = "exa";
      ll = "exa -la --icons";
      lt = "exa --tree --icons";
      cat = "bat";
      rebuild = "sudo nixos-rebuild switch";
    };
    sessionVariables = {
      EDITOR = "nano";
      TERMINAL = "kitty";
      BAT_THEME = "gruvbox-light";
    };
  };

  # configure neovim using nixpkgs
  programs.neovim = {
    enable = true;
    # extraConfig = ":luafile ~/.config/nvim/init.lua";
    plugins = with pkgs.vimPlugins; [
      # dependencies
      plenary-nvim
      nvim-web-devicons
      nui-nvim

      # colour themes
      tender-vim
      gruvbox-nvim

      # Autocompletion
      nvim-lspconfig
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      nvim-cmp

      # Snippet support
      luasnip
      cmp_luasnip
      friendly-snippets

      # top buffer line
      bufferline-nvim

      # bottom bar
      lualine-nvim

      # file navigation
      nvim-tree-lua

      # show indentation
      indent-blankline-nvim

      # Treesitter
      nvim-treesitter
      nvim-treesitter.withAllGrammars
      nvim-ts-rainbow2

      # Telescope
      telescope-nvim
      telescope-fzf-native-nvim

      # other useful utilities
      which-key-nvim
      comment-nvim
      null-ls-nvim
      nvim-notify
      noice-nvim
      lspkind-nvim
    ];
  };

  home.stateVersion = "23.05";
}
