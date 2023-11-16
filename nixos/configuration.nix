# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

# This configuration.nix file is generic - can modify either:
# 1) uncomment multi-line Nvidia comment block for Nvidia GPUs (lines 77-103)
# 2) xkbVariant = "mac"; # for Macbook (line 74)

{
  config,
  pkgs,
  ...
}: let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz";
in {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # Incorporate Home Manager
    (import "${home-manager}/nixos")
  ];

  # Use systemd bootloader
  boot.loader = {
    systemd-boot.enable = true;
    systemd-boot.configurationLimit = 10;

    efi.canTouchEfiVariables = true;
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    # Enable the KDE Plasma Desktop Environment.
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;

    # Disable xterm
    desktopManager.xterm.enable = false;
    excludePackages = with pkgs; [ xterm ];

    # Configure keymap in X11
    layout = "gb";
    xkbVariant = ""; # use "mac" on Macbook
  };

/* Uncomment this block to load on an Nvidia GPU computer

  # Make sure opengl is enabled
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Nvidia settings
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    # Modesetting is needed for most Wayland compositors
    modesetting.enable = true;

    # Use the open source version of the kernel module
    # Only available on driver 515.43.04+
    open = false;

    # Enable the nvidia settings menu
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
*/

  # Configure console keymap
  console.keyMap = "uk";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.example = {
    isNormalUser = true;
    description = "Example User";
    extraGroups = ["networkmanager" "wheel"];
    initialPassword = "123"; # remember to change after 1st login!
    shell = pkgs.zsh;
    packages =  [
      #  firefox thunderbird
    ];
  };

  # Add home-manager block after user definition
  home-manager.users.example = {
    imports = [./home.nix];
  };

  # GUI Fonts
  fonts.fonts = with pkgs; [
    (nerdfonts.override {fonts = ["RobotoMono" "Source Code Pro"];})
    noto-fonts
    noto-fonts-extra
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-emoji
    noto-fonts-emoji-blob-bin
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = (with pkgs; [
    # Do not forget to add an editor to edit configuration.nix!
    # However, the Nano editor is installed by default.
    wget
    git
    curl
    subversion
    nix-prefetch-github
    smplayer
    distrobox
    # experimental minimal vim configuration
    ((vim_configurable.override {  }).customize{
      name = "vim";
      # Install plugins for example for colourschemes
      vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
        start = [ tender-vim vim-polyglot vim-airline vim-airline-themes ];
        opt = [];
      };
      # simple .vimrc
      vimrcConfig.customRC = ''
        set nocompatible
        syntax on
        filetype plugin indent on
        set nu rnu hid et sts=4 sw=4 enc=utf-8 wmnu
        set clipboard=unnamedplus nobackup ru ls=2
        set ignorecase smartcase confirm termguicolors

        " different mode cursor shapes
        let &t_SI = "\<Esc>[5 q" "SI = insert - blinking vertical bar
        let &t_SR = "\<Esc>[4 q" "SR = replace - solid underscore
        let &t_EI = "\<Esc>[2 q" "EI = normal - solid block

        " vim-airline settings
        let g:airline#extensions#tabline#enabled = 1
        let g:airline_theme = 'tender'
        let g:airline_powerline_fonts = 1

        " set colourscheme
        colorscheme tender
      '';
    }
  )
  ])
  # and KDE packages
  ++ (with pkgs.libsForQt5; [
    falkon
    kate
    elisa
  ]);

  # Enable Zsh
  programs.zsh = {
    enable = true;
    promptInit = ''
      PS1="%B%F{red}[%F{yellow}%n%F{green}@%F{blue}%m%F{magenta} %~%F{red}]%F{white} %b"
    '';
  };

  # enable Zsh Completion
  environment.pathsToLink = [ "/share/zsh" ];

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # automatic upgrade
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

  # Enable experimental features like flakes - maybe utilise in future?
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable Podman & Docker
  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
