#!/bin/bash
sudo iw wlan0 set power_save off
sudo ifconfig wlan0 up
sudo service network-manager restart
