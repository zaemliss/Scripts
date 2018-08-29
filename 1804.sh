#!/bin/bash

RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;36m'
NC='\033[0m'

echo
echo -e "${YELLOW} Installing dependancies ..."
echo -ne "#{GREEN}#${NC}"
sudo apt-get update -y > /dev/null 2>&1
echo -ne "#{GREEN}#${NC}"
sudo apt-get install -y --reinstall build-essential > /dev/null 2>&1
echo -ne "#{GREEN}#${NC}"
sudo apt-get install -y automake autoconf libtool > /dev/null 2>&1
echo -ne "#{GREEN}#${NC}"
sudo apt-get install -y --reinstall gcc > /dev/null 2>&1
echo -ne "#{GREEN}#${NC}"
sudo dpkg-reconfigure build-essential > /dev/null 2>&1
echo -ne "#{GREEN}#${NC}"
sudo dpkg-reconfigure gcc > /dev/null 2>&1
echo


echo -e "${GREEN} Getting Project from Git ...#{NC}"
cd ~
git clone https://github.com/ALQOCRYPTO/ALQO.git > /dev/null 2>&1
echo -ne "#{YELLOW}#${NC}"
cd ~/ALQO
./autogen.sh > /dev/null 2>&1
echo -ne "#{YELLOW}#${NC}"
echo
echo -e "${GREEN} Building Dependencies ...#{NC}"
make -C depends > /dev/null 2>&1
echo -e "${RED}this will take about 1-6 hours !${NC} STARTED 6:06"
./configure --prefix=~/ALQO/depends/x86_64-pc-linux-gnu
make


-- you'll end up with src/alqod, src/alqo-cli, src/qt/alqo-qt etc as normal. Copy/move them where you want them. If you make install they'll end up in that depends directory.
