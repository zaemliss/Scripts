#!/bin/bash

RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;36m'
NC='\033[0m'

echo
echo -e "${YELLOW} Installing dependancies ..."
sudo apt-get update -y > /dev/null 2>&1
sudo apt-get install -y --reinstall build-essential > /dev/null 2>&1
sudo apt-get install -y --reinstall gcc > /dev/null 2>&1
sudo dpkg-reconfigure build-essential > /dev/null 2>&1
sudo dpkg-reconfigure gcc > /dev/null 2>&1

echo
echo -e "${GREEN} Building Project ..."
cd ~
git clone https://github.com/ALQOCRYPTO/ALQO.git > /dev/null 2>&1
cd ~/ALQO
./autogen.sh

# make -C depends         -- this will take about 1-6 hours probably and you'll end up with a depends/x86_64-pc-linux-gnu with all the stuff you need to compile and link successfully
# ./configure --prefix=/path/to/your/ALQO/depends/x86_64-pc-linux-gnu <any other switches you want>
# make                  -- you'll end up with src/alqod, src/alqo-cli, src/qt/alqo-qt etc as normal. Copy/move them where you want them. If you make install they'll end up in that depends directory.
