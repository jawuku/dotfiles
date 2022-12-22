# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

# set variables e.g. default username
let
  defaultUser = "bookiboo";
  desc = "Booki Boo";
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";

in

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      (import "${home-manager}/nixos")
    ];

  # Use the GRUB boot loader.
  boot.loader.grub = {
    enable = true;
    devices = [ "nodev" ];
    efiInstallAsRemovable = true;
    efiSupport = true;
    useOSProber = true;
  };

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

  # Enable the X11, Gnome DE and configure keymap. Exclude xterm
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    desktopManager.xterm.enable = false;
    excludePackages = with pkgs; [ xterm ];
    layout = "gb";
    xkbVariant = ""; # use "mac" for macbook
    libinput.enable = true;
  };

  # Nvidia drivers
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;

  # GUI Fonts
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    fira-code
    noto-fonts
    noto-fonts-extra
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-emoji
    noto-fonts-emoji-blob-bin
  ];

  # Enable WiFi printer
  services = {
    printing.enable = true;
    avahi.enable = true;
    avahi.openFirewall = true;
  };

  # Scanner support
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.sane-airscan ];
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${defaultUser} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "lp" "scanner" ];
    description = desc;
    initialPassword = "123"; # *must* change after 1st reboot
  #   packages = with pkgs; [
  #     firefox
  #     thunderbird
  #   ];
  };
  
  # Add home-manager block after user definition
  home-manager.users.${defaultUser} = {
    imports = [ ./home.nix ];
  };
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # exclude some default pre-installed Gnome packages
  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos gnome-tour ])
  ++ (with pkgs.gnome; [
    cheese totem geary gnome-weather gnome-music epiphany tali iagno hitori atomix
  ]);

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = (with pkgs; [
  # vim # Do not forget to add an editor to edit configuration.nix!
  # But, the Nano editor is already installed by default.
  wget curl git subversion neofetch firefox-esr distrobox ])
  ++ (with pkgs.gnome; [ gnome-boxes ]);
  
  # enable Bash Completion
  environment.pathsToLink = [ "/share/bash-completion" ];

  programs.bash = {
    enableCompletion = true;
    promptInit = ''
    # Custom bash prompt via kirsle.net/wizards/ps1.html
    PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\w\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"
    '';
  };
  
  # Steam support
  programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  # Podman / Docker support
  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.dnsname.enable = true;
    };
  };

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
  # networking.firewall.enable = false;

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
      options = "--delete-older-than 14d";
    };
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}
