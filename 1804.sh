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
sudo apt-get install -y automake autoconf libtool perl pkg-config m4 > /dev/null 2>&1
echo -ne "#{GREEN}#${NC}"
sudo apt-get install -y --reinstall gcc > /dev/null 2>&1
echo -ne "#{GREEN}#${NC}"
sudo dpkg-reconfigure build-essential > /dev/null 2>&1
echo -ne "#{GREEN}#${NC}"
sudo dpkg-reconfigure gcc > /dev/null 2>&1
echo

ACLOCAL_PATH=/usr/share/aclocal ./autogen.sh

echo -e "${GREEN} Getting Project from Git ...#{NC}"
cd ~
git clone https://github.com/ALQOCRYPTO/ALQO.git > /dev/null 2>&1
echo -ne "#{YELLOW}#${NC}"
cd ~/ALQO
./autogen.sh > /dev/null 2>&1
echo -ne "#{YELLOW}#${NC}"
echo

echo -e "${GREEN} Building Dependencies ...#{NC}"
echo -e "${RED}this will take about 1-6 hours !${NC} STARTED 6:16"
make -C depends > /dev/null 2>&1
echo

echo -e "${GREEN} Configuring Environment ...#{NC}"
./configure --prefix=/root/ALQO/depends/x86_64-pc-linux-gnu > /dev/null 2>&1
echo

echo -e "${BLUE} Compiling Binaries ...#{NC}"
make > /dev/null 2>&1
echo -ne "#{YELLOW}#${NC}"
echo

echo -e "${BLUE} Copying Binaries to ~/ALQO ...#{NC}"
echo -ne "#{YELLOW}#${NC}"
cp ~/ALQO/src/alqod ~/ALQO > /dev/null 2>&1
echo -ne "#{YELLOW}#${NC}"
cp ~/ALQO/src/alqo-cli ~/ALQO > /dev/null 2>&1
echo -ne "#{YELLOW}#${NC}"
cp ~/ALQO/src/alqod-qt ~/ALQO > /dev/null 2>&1
echo
