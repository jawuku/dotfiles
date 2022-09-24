# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

# set variables
let
  defaultUser = "jason";
  desc = "Jason Awuku";
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-22.05.tar.gz";
  xfce-packages = with pkgs.xfce; [
  	thunar-volman thunar-media-tags-plugin thunar-archive-plugin
  	xfce4-screenshooter parole ristretto catfish xfwm4-themes xfce4-notifyd
  	xfce4-appfinder xfce4-weather-plugin
  ];
in

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      (import "${home-manager}/nixos")
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    efi.efiSysMountPoint = "/boot";
    timeout = 7;
    systemd-boot.configurationLimit = 10;
  };

  # AMD kernel modules
  boot.initrd.kernelModules = [ "amdgpu" ];
  
  networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    font = "ter-v24b";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    displayManager.defaultSession = "xfce";
    desktopManager.xfce.enable = true;
    desktopManager.xterm.enable = false;
    layout = "gb";
    libinput.enable = true;
    videoDrivers = [ "amdgpu" ];
  };

  # Enable OpenCL & Vulkan drivers
  hardware.opengl = {
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [ rocm-opencl-icd rocm-opencl-runtime ];
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
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound = {
    enable = true;
    mediaKeys.enable = true;
  };

  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    # extraModules = [ pkgs.pulseaudio-modules-bt ]; not needed anymore
    package = pkgs.pulseaudioFull;
  };

  nixpkgs.config.pulseaudio = true;

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
    extraGroups = [ "wheel" "video" "audio" "networkmanager" "lp" "scanner" "libvirtd" ];
    description = desc;
    initialPassword = "123";
    shell = pkgs.bash; # distrobox needs bash as default shell
  #   packages = with pkgs; [ firefox thunderbird ];
  };
  
  # Add home-manager block after user definition
  home-manager = {
    users.${defaultUser} = { imports = [ ./home.nix ]; };
    useGlobalPkgs   = true;
    useUserPackages = true;
  };
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    micro # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget curl zathura git subversion glances firefox-esr lollypop ntfs3g
    xorg.xhost distrobox geany gnome.gucharmap asunder libreoffice
    qogir-icon-theme tela-icon-theme virt-manager
  ]

  # XFCE packages
  ++ xfce-packages;

  # Podman Installation
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  # Virt-manager
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

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
    
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}

