## Debian install automated script
### Installs basic Openbox system, minus languages and tools
### May install them with the Nix package manager in future

### Designed for Virtual Machines e.g. Virtualbox on x86_64
### Install fresh Debian 11 Netinstall
### with basic system utils only (no desktop environment)
### Login as normal user, use sudo password as requested
```sh
wget https://raw.githubusercontent.com/jawuku/dotfiles/master/os_setups/new-debian-install.sh
chmod +x new-debian-install.sh
./new-debian-install.sh
```
