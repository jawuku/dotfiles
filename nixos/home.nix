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
  # Kitty TokyoNight Moon config
  # license: MIT
  # author: Folke Lemaitre
  # upstream: https://github.com/folke/tokyonight.nvim/raw/main/extras/kitty/tokyonight_moon.conf
  programs.kitty = {
    enable = true;
    settings = {
      font_size = "14.0";
      font_family = "FiraCode";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      disable_ligatures = false;
      font_features = "+ss02 +ss08 +cv16 +ss05";
      scrollback_lines = 10000;
      enable_audio_bell = false;
      remember_window_size = true;
      initial_window_width = "80c";
      initial_window_height = "25c";

      # TokyoNight Moon theme

      background = "#222436";
      foreground = "#c8d3f5";
      selection_background = "#2d3f76";
      selection_foreground = "#c8d3f5";
      url_color = "#4fd6be";
      cursor = "#c8d3f5";
      cursor_text_color = "#222436";

      # Tabs
      active_tab_background = "#82aaff";
      active_tab_foreground = "#1e2030";
      inactive_tab_background = "#2f334d";
      inactive_tab_foreground = "#545c7e";
      #tab_bar_background #1b1d2b

      # Windows
      active_border_color = "#82aaff";
      inactive_border_color = "#2f334d";

      # normal
      color0 = "#1b1d2b";
      color1 = "#ff757f";
      color2 = "#c3e88d";
      color3 = "#ffc777";
      color4 = "#82aaff";
      color5 = "#c099ff";
      color6 = "#86e1fc";
      color7 = "#828bb8";

      # bright
      color8 = "#444a73";
      color9 = "#ff757f";
      color10 = "#c3e88d";
      color11 = "#ffc777";
      color12 = "#82aaff";
      color13 = "#c099ff";
      color14 = "#86e1fc";
      color15 = "#c8d3f5";

      # extended colors
      color16 = "#ff966c";
      color17 = "#c53b53";
    };
  };

  programs.bash = {
    enable = true;
    historyControl = ["ignoredups"];
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
      BAT_THEME = "Monokai Extended";
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
      tokyonight-nvim

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
    ];
  };

  home.stateVersion = "23.05";
}
