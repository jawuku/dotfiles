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
    description = desc;
    initialPassword = "123"; # *must* change after 1st reboot
    shell = pkgs.zsh; # set zsh as default shell
  };

# Add home-manager.users block after user definition
  home-manager.users.jason = { pkgs, ... }: {
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

# Allow unfree packages
  nixpkgs.config.allowUnfree = true;

# Default packages to install in 
  environment.systemPackages = with pkgs; [
    wget
    curl
    brave
    onlyoffice-bin # for x86_64 only
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
