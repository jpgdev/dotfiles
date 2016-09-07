#!/bin/sh
# setup_dev.sh - Script to install some dev tools and librairies

pkgs="nodejs npm postgresql postgresql-libs pgadmin3 redis synapse synergy the_silver_surfer"
echo "Installing dev related packages using pacman ($pkgs)"
sudo pacman -S $pkgs --needed

aur_pkgs="visual-studio-code redis-desktop-manager-bin"
echo "Installing dev related packages using Yaourt ($aur_pkgs)"
sudo yaourt -S $aur_pkgs --needed --noconfirm

echo "Setup Node & NPM"
# TODO : Validate that NPM & Node exist
npm_pkgs="bower grunt grunt-cli"
echo "Installing global NPM packages ($npm_pkgs)"
sudo npm install -g $npm_pkgs

pg_root='/home/postgres'
echo "Setup & Start Postgresql service (PGROOT = $pg_root)"

# TODO : Maybe add an `export PGROOT=$pg_root`, so we don't need to change the service file OR change the service file in this script
sudo useradd -m postgres
sudo -i -u postgres
sudo mkdir "$pg_root/data"
initdb -D "$pg_root/data"

# Enable and start the service
# Note : If this does not work, may require to modify the file copied with the enable call to change the PG_ROOT location
# Troubleshooting :
# - Go change the 'Environment=PGROOT=/var/lib/postgres' line manually to '....=/home/postgres'
# - Maybe change the 'ProtectHome' line from 'true' to 'false'
# File : /usr/lib/systemd/system/postgresql.service
sudo systemctl enable postgresql.service
sudo systemctl start postgresql.service

echo "Enable & start redis service"
sudo systemctl enable redis.service
sudo systemctl start redis.service
