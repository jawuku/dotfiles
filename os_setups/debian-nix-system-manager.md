# Install Nix on Debian or Ubuntu
### 1. Install Native `.deb` Package
```sh
sudo apt update
sudo apt install nix-setup-systemd
```
### 2. Configure User Permissions
```sh
sudo usermod -aG nix-users $(whoami)
```
Note: you must log out of your Linux session and log back in
to apply these group membership changes.
### 3. Update Shell Environment
This ensures the system knows where to look for programs downloaded via nix.
Add the following code snippet to `~/.bashrc`, `~/.zshrc` or `~/.profile` as suitable:
```sh
# Append Nix user binaries to PATH
if [ -d "$HOME/.nix-profile/bin" ] ; then
    PATH="$HOME/.nix-profile/bin:$PATH"
fi

# Append Nix application shortcuts to desktop environments
if [ -d "$HOME/.nix-profile/share" ] ; then
    XDG_DATA_DIRS="$HOME/.nix-profile/share:$XDG_DATA_DIRS"
fi
```
### 4. Verify the Installation
```sh
nix --version
```

## Nix Flakes
### 5. Enable Flakes Globally
```sh
sudo mkdir -p /etc/nix
echo "experimental-features = nix-command flakes" | sudo tee -a /etc/nix/nix.conf
```
### 6. Restart the Nix Daemon
The `nix-setup-systemd` relies on systemd to orchestrate the build daemon.
The service must be restarted to apply the configuration change.
```sh
sudo systemctl restart nix-daemon.service
```
### 7. Verify it works
```sh
nix flake --help
```
#### Also you can run an application to test it
```sh
nix run nixpkgs#cowsay -- "Yes, flakes are working!"
```

## Install System Manager
### 8. from [Numtide](https://github.com/numtide/system-manager)

```sh
nix run 'github:numtide/system-manager' -- init
``` 
- Say `y` to each question if you are asked.
#### Files Created in `~/.config/system-manager/` folder:
- `flake.nix` - this is the entry point that loads `system.nix`
- `system.nix` - declares what your system should be like
### 9. Replace `flake.nix` and `system.nix` with these:
#### a. `flake.nix`
```nix
{
  description = "Standalone System Manager configuration";

  nixConfig = {
    extra-substituters = [ "https://cache.numtide.com" ];
    extra-trusted-public-keys = [
      "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
    ];
  };

  inputs = {
    # Specify the source of System Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    system-manager = {
      url = "github:numtide/system-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Allow GUI Apps to run in non-NixOS systems
    nix-system-graphics = {
      url = "github:soupglasses/nix-system-graphics";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      system-manager,
      nix-system-graphics,
      ...
    }:
    let
      system = "x86_64-linux";
    in
    {
      systemConfigs.default = system-manager.lib.makeSystemConfig {
        # pass values to modules
        # Specify your system configuration modules here, for example,
        # the path to your system.nix.
        modules = [ 
          # Nix System graphics
          nix-system-graphics.systemModules.default
          ({
            config = {
              nixpkgs.hostPlatform = system;
              system-manager.allowAnyDistro = true;
              system-graphics.enable = true;
            };
          })
          # Main system setup
          ./system.nix
          ./ai.nix
        ];

        # Optionally specify extraSpecialArgs and overlays
      };
    };
}
```
#### b. `system.nix`
```nix
{ lib, pkgs, ... }:
let
  jvm = pkgs.graalvmPackages.graalvm-ce;
in
{
  config = {
    nixpkgs.hostPlatform = "x86_64-linux";

    # Enable and configure services
    services = {
      # nginx.enable = true;
    };

    environment = {
      # Packages that should be installed on a system
      systemPackages = with pkgs;
        [
          helix
          btop
          bat
          eza
          microfetch
          cpufetch
          xclip # (or wl-clipboard if on wayland)
          nodejs_26

          # JVM languages
          (leiningen.override { jdk = jvm; })
          (clojure.override { jdk = jvm; })

          # language servers
          clojure-lsp
          clj-kondo
          lua-language-server
          stylua
          bash-language-server
          shellcheck
          shfmt
          marksman
          ltex-ls-plus
          prettierd
          nixd
          nixfmt
          sqruff
          taplo
          simple-completion-language-server
          basedpyright
          ruff
          typescript-language-server
        ]

        ++ [ jvm ]; # Java itself, as defined above

      # Add directories and files to `/etc` and set their permissions
      etc = {
        # with_ownership = {
        #   text = ''
        #     This is just a test!
        #   '';
        #   mode = "0755";
        #   uid = 5;
        #   gid = 6;
        # };
        #
        # with_ownership2 = {
        #   text = ''
        #     This is just a test!
        #   '';
        #   mode = "0755";
        #   user = "nobody";
        #   group = "users";
        # };
      };
    };

    # Enable and configure systemd services
    systemd.services = { };

    # Configure systemd tmpfile settings
    systemd.tmpfiles = {
      # rules = [
      #   "D /var/tmp/system-manager 0755 root root -"
      # ];
      #
      # settings.sample = {
      #   "/var/tmp/sample".d = {
      #     mode = "0755";
      #   };
      # };
    };
  };
}
```
#### c. `ai.nix`
```nix
{ config, pkgs, ... }:

{
  # Load LMStudio
  environment.systemPackages = with pkgs; [
    lmstudio
  ];
  # Enable Ollama and declare models
  services.ollama = {
    enable = true;
    loadModels = [
      "gemma4:e4b"
      "deepseek-r1:14b"
      "qwen3:14b"
      # "glm-5.2:cloud"
    ];
    environmentVariables = {
      HSA_OVERRIDE_GFX_VERSION = "11.0.0";
      OLLAMA_NUM_PARALLEL = "1";
    };
  };

  systemd.services.ollama.serviceConfig = {
    SupplementaryGroups = [ "render" "video" ];
  };
}
```
### 10. Reload Configuration
#### Go to configuration directory
```sh
cd ~/.config/system-manager
```
#### Activate New Configuration
```sh
nix run 'github:numtide/system-manager' -- switch --flake . --sudo
```
#### Log out and log back in
### 11. If PATH not activated
type this 
```sh
source /etc/profile.d/system-manager-path.sh
```
If the PATH does not persist, add it manually to `~/.bashrc`
```sh
echo "source /etc/profile.d/system-manager-path.sh" | tee -a ~/.bashrc
```
