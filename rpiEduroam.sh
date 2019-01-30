#!/bin/bash
# Coded by github.com/rgon
# To be used in unconfigured systems. Designed for the Raspberry Pi 3. Also tested on a Rpi1.

# CHECK THE AUTOSTART PATH, SCREENSAVER INSTALLER CMD

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
NMPROFILEDIR="/etc/NetworkManager/system-connections"
CERTURL="http://www.uma.es/media/files/DigiCertCA.crt"

clear

# Ask the user the Account and Password
echo -n "Eduroam user (email): "
read user
echo -n "Password: "
read -s password
echo ""

clear

# BEGIN
cd ~

# Copy our custom scripts
cp -r "$DIR/malagaMakerScripts" "~/malagaMakerScripts"
# cp "$DIR/onBoot.desktop" "~/.config/autostart/"

# Download the eduroam certificate
# wget -O "~/DigicertCA.crt" "$CERTURL"
cp "DIR/DigicertCA.crt" "~/DigicertCA.crt"

sudo chmod go-w "~/DigicertCA.crt"

# Install network-manager
sudo apt remove wicd
sudo service wicd stop &
sudo apt install network-manager network-manager-gnome
sudo apt purge openresolv dhcpcd5
sudo ln -sf /lib/systemd/resolv.conf /etc/resolv.conf

# For screensaver & other required stuff
sudo apt install feh xprintidle xdotool openssh-server

# Replace the email and password fields
sudo sed -e "s/\${user}/$user/" -e "s/\${password}/$password/" "$DIR/eduroamTemplate.txt" > "$NMPROFILEDIR/eduroam" # Not enough privileges and sed not working

# Protect the read of this file
sudo chmod 600 "$NMPROFILEDIR/eduroam"
clear
echo 'You may need to manually clear /etc/resolv.conf'
echo 'You may also need to remove wlan0/wlanX from /etc/network/interfaces'

# Start the connection
sudo nmcli con up eduroam

# Test connectivity
echo "Testing internet access."
ping -c 3 1.0.0.1
echo "Testing DNS resolution and internet access."
ping -c 3 cloudflare.com

bash "$DIR/screenSaverInstaller.sh"
bash "$DIR/lnScripts.sh"
bash "$DIR/installOctoprint.sh"
