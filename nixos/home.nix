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
    octaveFull
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
    sessionVariables = { EDITOR = "micro"; };
  };
}
