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
	echo "Creating the '$ld_path' script to enable the switch user with xfce4"
	echo "#!/bin/sh
/usr/bin/dm-tool switch-to-greeter" | sudo tee --append $ld_path >> /dev/null
fi

if [ ! -x $ld_path ]; then
	sudo chmod +x $ld_path
fi

# Generate the xflock4 file for light-locker
echo "Add the light-locker-command entry to the '/usr/bin/xflock4' to enable locking with xfce4"
# TODO : Add a check to see if the line is already there
# Adds the line before the 'xfcreensaver-command' with 4 spaces for indentation
sudo sed -i '/xscreensaver-command -lock/i  \    "light-locker-command --lock" \\' /usr/bin/xflock4

# Get a greeter
greeter_name="lightdm-webkit-greeter"
if [ ! -x "$(command -v yay)" ]; then
	#TODO : Do it manually instead of yay??
	echo "yay is required to get the '$greeter_name' from the AUR."
	exit
fi

yay -S $greeter_name --needed

# Set lightdm greeter
conf_file="/etc/lightdm/lightdm.conf"
echo "Replacing the current LightDM greeter to '$greeter_name'"
# TODO : Add a check to see if the line is already there
sudo sed -i '/greeter-session=/c\greeter-session='"$greeter_name" $conf_file

# Get a greeter theme
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
# TODO : Add a check to see if the line is already there
sudo sed -i '/webkit-theme=/c\webkit-theme='"$theme_folder_name" $greeter_conf
