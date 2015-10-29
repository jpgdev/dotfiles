#!/bin/sh
# setup_lightdm.sh - Setup lightdm with xfce4

# Get LightDM packages
pkgs="lightdm light-locker"
echo -e "Now downloading & installing packages for LightDM. ($pkgs)"

sudo pacman -S $pkgs --needed

# Enable the LightDM service
echo -e "Enabling the LightDM service."
sudo systemctl enable lightdm.service

# Generating the file that xfce4 is looking for when attemping to switch user
ld_path="/usr/bin/gdmflexiserver"
if [ ! -f $ld_path ]; then
	echo "#!/bin/sh
	/usr/bin/dm-tool switch-to-greeter" | sudo tee --append $ld_path >> /dev/null
fi

# Get a greeter
greeter_name="lightdm-webkit-greeter"
if [ ! -x "$(command -v yaourt)" ]; then
	#TODO : Do it manually instead of Yaourt??
	echo "Yaourt is required to get the '$greeter_name' from the AUR."
	exit
fi

yaourt -S $greeter_name --needed

# Set lightdm greeter
conf_file="/etc/lightdm/lightdm.conf"
echo "Replacing the current LightDM greeter to '$greeter_name'"
sudo sed -i '/greeter-session=/c\greeter-session='"$greeter_name" $conf_file

# Get a greeter theme
# theme_url="http://github.com/shosca/lightdm-webkit-archlinux-theme"
theme_url="http://github.com/jpgdev/lightdm-webkit-archlinux-theme"
theme_folder_name="arch"
theme_folder="/usr/share/lightdm-webkit/themes/"
if [ ! -d "$theme_folder$theme_folder_name" ]; then
	echo "Getting a theme for the greeter from '$theme_url' with git."
	sudo git clone $theme_url "$theme_folder$theme_folder_name"
fi
# Set greeter theme
greeter_conf="/etc/lightdm/lightdm-webkit-greeter.conf"
echo "Setting the theme name in the '$greeter_name' config file."
sudo sed -i '/webkit-theme=/c\webkit-theme='"$theme_folder_name" $greeter_conf