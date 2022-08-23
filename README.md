## dotfiles
### 1) Configuration files for NixOS
### Currently on a VM (e.g. Parallels on macOS, or VirtualBox)

#### Choose to install a plain NixOS system (without desktop environment)
#### add following packages to /etc/nixos/configuration.nix when installing
```
environment.systemPackages = with pkgs; [
    wget git subversion curl
    # and other packages already specified ...
];
```
#### Reboot

#### Make copy of configuration.nix
#### (in case something goes wrong)
```sh
cd /etc/
sudo mv nixos/configuration.nix nixos/config-original.nix
```
#### Then download configuration from GitHub:
```sh
sudo svn co https://github.com/jawuku/dotfiles/trunk/nixos
sudo nixos-rebuild switch
sudo reboot
```
#### If everything goes well, welcome to NixOS with XFCE desktop
#### with
* configured neovim
* python
* clojure
* R
* julia
* octave
### 2) Setup various operating systems
* Debian 11 with Openbox
* macOS M1 Development Setup
* Debian 10 (Old Setup)
* OpenSuse Post-install (Old)
* Debian 11 install script (Experimental - may not work)
### 3) Miscellaneous files
* Old vim configurations
* Collected wallpapers
* other bits and bobs
