# NixOS 22.05 Setup from Minimal ISO
## from https://nixos.org/manual/nixos/stable/index.html#ch-installation

## Get into root mode
```sh
sudo -i
```
## Get more legible font
```sh
setfont ter-v24b
```
## Setup wireless
```sh
sudo systemctl start wpa_supplicant
wpa_cli
```
## Type in to setup wifi
```
add_network

set_network 0 ssid "myhomenetwork"

set_network 0 psk "mypassword"

set_network 0 key_mgmt WPA-PSK

enable_network 0

quit
```
## Partition Disk

### Check if BIOS is UEFI or Legacy
```sh
ls /sys/firmware/efi # if exists, system is UEFI
```
### partition using cfdisk
e.g using Parallels 64GB disk: 
```cfdisk```
| Device    | Size  | Type                  |
|-----------|-------|-----------------------|
| /dev/sda1 | 512M  | EFI System (EF)       |
| /dev/sda2 | 61.5G | Linux Filesystem (83) |
| /dev/sda3 | 2G    | Linux Swap (82)       |

### Format Disk - add labels
```sh
mkfs.fat -F 32 -n boot /dev/sda1

mkfs.ext4 -L nixos /dev/sda2

mkswap -L swap /dev/sda3
```
### mount partitions
```sh
mount /dev/disk/by-label/nixos /mnt

mkdir -p /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot

swapon /dev/sda3
```

### Generate configuration files
```nixos-generate-config --root /mnt```

### Edit /mnt/etc/nixos/configuration.nix
```nix
# configuration.nix for my AMD APU System with Wifi

# Load configuration and packages

# Include the results of the hardware scan
{ config, pkgs, ... }:

# set variable e.g. default username
let
  defaultUser = "jason";
  desc = "Jason Awuku";
in

{
  imports = [
    ./hardware-configuration.nix
  ];

# System-D Boot Loader - good for single-boot systems
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    efi.efiSysMountPoint = "/boot";
    timeout = 7; # timeout in seconds
    # limit max number of config generations
    systemd-boot.configurationLimit = 10;
  };

# Use GRUB for dual-boot: (uncomment if needed, comment out system-d boot loader code above)
#  boot.loader.grub = {
#    enable = true;
#    devices = [ "nodev" ];
#    efiInstallAsRemovable = true;
#    efiSupport = true;
#    useOSProber = true;
#  };

# Extra modules e.g. AMD or Nvidia Graphics Drivers
  boot.initrd.kernelModules = [ "amdgpu" ];
# or
# boot.initrd.kernelModules = [ "nvidia" ];
  
# Networking with Network Manager, enable firewall
  networking = {
    hostName = "nixos";
    networkManager.enable = true;
    firewall.enable = true;
  };

# Set time zone for UK
  time.timeZone = "Europe/London";

# Set internationalisation properties for UK
  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    font = "ter-v24b"; # Terminus Bold 24
    keyMap = "uk"; # xorg code is different - see below
    # useXkbConfig = "true";
  };

# Xorg options - load XFCE desktop environment
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    displayManager.defaultSession = "xfce";
    desktopManager.xfce.enable = true;
    desktopManager.xterm.enable = false;
    # windowManager.jwm.enable = true;
    layout = "gb"; # note different than console code
    libinput.enable = true; # enable touchpad support
  };

# GUI Fonts
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "RobotoMono" ]; })
    noto-fonts
    noto-fonts-extra
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-emoji
    noto-fonts-emoji-blob-bin
  ];

# Enable CUPS to print documents
  services.printing.enable = true;

# Enable sound
  sound = {
    enable = true;
    mediakeys.enable = true;
  };

  hardware.pulseaudio = {
    enable = true;
    extraModules = [ pkgs.pulseaudio-modules-bt ];
    package = pkgs.pulseaudioFull;
  };

  nixpkgs.config.pulseaudio = true;

# Bluetooth support
  
  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };
  
  services.blueman.enable = true;

# Enable zsh autocompletion paths
  programs.zsh.enable = true;  
  environment.pathsToLink = [ "/share/zsh" ];

# Define a user - change password after 1st reboot
  users.users.${defaultUser} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "networkmanager" "lp" "scanner" ];
    description = ${desc};
    initialPassword = "123"; # *must* change after 1st reboot
    shell = pkgs.zsh; # set zsh as default shell
  };

# Allow unfree packages
  nixpkgs.config.allowUnfree = true;

# Default packages to install in 
  environment.systemPackages = with pkgs; [
    wget
    curl
    brave # for x86_64 only
    onlyoffice-bin # for x86_64 only
    git
    subversion
    neofetch
    htop
    pragha
    mate.atril
  ];

# Check for updates daily
  system.autoUpgrade = {
    enable = true;    
  };

# Automatic garbage collection
  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

# Save backup of configuration - useful if original accidentally deleted
  system.copySystemConfiguration = true;

# System Version - do not change
  system.stateVersion = "22.05";
}
```
## Test new system - change password once logged in
```sh
sudo nixos-rebuild switch
sudo reboot
```
## New Password - login as user and open a terminal
```sh
passwd # enter new password twice
```

## Install Home-Manager
```sh
nix-channel --add https://github.com/nix-community/home-manager/archive/release-22.05.tar.gz home-manager
 nix-channel --update
```

### Add a NixOS module to /mnt/etc/nixos/configuration.nix
#### Change imports block:
```nix
  imports = [
    ./hardware-configuration.nix
    <home-manager/nixos>
  ];
```
#### Add home-manager.users block after user definition
```nix
  home-manager.users.${defaultUser} = { pkgs, ... }: {
  home.packages = with pkgs; [
    bat
    exa
    whitesur-gtk-theme
    qogir-icon-theme
    arc-theme
    neofetch
    kitty
  ];
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    dirHashes = {
      docs  = "$HOME/Documents";
      dl    = "$HOME/Downloads";
      pics  = "$HOME/Pictures";
      vids  = "$HOME/Videos";
      music = "$HOME/Music";
    };
    shellAliases = {
      ll  = "exa -la --icons";
      ls  = "exa";
      cat = "bat";
      update = "sudo nixos-rebuild switch";
    };
    sessionVariables = {
      PS1 = "%B%F{red}[%F{yellow}%n%F{green}@%F{blue}%m%F{magenta} %~%F{red}]%F{white} %b";
      EDITOR = "nano";
      TERM = "kitty";
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
      font_features = "FiraCode-Retina +ss02 +ss08 +cv16 +ss05";
      scrollback_lines = 10000;
      enable_audio_bell = false;
      remember_window_size = true;
      initial_window_width = "80c";
      initial_window_height = "25c";
    };
  };
};
home-manager.useGlobalPkgs = true;
```
## Test new system - change password once logged in
```sh
sudo nixos-rebuild switch
sudo reboot
```
