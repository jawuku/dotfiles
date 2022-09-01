# configuration.nix for Parallels VM on M1 Macbook Air

# Alter any configuration options as needed

# Load configuration and packages

# Include the results of the hardware scan
{ config, pkgs, ... }:

# set variable e.g. default username, home-manager download location
let
  defaultUser = "jason";
  desc = "Jason Awuku";

  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-22.05.tar.gz";

in

{
  imports = [
    ./hardware-configuration.nix
    (import "${home-manager}/nixos")
  ];

# System-D Boot Loader - use for single-boot installations
  boot.loader = {
    grub.enable = false;
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    efi.efiSysMountPoint = "/boot";
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

# Extra modules e.g. AMD or Nvidia Graphics Drivers
# boot.initrd.kernelModules = [ "amdgpu" ];
# or
# boot.initrd.kernelModules = [ "nvidia" ];
  
# Networking with Network Manager, enable firewall, set hostname
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
    useXkbConfig = true; # use xorg keymap settings below
  };

# Location data
  location = {
    provider = "manual"; # set to "geoclue2" for automatic setting

  # Liverpool, UK as an example of manual setting
    latitude  = 53.430759;
    longitude = -2.961425;
  };

# Xorg options - load XFCE desktop environment, set keyboard layout
  services.xserver = {
    enable = true;
    
    # Display Manager Options
    displayManager.lightdm.enable = true;
    displayManager.defaultSession = "xfce";
    desktopManager.xfce.enable = true;
    desktopManager.xterm.enable = false;
    # windowManager.openbox.enable = true; # maybe explore more in future
    
    # Keyboard Layout Options
    layout = "gb"; # UK keyboard
    xkbVariant = "mac"; # to set Mac keyboard
    # libinput.enable = true; # enable touchpad support in basic window managers
    # desktop environments enable it by default
  };

# GUI Fonts
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
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
    # enabled by default in desktop environments
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

# initial zsh setup
  programs.zsh = {
    enable = true;
    promptInit = "PS1='%B%F{red}[%F{yellow}%n%F{green}@%F{blue}%m%F{magenta} %~%F{red}]%F{white} %b'";
  };
  
# Enable zsh autocompletion paths  
  environment.pathsToLink = [ "/share/zsh" ];

# Add zsh to user shells
  environment.shells = with pkgs; [ zsh ];
  
# Picom compositor
  services.picom = {
    enable = true;
    fade   = true;
    inactiveOpacity = 0.9;
    shadow = true;
    fadeDelta = 4;
  };

# Redshift colour temperature according to location (sunrise/sunset)
services.redshift = {
  enable = true;
  brightness = {
    # Note the string values below.
    day   = "1";
    night = "1";
  };
  temperature = {
    day   = 6000;
    night = 3500;
  };
};

# Define a user - change password after 1st reboot
users.users.${defaultUser} = {
  isNormalUser = true;
  extraGroups = [ "wheel" "video" "audio" "networkmanager" "lp" "scanner" ];
  description = desc;
  initialPassword = "123"; # *must* change after 1st reboot
  shell = pkgs.zsh; # set zsh as default shell
};

# Add home-manager block after user definition
home-manager = {
  users.${defaultUser} = { imports = [ /etc/nixos/home.nix ]; };
  useGlobalPkgs   = true;
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
    unzip
    p7zip
    unrar
    subversion
    htop
    zathura
    libreoffice
    tela-icon-theme
    xfce.thunar-archive-plugin
    xfce.thunar-volman
    xfce.thunar-media-tags-plugin
    arc-theme
    neovim
    xclip
    tree-sitter
    
    gcc
    clang-tools
        
    nodejs
    nodePackages.pyright
    nodePackages.bash-language-server
    nodePackages.vim-language-server
    nodePackages.neovim
    
    # julia_17-bin # only for x86_64
    
    clojure
    clojure-lsp
    leiningen
    clj-kondo
    joker
    
    octaveFull
    
    fzf
    fd
    ripgrep
    sumneko-lua-language-server
    
    # allow R knitr function to output markdown to PDF
    pandoc
    texlive.combined.scheme-full
  ];

# Check for updates daily
system.autoUpgrade.enable = true;    

# Automatic garbage collection
nix = {
  settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
};

# Save backup of configuration - useful if original accidentally deleted
system.copySystemConfiguration = true;

# System Version - do not change
system.stateVersion = "22.05";
}
