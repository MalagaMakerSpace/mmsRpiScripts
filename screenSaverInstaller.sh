#!/bin/bash
# Coded by github.com/rgon
# To be used in unconfigured systems. Designed for the Raspberry Pi 3. Also tested on a Rpi1.

# CHECK THE AUTOSTART PATH

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cp -r "$DIR/Screensavers" ~

#sudo xset s off
