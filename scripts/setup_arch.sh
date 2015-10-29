#!/bin/bash
# setup_arch.sh - Run all scripts to setup arch env

# Setup some scripts paths

script_symlink="makesymlinks.sh"
script_vim="setup_vim.sh"
script_pacman="pacman-backup-tool.sh"
script_aur="setup_aur.sh"
script_lightdm="setup_lightdm.sh"

# Setup some colors

red=$'\e[1;31m'
green=$'\e[1;32m'
yellow=$'\e[1;33m'
blue=$'\e[1;34m'
end=$'\e[0m'


# Starting the setup
echo -e "${blue}Installing some required packages.${end}"

# Install some packages
pkgs="git vim python2 cmake zsh ranger"
sudo pacman -S $pkgs --needed


# Set 'zsh' as default shell
read -p "${yellow}Press a key to set 'zsh' as default shell.${end}"
chsh -s /bin/zsh


# Setup dotfiles symlinks
read -p "${yellow}Press a key to setup dotfiles symlinks.${end} ($script_symlink)"
./$script_symlink


# Setup vim & plugins
read -p "${yellow}Press a key to setup vim and its plugins.${end} ($script_vim)"
./$script_vim


# Setup X Server
xpkgs="gnome-keyring networkmanager network-manager-applet lib32-nvidia-340xx-libgl nvidia-340xx-libgl xarchiver xf86-input-synaptics xfce4 xfce4-goodies xfce4-screenshooter xorg-server xorg-xinit xterm"

echo -e "${blue}Now downloading & installing packages for X Server.${end}"
echo -e "Packages : ${green}$xpkgs${end}"
read -p "${yellow}Press a key to start.${end} "

sudo pacman -S $xpkgs --needed

echo ""
read -p "${yellow}Press a key to enable the NetworkManager service.${end}"
sudo systemctl enable NetworkManager.service

# Setup for LightDM & xfce4
read -p "${yellow}Press a key to setup LightDM.${end}($script_lightdm)"
./$script_lightdm

# Setup Bumblebee
bb_pkgs="bumblebee nvidia mesa xf86-video-intel lib32-nvidia-340xx-libgl lib32-virtualgl lib32-nvidia-utils lib32-mesa-libgl"

echo -e "${blue}Now downloading & installing packages for Bumblebee support.${end}"
echo -e "Packages : ${green}$bb_pkgs${end}"
read -p "${yellow}Press a key to start.${end} "

sudo pacman -S $bb_pkgs --needed

# Adding the user to the bumblebee group
curr_user="$USER"
read -p "${yellow}Adding the user '$curr_user' to the 'bumblebee' group.${end} "

gpasswd -a $curr_user bumblebee

# Enabling the bumblebee service
read -p "${yellow}Enabling the `bumblebeed` service.${end} ${red} Need to reboot for bumblebee to work.${end}"

sudo systemctl enable bumblebeed.service


# Setup AUR (Yaourt)
read -p "${yellow}Press a key to install Yaourt via pacman.${end} ($script_aur)"
./$script_aur


# Install AUR packages
aur_pkgs="dockbarx google-chrome-stable visual-studio-code xfce4-volumed xfce4-dockbarx-plugin-git"

echo -e "${blue}Now downloading & installing packages from the AUR using Yaourt.${end}"
echo -e "Packages : ${green}$aur_pkgs${end}"
read -p "${yellow}Press a key to start.${end} "

yaourt -S  $aur_pkgs --needed


# Restore packages from the backup
read -p "${yellow}Press a key to restore pacman packages from backup.${end} ($script_pacman)"
# ./$script_pacman -r

# Restore configs from the backup
# TODO : Copy backups .config, .fonts, .themes, pictures etc...
# TODO : xfce4-panel
