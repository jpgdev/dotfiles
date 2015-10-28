#!/bin/bash
# setup_arch.sh - Run all scripts to setup arch env

# Setup some scripts paths

script_symlink="makesymlinks.sh"
script_vim="setup_vim.sh"
script_pacman="pacman-backup-tool.sh" 

# Setup some colors

red=$'\e[1;31m'
green=$'\e[1;32m'
yellow=$'\e[1;33m'
blue=$'\e[1;34m'
end=$'\e[0m'

echo -e "${blue}Installing some required packages.${end}"

# Install some packages
pkgs="git vim python2 cmake zsh ranger"
sudo pacman -S $pkgs --needed

# Set 'zsh' as default shell
read -p "${blue}Press a key to set 'zsh' as default shell.${end}"
chsh -s /bin/zsh

# Setup dotfiles symlinks
read -p "${yellow}Press a key to setup dotfiles symlinks.${end} ($script_symlink)"
./$script_symlink

# Setup vim & plugins
read -p "${yellow}Press a key to setup vim and its plugins.${end} ($script_vim)"
./$script_vim

# TODO : Add script to setup Yaourt

read -p "${yellow}Press a key to restore pacman packages from backup.${end} ($script_pacman)"
#Restore pacman packages from backup
# ./$script_pacman -r


