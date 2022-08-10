# configuration.nix for Parallels VM on M1 Macbook Air

# Load configuration and packages

# Include the results of the hardware scan
{ config, pkgs, ... }:

# set variable e.g. default username
let
  defaultUser = "bookiboo";
  desc = "Booki Boo";
in

{
  imports = [
    ./hardware-configuration.nix
    <home-manager/nixos>
  ];

# System-D Boot Loader - use for single-boot installations
  boot.loader = {
    grub.enable = false;
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    efi.efiSysMountPoint = "/boot/efi";
    timeout = 7; # timeout in seconds
    # limit max number of config generations
    systemd-boot.configurationLimit = 10;
  };

# Use GRUB for dual-boot: (uncomment if needed)
#  boot.loader.grub = {
#    enable = true;
#    devices = [ "nodev" ];
#    efiInstallAsRemovable = true;
#    efiSupport = true;
#    useOSProber = true;
#  };

# Extra modules e.g. AMD or Nvidia Graphics Drivers
# boot.initrd.kernelModules = [ "amdgpu" ];
# or
# boot.initrd.kernelModules = [ "nvidia" ];
  
# Networking with Network Manager, enable firewall
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    firewall.enable = true;
  };

# Set time zone for UK
  time.timeZone = "Europe/London";

# Set internationalisation properties for UK
  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    font = "ter-v24b"; # Terminus Bold 24
    useXkbConfig = "true"; # use xorg keymap settings below
  };

# Xorg options - load XFCE desktop environment, set keyboard layout
  services.xserver = {
    enable = true;
    
    # Display Manager Options
    displayManager.lightdm.enable = true;
    displayManager.defaultSession = "xfce";
    desktopManager.xfce.enable = true;
    desktopManager.xterm.enable = false;
    # windowManager.jwm.enable = true;
    
    # Keyboard Layout Options
    layout = "gb";
    xkbVariant = "mac"; # to set Mac keyboard
    # libinput.enable = true; # enable touchpad support
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
    # mediaKeys.enable = true; # only used in separate window managers
  };

  hardware.pulseaudio = {
    enable = true;
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
  programs.zsh = {
    enable = true;
    promptInit = "PS1='%B%F{red}[%F{yellow}%n%F{green}@%F{blue}%m%F{magenta} %~%F{red}]%F{white} %b'";
  };
  
environment.pathsToLink = [ "/share/zsh" ];

# Define a user - change password after 1st reboot
users.users.${defaultUser} = {
  isNormalUser = true;
  extraGroups = [ "wheel" "video" "audio" "networkmanager" "lp" "scanner" ];
  description = desc;
  initialPassword = "123"; # *must* change after 1st reboot
  shell = pkgs.zsh; # set zsh as default shell
};

# Add home-manager.users block after user definition
home-manager.users.${defaultuser} = { imports = [ /etc/nixos/home.nix ]; };
  
home-manager = {
  useGlobalPkgs = true;
  useUserPackages = true;
};

# Allow unfree packages
nixpkgs.config.allowUnfree = true;

# Default packages to install in 
environment.systemPackages = with pkgs; [
    wget
    curl
    firefox-esr
    git
    subversion
    htop
    pragha
    mate.atril
    abiword
    qogir-icon-theme
    arc-theme
    gnumeric
  ];

# Check for updates daily
system.autoUpgrade.enable = true;    

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
