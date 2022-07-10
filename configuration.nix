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
    systemd-boot.configurationLimit = 20;
  };

# Use GRUB for dual-boot: (uncomment if needed)
#  boot.loader.grub = {
#    enable = true;
#    devices = [ "nodev" ];
#    efiInstallAsRemovable = true;
#    efiSupport = true;
#    useOSProber = true;
#  };
  
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
    useXkbConfig = "true"; # use xorg settings for keyboard layout below
  };

# Xorg options
  services.xserver = {
    enable = true;
    
    # set display manager and desktop environment
    displayManager.lightdm.enable = true;
    displayManager.defaultSession = "xfce";
    desktopManager.xfce.enable = true;
    desktopManager.xterm.enable = false;

    # set keyboard layout
    layout = "gb";
    libinput.enable = true; # enable touchpad support
    
    # Thunar plugins
    desktopManager.xfce.thunarPlugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];
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
    mediaKeys.enable = true;
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

# AMD GPU setup
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.opengl = {
    driSupport = true;
    driSupport32Bit = true; # for 32 bit applications
    extraPackages = with pkgs; [
      rocm-opencl-icd
      rocm-opencl-runtime
    ];
  };

# Picom compositor
  services.picom = {
    enable = true;
    fade = true;
    inactiveOpacity = 0.9;
    shadow = true;
    fadeDelta = 4;
  };

# Zsh setup - set prompt, enable autocompletion paths
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
    shell = pkgs.zsh; # set zsh as default shell for this user
  };

# Add home-manager.users block after user definition
  home-manager.users.${defaultUser} = { pkgs, ... }: {
  home.packages = with pkgs; [
    bat
    exa
    qogir-icon-theme
    arc-theme
    neofetch
    kitty
  ];
  
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    shellAliases = {
      ls  = "exa";
      ll  = "exa -la --icons";
      cat = "bat";
      update  = "sudo nix-channel update";
      upgrade = "sudo nixos-rebuild switch";
    };
    sessionVariables = {
      EDITOR = "nano";
      TERM = "kitty";
    };
  };
  programs.kitty = {
    enable = true;
    settings = {
      font_size = "16.0";
      font_family      = "FiraCode Nerd Font";
      bold_font        = "auto";
      italic_font      = "auto";
      bold_italic_font = "auto";
      scrollback_lines = 10000;
      enable_audio_bell = false;
      remember_window_size = true;
      initial_window_width = "80c";
      initial_window_height = "25c";
    };
  };
};
home-manager.useGlobalPkgs = true;

# Allow unfree packages
  nixpkgs.config.allowUnfree = true;

# Default packages to install in 
  environment.systemPackages = with pkgs; [
    wget
    curl
    brave
    onlyoffice-bin
    git
    subversion
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
