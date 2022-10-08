# Configuration file for Home-Manager
{ config, pkgs, ... }:

let
  # Python 3.9 with packages
  my-Python-packages = pkgs.python39.buildEnv.override {
    extraLibs = with pkgs.python39Packages; [
      sympy
      seaborn
      notebook
      numpy
      matplotlib
      scikit-learn
      pandas
      scipy
      gmpy2
      black
      isort
      flake8
    ];
  };

  # R Studio
  my-R-packages = pkgs.rstudioWrapper.override
  { packages = with pkgs.rPackages; [
    ggplot2
    tidyverse
    languageserver
    lintr
    styler
    devtools
    ];
  };
in

{
  # Home packages
  home.packages = with pkgs; [
    bat
    exa
    pfetch
    julia-bin
    my-Python-packages
    my-R-packages
    jetbrains.idea-community
    gnome.gnome-mahjongg
    celluloid
    (octave.withPackages (opkgs: with opkgs; 
      [ io image statistics control optim linear-algebra dataframe ]))
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium.fhsWithPackages
      (ps: with ps; [ jdk11 ]);
    extensions = with pkgs.vscode-extensions; [
      betterthantomorrow.calva
      jdinhlife.gruvbox
      dracula-theme.theme-dracula
      vscodevim.vim
      yzhang.markdown-all-in-one
    ];
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

      # Gruvbox theme
      selection_foreground = "#ebdbb2";
      selection_background = "#d65d0e";

      foreground           = "#ebdbb2";
      background           = "#282828";

      color0               = "#3c3836";
      color1               = "#cc241d";
      color2               = "#98971a";
      color3               = "#d79921";
      color4               = "#458588";
      color5               = "#b16286";
      color6               = "#689d6a";
      color7               = "#a89984";
      color8               = "#928374";
      color9               = "#fb4934";
      color10              = "#b8bb26";
      color11              = "#fabd2f";
      color12              = "#83a598";
      color13              = "#d3869b";
      color14              = "#83c07c";
      color15              = "#fbf1c7";

      cursor               = "#bdae93";
      cursor_text_color    = "#665c54";

      url_color            = "#458588";
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
      EDITOR = "micro";
      TERMINAL = "kitty";
    };
  };
}
