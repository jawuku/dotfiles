## Nix Install on Debian 13 / Testing
### Also guidance from [Vimjoyer's YouTube video](https://www.youtube.com/watch?v=cZDiqGWPHKI)
#### Update system, reboot if needed
```sh
sudo apt update
sudo apt dist-upgrade
```
#### Install basic utilities
```sh
sudo apt install build-essential curl
```
### Installing Nix using the [Determinate Nix Installer](https://determinate.systems/posts/determinate-nix-installer/)
```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
sh -s -- install --determinate
```
#### Either open a new shell, or type in the following:
```sh
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
```
#### Verify Nix has been installed
```sh
nix --version
```
- You should see something like
> nix (Determinate Nix 3.4.2) 2.28.3
### Set up Python Development Environment
```sh
cd ~
mkdir python-nix
cd python-nix

nix flake init --template "github:DeterminateSystems/zero-to-nix#python-dev"
```
#### Change `flake.nix` to this for a Python 3.12 environment
```nix
{
  description = "Example Python development environment for Zero to Nix";

  # Flake inputs
  inputs = {
    # Latest stable Nixpkgs
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0";
  };

  # Flake outputs
  outputs =
    { self, nixpkgs }:
    let
      # Systems supported
      allSystems = [
        "x86_64-linux" # 64-bit Intel/AMD Linux
        "aarch64-linux" # 64-bit ARM Linux
        "x86_64-darwin" # 64-bit Intel macOS
        "aarch64-darwin" # 64-bit ARM macOS
      ];

      # Helper to provide system-specific attributes
      forAllSystems =
        f:
        nixpkgs.lib.genAttrs allSystems (
          system:
          f {
            pkgs = import nixpkgs { inherit system; };
          }
        );
    in
    {
      # Development environment output
      devShells = forAllSystems (
        { pkgs }:
        {
          default =
            let
              # Use Python 3.12
              python = pkgs.python312;
            in
            pkgs.mkShell {
              # The Nix packages provided in the environment
              packages = [
                # Python plus helper tools
                (python.withPackages (
                  ps: with ps; [
                    sympy
                    seaborn
                    scikit-learn
                    gmpy2
                    mpmath
                    statsmodels
                    requests
                    pyyaml
                    pycountry
                    beautifulsoup4
                    jupyter
                    yfinance
                    sqlparse
                    python-lsp-ruff
                    python-lsp-server
                    ruff
                  ]
                ))
              ];
              shellHook = ''
                echo
                echo "-~= Welcome to the Python 3.12 development environment =~-"
              '';
            };
        }
      );
    };
}
```
#### Then update to new configuration
#### This also updates `flake.lock` automatically
```sh
nix flake update
```
#### To enter Python develop environment
```sh
nix develop

# Try using the `numpy` library
python -c "import numpy as np;a=[2,1];b=[-1,2];print(np.dot(a,b))"

# You should get the answer `0`
```
#### And, to exit simply type
```sh
exit
```
### Nix Home Manager Setup
#### Create initial Home Manager configuration
```sh
nix-shell -p home-manager

home-manager init
```
#### Two new files have been created in `~/.config/home-manager/`
|filename|description|
|----|:---|
|flake.nix|Nix project file|
|home.nix|Home Manager configuration file|
#### Try altering `~/.config/home-manager/home.nix`
- uncomment `pkgs.hello`, then save the file
#### Update configuration by either (default short form)
```sh
home-manager switch
```
#### Long form (if you have different profiles)
- change `username` to your own user name
```sh
home-manager switch --flake ~/.config/home-manager/#username
```
#### And run the new `pkgs.hello`
```sh
hello
```
#### Feel free to add new packages,
#### or even modularize `home.nix`

