#!/bin/bash
# setup_arch.sh - Run all scripts to setup arch env

# Setup some scripts paths
script_path="$(dirname $(readlink -f $0))"
script_symlink="setup_dotfiles.sh"
script_vim="setup_vim.sh"
script_pacman="pacman-backup-tool.sh"
script_aur="setup_aur.sh"
script_lightdm="setup_lightdm.sh"
script_dev="setup_dev.sh"

# Setup some colors

red=$'\e[1;31m'
green=$'\e[1;32m'
yellow=$'\e[1;33m'
blue=$'\e[1;34m'
end=$'\e[0m'

# Starting the setup

# Install some packages
pkgs="git vim python2 cmake zsh ranger openssh"

echo -e "${blue}Installing some required packages.${end}($pkgs)"
sudo pacman -S $pkgs --needed


# Set 'zsh' as default shell
if [ "$SHELL" != "/bin/zsh" ]; then
	read -p "${yellow}Press a key to set 'zsh' as default shell.${end}(Y/n)" -n 1 option
	if [[  $option != n ]] && [[ $option != N ]]; then
		chsh -s /bin/zsh
	fi
fi


# Setup dotfiles symlinks
read -p "${yellow}Press a key to setup dotfiles symlinks.${end} ($script_symlink)(Y/n)" -n 1 option
if [[  $option != n ]] && [[ $option != N ]]; then
	$script_path/$script_symlink
fi

# Setup vim & plugins
read -p "${yellow}Press a key to setup vim and its plugins.${end} ($script_vim)(Y/n)" -n 1 option
if [[  $option != n ]] && [[ $option != N ]]; then
	$script_path/$script_vim
fi


# Setup X Server
xpkgs="bluez bluez-utils blueman gnome-keyring gvfs gvfs-mtp networkmanager network-manager-applet mesa-libgl lib32-mesa-libgl p7zip pulseaudio pulseaudio-alsa pavucontrol skype unrar unzip vlc xarchiver xf86-input-synaptics xfce4 xfce4-goodies xfce4-screenshooter xorg-server xorg-xinit xterm"

echo -e "${blue}Now downloading & installing packages for X Server.${end}"
echo -e "Packages : ${green}$xpkgs${end}"
read -p "${yellow}Press a key to start.${end} (Y/n)" -n 1 option
if [[  $option != n ]] && [[ $option != N ]]; then
	sudo pacman -S $xpkgs --needed
fi

read -p "${yellow}Press a key to enable the NetworkManager service.${end} (Y/n)" -n 1 option
if [[  $option != n ]] && [[ $option != N ]]; then
	sudo systemctl enable NetworkManager.service
fi

read -p "${yellow}Press a key to enable the Bluetooth service.${end} (Y/n)" -n 1 option
if [[  $option != n ]] && [[ $option != N ]]; then
	sudo systemctl enable bluetooth
	sudo systemctl start bluetooth
fi


# Setup for LightDM & xfce4
read -p "${yellow}Press a key to setup LightDM.${end}($script_lightdm) (Y/n)" -n 1 option
if [[  $option != n ]] && [[ $option != N ]]; then
	$script_path/$script_lightdm
fi

# Setup Bumblebee
bb_pkgs="bumblebee bbswitch nvidia mesa xf86-video-intel lib32-virtualgl lib32-nvidia-utils lib32-mesa-libgl"

echo -e "${blue}Now downloading & installing packages for Bumblebee support.${end}"
echo -e "Packages : ${green}$bb_pkgs${end}"
read -p "${yellow}Press a key to start.(Y/n)${end} (Y/n)" -n 1 option

if [[  $option != n ]] && [[ $option != N ]]; then
	sudo pacman -S $bb_pkgs --needed
fi

# Adding the user to the bumblebee group
curr_user="$USER"
read -p "${yellow}Adding the user '$curr_user' to the 'bumblebee' group.${end} (Y/n)" -n 1 option
if [[  $option != n ]] && [[ $option != N ]]; then
	sudo gpasswd -a $curr_user bumblebee
fi

# Enabling the bumblebee service
read -p "${yellow}Enabling the `bumblebeed` service.${end} ${red} Need to reboot for bumblebee to work.${end} (Y/n)" -n 1 option
if [[ $option != n ]] && [[ $option != N ]]; then
	sudo systemctl enable bumblebeed.service
fi

# Setup AUR (Yaourt)
read -p "${yellow}Press a key to install Yaourt via pacman.${end} ($script_aur) (Y/n)" -n 1 option
if [[ $option != n ]] && [[ $option != N ]]; then
	$script_path/$script_aur
fi

# Install AUR packages
aur_pkgs="dockbarx fzf grive grive-tools google-chrome spotify visual-studio-code xfce4-volumed xfce4-dockbarx-plugin-git xfce4-pulseaudio-plugin xfce4-indicator-plugin "

echo -e "${blue}Now downloading & installing packages from the AUR using Yaourt.${end}"
echo -e "Packages : ${green}$aur_pkgs${end}"
read -p "${yellow}Press a key to start.${end}(Y/n)" -n 1 option

if [[ $option != n ]] && [[ $option != N ]]; then
	yaourt -S  $aur_pkgs --needed --noconfirm
fi

# Install Theme packages
theme_pkgs="dorian-theme numix-icon-theme-git numix-circle-icon-theme-git"
echo "Installing theme related packages ($theme_pkgs)"
echo -e "${blue}Now downloading & installing theme related packages from the AUR using Yaourt.${end}"
echo -e "Packages : ${green}$theme_pkgs${end}"
read -p "${yellow}Press a key to start.${end}(Y/n)n" -n 1 option

if [[ $option != n ]] && [[ $option != N ]]; then
	yaourt -S  $theme_pkgs --needed --noconfirm
fi

# Install some other required packages
pkgs2="ntfs-3g"
read -p "${yellow}Press a key to install some other required packages.${end} ($pkgs2)(Y/n)" -n 1 option
if [[ $option != n ]] && [[ $option != N ]]; then
	sudo pacman -S $pkgs2 --needed --noconfirm
fi

# Setup DEV environement
read -p "${yellow}Press a key to setup the development environment.${end} ($script_dev) (Y/n)" -n 1 option
if [[ $option != n ]] && [[ $option != N ]]; then
	$script_path/$script_dev
fi




# Restore packages from the backup
read -p "${yellow}Press a key to restore pacman packages from backup.${end} ($script_pacman)(Y/n)" -n 1 option
if [[ $option != n ]] && [[ $option != N ]]; then
	# $script_path/$script_pacman -r
	echo "TODO : Uncomment the command"
fi

# Restore configs from the backup
# TODO : Copy backups .config, .fonts, .themes, pictures etc...
# TODO : xfce4-panel
