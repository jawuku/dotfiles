# Configuration file for Home-Manager
# has configuration and plugins for Neovim
# as well as languages such as R, Clojure, NodeJS and Octave

{ config, pkgs, ... }:
{
imports = [ neovim.nix ];

  home.packages = with pkgs; [
    bat
    exa
    screenfetch
    glances
    most
    tree-sitter
    R
    rstudio
    rPackages.languageserver
    rPackages.tidyverse
    rPackages.devtools
    rPackages.IRkernel
    rPackages.ggplot2
    rPackages.lintr
    rPackages.styler
   # python39Packages.sympy
   # python39Packages.seaborn
   # python39Packages.notebook
   # python39Packages.numpy
   # python39Packages.matplotlib
   # python39Packages.scikit-learn
   # python39Packages.pandas
   # python39Packages.scipy
   # python39Packages.gmpy2
   # python39Packages.pillow-simd
    nodejs
    nodePackages.pyright
    nodePackages.bash-language-server
    nodePackages.vim-language-server
    # julia_17-bin # only for x86_64
    clojure
    clojure-lsp
    leiningen
    octaveFull
    fzf
    ripgrep
    sumneko-lua-language-server
  ];
  
  programs.bat.enable = true;
  
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    
    shellAliases = {
      cat = "bat";
      ls  = "exa";
      ll  = "exa -la --icons";
      lt  = "exa --tree";
      update  = "sudo nix-channel update";
      upgrade = "sudo nixos-rebuild switch";
    };
    
    sessionVariables = {
      EDITOR = "nano";
      TERM   = "kitty";
      PAGER  = "most";
    };
  };
  
  programs.kitty = {
    enable = true;
    settings = {
      font_size = "14.0";
      font_family      = "FiraCode Nerd Font";
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
    };
  };
}
