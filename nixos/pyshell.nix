# Python environment as a Nix shell
# Adapted from blog of Thomaz Leite
# https://thomazleite.com/posts/development-with-nix-python/

# and NixOS Wiki
# https://nixos.wiki/wiki/Development_environment_with_nix-shell
{ pkgs ? import <nixpkgs> {} }:

let
  customPython = pkgs.python39.buildEnv.override {
    extraLibs = with pkgs.python39Packages; [
      isort
      black
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
in

pkgs.mkShell {
buildInputs = [ customPython ];
}
