#!/bin/bash
# setup_printer.sh - Script to setup printing

pkgs="cups system-config-printer"
echo -e "Installing the printer packages. ($pkgs)"
sudo pacman -S $pkgs --needed

service_name="org.cups.cupsd.service"
echo -e "Enabling & Starting the CUPS service. ($service_name)"
sudo systemctl enable $service_name
sudo systemctl start $service_name

groups="lp sys"
echo -e "Add the user '$USER' to the groups '$groups' to be able to manage printers."
read -p "Press any key to continue."

for grp in $groups
do
    sudo gpasswd -a $USER $grp
done

# Now run either the system-config-printer app OR the CUPS web app to add the printer
# May need to get the right driver from the AUR
# Resources :
#       - https://wiki.archlinux.org/index.php/CUPS
#       - https://wiki.archlinux.org/index.php/CUPS/Printer-specific_problems

# Example : For a brother printer : `yay brother-` will list all the brother printer packages
