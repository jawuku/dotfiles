# Configuration file for Home-Manager
# has configuration and plugins for Neovim
# as well as languages such as R, Clojure, NodeJS and Octave

{ config, pkgs, ... }:

let
  customPython = pkgs.python39.buildEnv.override {
    extraLibs = with pkgs.python39Packages; [
      isort
      sympy
      seaborn
      notebook
      numpy
      matplotlib
      scikit-learn
      pandas
      scipy
      gmpy2
      pynvim
      flake8
    ];
  };

  R-with-my-packages = rWrapper.override{ packages = with rPackages; [
    ggplot2
	  tidyverse
    languageserver
	  lintr
	  styler
	  devtools
	  IRkernel
	]; };
in

{
imports = [ ./neovim.nix ];

  home.packages = with pkgs; [
    bat
    exa
    screenfetch
    glances
	  customPython # Python with packages specified above
	  R-with-my-packages # R with packages specified above
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
      lt  = "exa --tree --icons";
      update  = "sudo nix-channel update";
      upgrade = "sudo nixos-rebuild switch";
    };
    
    sessionVariables = {
      EDITOR = "nano";
      TERMINAL = "kitty";
      BAT_THEME = "Visual Studio Dark+";
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