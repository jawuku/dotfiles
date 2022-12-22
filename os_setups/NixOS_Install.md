# NixOS 22.11 Setup from Minimal ISO
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
### Replace `myhomenetwork` and `mypassword` with own network and password
### including the double quotes
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

swapon /dev/disk/by-label/swap
```

### Download configuration files
```sh
nixos-generate-config --root /mnt
cd /mnt/etc/nixos
rm configuration.nix
nix-shell -p wget
wget https://raw.githubusercontent.com/jawuku/dotfiles/master/nixos/configuration.nix
wget https://raw.githubusercontent.com/jawuku/dotfiles/master/nixos/home.nix
nixos-install
```

## Test new system - change password once logged in
```sh
sudo reboot
```
## New Password - login as user and open a terminal
### Initial password is 123
```sh
passwd # enter new password twice
```
