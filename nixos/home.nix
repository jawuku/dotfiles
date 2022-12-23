# Configuration file for Home-Manager
{ config, pkgs, ... }:

let
  # Python 3.10 with packages
  my-Python-packages = pkgs.python310.buildEnv.override {
    extraLibs = with pkgs.python310Packages; [
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
      statsmodels
      plotly
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
    gnome.eog
    lollypop
    meteo
    fragments
    celluloid
    drawing
    mousai
    blanket
    dialect
    # (octave.withPackages (opkgs: with opkgs; 
    # [ io image statistics control optim linear-algebra dataframe symbolic ]))
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium.fhsWithPackages
      (ps: with ps; [ jdk17 ]);
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

      # Gruvbox theme
      cursor                  = "#928374";
      cursor_text_color       = "#fbf1c7";

      url_color               = "#458588";
 
      visual_bell_color       = "#689d6a";
      bell_border_color       = "#689d6a";

      active_border_color     = "#b16286";
      inactive_border_color   = "#1d2021";

      background              = "#fbf1c7";
      foreground              = "#282828";
      selection_foreground    = "#928374";
      selection_background    = "#3c3836";

      active_tab_foreground   = "#282828";
      active_tab_background   = "#928374";
      inactive_tab_foreground = "#7c6f64";
      inactive_tab_background = "#ebdbb2";

      # white (bg3/bg4)
      color0                  = "#bdae93";
      color8                  = "#a89984";

      # red
      color1                  = "#cc241d";
      color9                  = "#9d0006";

      # green
      color2                  = "#98971a";
      color10                 = "#79740e";

      # yellow
      color3                  = "#d79921";
      color11                 = "#b57614";

      # blue
      color4                  = "#458588";
      color12                 = "#076678";

      # purple
      color5                  = "#b16286";
      color13                 = "#8f3f71";

      # aqua
      color6                  = "#689d6a";
      color14                 = "#427b58";

      # black (fg4/fg3)
     color7                  = "#7c6f64";
     color15                 = "#665c54";
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
  
  home.stateVersion = "22.11";
}
