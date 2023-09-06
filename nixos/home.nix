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
      pillow
      statsmodels
      plotly
      pycountry
      requests
      pyyaml
      pynvim
      beautifulsoup4
      ruff-lsp
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

# Neovim custom plugin
rainbow-delimiters-nvim = pkgs.vimUtils.buildVimPlugin {
  name = "rainbow-delimiters-nvim";
  src = pkgs.fetchFromGitHub {
    owner = "HiPhish";
    repo = "rainbow-delimiters.nvim";
    rev = "9cbd3dc409af1f5531778ccd1ea6bce668241f39";
    sha256 = "4aH2UhG1alE9F1jOMZUSSnvHmWYR6QSC4HwH3oOv5GM=";
  };
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
      ruff
      lua-language-server
      luaformatter
      nil
      statix
      alejandra
      sqls
      sqlfluff
      beautysh
      clojure-lsp
      joker
      rome
    ])
    # Additional nodejs packages for neovim plugins
    ++ (with pkgs.nodePackages; [
      vscode-langservers-extracted
      jsonlint
      bash-language-server
      markdownlint-cli
    ]);

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
      BAT_THEME = "Twodark";
    };
  };

  # configure neovim using nixpkgs
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      # dependencies
      plenary-nvim
      nvim-web-devicons
      nui-nvim

      # colour themes
      tender-vim
      melange-nvim

      # Autocompletion
      nvim-lspconfig
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      nvim-cmp
      nvim-autopairs

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
      rainbow-delimiters-nvim

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
