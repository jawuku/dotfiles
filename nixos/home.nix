# Configuration file for Home-Manager
{
  config,
  pkgs,
  ...
}: let

  # Add unstable channel to install a few packages - type following 2 commands:
  # sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable 
  # sudo nix-channel --update nixos-unstable
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
  
   Python with packages
   my-Python-packages = ps:
     with ps; [
       sympy
       seaborn
       scikit-learn
       gmpy2
       statsmodels
       requests
       pyyaml
       pycountry
       pynvim
       beautifulsoup4
       pyspark
       isort
       black
       pylint
     ];

in {

  # Home packages
  home.packages =
    (with pkgs; 
    let
      R-with-packages = rWrapper.override{ 
        packages = with rPackages; [
          tidyverse
          languageserver
        ];
      };
    in
    [
      bat
      exa
      pfetch
      julia-bin
      # (python311.withPackages my-Python-packages)
      R-with-packages
      gcc
      xclip
      ripes # Risc-v visual simulator
      sqlite
      sequeler
      # language servers, linters, formatters
      nil # nix language server
      nixpkgs-fmt # nix formatter
      sqls # old sqls (to be replaced with sql-language-server)
      sqlfluff # sql linter and formatter
      shfmt # bash shell script formatter
      marksman # markdown language server
      taplo # toml language server, written in Rust
    ])

    # Additional nodejs packages for language servers
    ++ (with pkgs.nodePackages; [
      vscode-langservers-extracted
      bash-language-server
      pyright
    ])

    # Add any packages from 'unstable' channel to get latest versions
    ++ (with unstable; [
      helix
      ruff
      ruff-lsp
      scala_3
      sbt
      metals
      graalvm-ce
    ]);

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    shellAliases = {
      ls = "exa";
      ll = "exa -la --icons";
      lt = "exa --tree --icons";
      cat = "bat";
      rebuild = "sudo nixos-rebuild switch";
      trash = "sudo nix-collect-garbage -d";
      update = "sudo nix-channel --update";
      nixconfig = "sudo -Es hx /etc/nixos/configuration.nix";
      homeconfig = "sudo -Es hx /etc/nixos/home.nix";
    };
    sessionVariables = {
      EDITOR = "hx";
      BAT_THEME = "TwoDark";
    };
  };

  home.stateVersion = "23.05";
}
