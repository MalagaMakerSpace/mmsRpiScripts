#!/bin/bash
# Coded by github.com/rgon
# To be used in unconfigured systems. Designed for the Raspberry Pi 3. Also tested on a Rpi1.

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

for f in ~/malagaMakerScripts/*
do
BASE=$(basename $f)
echo "Linking: $BASE"
ln -s "$f" "~/Desktop/$BASE"
done

