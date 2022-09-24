# Configuration file for Home-Manager
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
      black
      flake8
    ];
  };

  R-with-my-packages = pkgs.rWrapper.override{ packages = with pkgs.rPackages; [
    ggplot2
    tidyverse
    languageserver
    lintr
    styler
    devtools
    IRkernel # activate within R:   IRkernel::installspec()
    ]; };

  clojure-devtools = with pkgs; [
    jdk
    clojure
    leiningen
    clojure-lsp
    clj-kondo
    joker
  ];
in
{
  home.packages = with pkgs; [
  	bat exa screenfetch glances
  	customPython
  	R-with-my-packages ]
    ++ clojure-devtools;

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
    	name = "calva";
    	publisher = "BetterThanTomorrow";
    	version = "2.0.304";
        sha256 = "6Mp5gBPNAdyIxbrvR6G7GvJ1ZdmVXS2v5NYCNhdHKI0=";
    }	
    ];
  };

}