## Example modular outlook
- in `~/.config/home-manager`
```
.
├── flake.lock
├── flake.nix
├── home.nix
└── modules
    ├── datasci.nix
    ├── git.nix
    ├── jvm-languages.nix
    ├── language-servers.nix
    ├── nvf.nix
    └── zsh.nix
```
#### `flake.nix`
- change all instances of `nixuser` to your own username
```nix
{
  description = "Home Manager configuration of nixuser";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # NVF nix neovim configuration input
    nvf.url = "github:notashelf/nvf";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nvf,
      ...
    }:
    let
      # from reddit.com/r/NixOS/comments/17p39u6 to allow unfree packages
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config = { allowUnfree = true; };
      };
    in
    {
      homeConfigurations."nixuser" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          nvf.homeManagerModules.default
          ./home.nix
        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
```
#### `home.nix`
- just as in `flake.nix`,
- change all instances of `nixuser` to your own username
```nix
{ pkgs, ... }:

{
  home.username = "nixuser";
  home.homeDirectory = "/home/nixuser";

  targets.genericLinux.enable = true;

  home.stateVersion = "24.11"; # Please read the comment before changing.

  # import modules
  imports = [
    ./modules/zsh.nix
    ./modules/git.nix
    ./modules/datasci.nix
    ./modules/language-servers.nix
    ./modules/jvm-languages.nix
    ./modules/nvf.nix
  ];

  # The home.packages option allows installation of Nix packages.
  home.packages = with pkgs; [
    helix
    bat
    eza
    fastfetch
    cpufetch
    wl-clipboard
    yt-dlp
    ripgrep
    apostrophe

    nerd-fonts.fira-code
    nerd-fonts.roboto-mono

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/nixuser/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "hx";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
```
### Modules in the `~/.config/home-manager/modules/` directory
#### `datasci.nix`
```nix
# Data Science Languages Module
# Python development flake environment already in ~/python-nix
# Activate it with:
# cd ~/python-nix
# nix develop
#
{ pkgs, ... }:
{
  home.packages =
    with pkgs;
    let
      # RStudio packages
      RStudio = rstudioWrapper.override {
        packages = with rPackages; [
          tidyverse
          languageserver
          pracma
          remotes
          rgl
          plotly
          plot3D
          Rmpfr
          MASS
        ];
      };
    in
    [
      RStudio
      julia-bin
      octaveFull
      sequeler
    ];
}
```
#### `git.nix`
- change `userName` and `userEmail` accordingly
```nix
# Git configuration
{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "nixuser";
    userEmail = "nix.user@example.com";
    extraConfig = {
      core = {
        editor = "hx";
        autoclrf = "input";
      };
    };
  };
}
```
#### `jvm-languages.nix`
- Create directory `~/.lein` before using Leiningen
```nix
# JVM Languages installation - for Java, Clojure and Scala
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    jdk
    # create folder '~/.lein' before using Leiningen
    (leiningen.override { jdk = pkgs.jdk11; })
    (clojure.override { jdk = pkgs.jdk11; })
    (scala_3.override { jre = pkgs.jdk; })
    (sbt.override { jre = pkgs.jdk; })
  ];
}
```
#### `language-servers.nix`
```nix
# Language Servers, Linters & Formatters
{ pkgs, ... }:

{
  home.packages =
    with pkgs;
    ([
      # Nix Language Server
      nixd
      nil # default for helix
      nixfmt-rfc-style

      # For JVM languages
      clojure-lsp
      clj-kondo
      cljfmt
      jdt-language-server
      (metals.override { jre = pkgs.jdk; })

      # Markdown
      marksman
      ltex-ls
      prettierd

      # For TOML
      taplo

      # bash formatter and linter used by bash-language-server
      shfmt
      shellcheck

      # for Lua
      lua-language-server
      stylua
    ])

    # nodejs packages
    ++ (with pkgs.nodePackages; [
      bash-language-server
    ]);
}
```
#### `nvf.nix` - Neovim Nix Framework (WIP)
```nix
{ pkgs, lib, ... }:
{
  programs.nvf = {
    enable = true;

    # settings
    settings.vim = {
      theme = {
        enable = true;
        name = "gruvbox";
        style = "light";
      };

      options.cursorlineopt = "line";

      # statusline.lualine = {
      #   enable = true;
      #   theme = "papercolor_light";
      # };

      mini.statusline.enable = true;

      visuals = {
        indent-blankline = {
          enable = true;
          setupOpts = {
            indent.char = "┊"; # unicode 0x250A
          };
        };
        rainbow-delimiters = {
          enable = true;
        };
      };

      ui.noice = {
        enable = true;
        setupOpts.lsp.signature.enabled = true;
      };

      telescope.enable = true;
      autocomplete.blink-cmp = {
        enable = true;
        friendly-snippets.enable = true;
      };

      autopairs.nvim-autopairs.enable = true;

      binds.whichKey = {
        enable = true;
        setupOpts.preset = "helix";
      };

      languages = {
        enableTreesitter = true;
        enableExtraDiagnostics = true;

        nix = {
          enable = true;
          lsp.enable = true;
          format.enable = true;
          format.type = "nixfmt";
          lsp.server = "nixd";
        };

        bash = {
          enable = true;
          lsp.enable = true;
          format.enable = true;
        };

        python = {
          enable = true;
          lsp.enable = true;
          format.enable = true;
          format.type = "black-and-isort";
        };

        julia = {
          enable = true;
          lsp.enable = true;
          lsp.package = null; # use julia already installed on system
        };
      };
    };
  };
}
```
#### `zsh.nix`
```nix
# Zsh shell configuration for Home Manager
{ ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    initContent = ''
      PS1="%B%F{red}[%F{yellow}%n%F{green}@%F{blue}%m%F{magenta} %~%F{red}]%F{white} %b"
    '';
    shellAliases = {
      ls = "eza";
      ll = "eza -la --icons";
      lt = "eza --tree --icons";
      cat = "bat";
      homeconfig = "hx ~/.config/home-manager/";
      switch = "home-manager switch";
    };
  };
}
```
