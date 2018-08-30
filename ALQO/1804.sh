#!/bin/bash

RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;36m'
NC='\033[0m'

function verbose()
{
  echo
  echo -e "${YELLOW} Installing dependencies ...${NC}"
  echo
  sudo apt-get update -y
  sudo apt-get install -y --reinstall build-essential
  sudo apt-get install -y automake autoconf libtool perl pkg-config m4
  sudo apt-get install -y --reinstall gcc
  sudo dpkg-reconfigure build-essential
  sudo dpkg-reconfigure gcc
  echo
  echo -e "${BLUE}Creating Swap... (ignore errors, this might not be supported)${NC}"
  fallocate -l 3G /swapfile
  chmod 600 /swapfile
  mkswap /swapfile
  swapon /swapfile
  echo
  echo -e "/swapfile none swap sw 0 0 \n" >> /etc/fstab
  
  ACLOCAL_PATH=/usr/share/aclocal ./autogen.sh

  echo -e "${GREEN} Getting Project from Git ...${NC}"
  cd ~
  git clone https://github.com/ALQOCRYPTO/ALQO.git
  cd ~/ALQO
  ACLOCAL_PATH=/usr/share/aclocal ./autogen.sh
  echo

  echo -e "${GREEN} Building Dependencies ...${NC}"
  echo -e "${RED}this will take about an hour, please be patient !${NC}"
  make -C depends
  echo

  echo -e "${GREEN} Configuring Environment ...${NC}"
  echo -e "${RED}this will take about 5 minutes, please be patient !${NC}"
  ./configure --prefix=/root/ALQO/depends/x86_64-pc-linux-gnu
  echo

  echo -e "${BLUE} Compiling Binaries ...${NC}"
  echo -e "${RED}this will take about an hour, please be patient !${NC}"
  make
  echo -ne "${YELLOW}#${NC}"
  echo

  echo -e "${BLUE} Copying Binaries to ~/ALQO ...${NC}"
  cp ~/ALQO/src/alqod ~/ALQO
  cp ~/ALQO/src/alqo-cli ~/ALQO
  cp ~/ALQO/src/qt/alqo-qt ~/ALQO
}

function silent()
{
  echo
  echo -e "${YELLOW} Installing dependencies ..."
  echo -ne "${GREEN}#${NC}"
  sudo apt-get update -y > /dev/null 2>&1
  echo -ne "${GREEN}#${NC}"
  sudo apt-get install -y --reinstall build-essential > /dev/null 2>&1
  echo -ne "${GREEN}#${NC}"
  sudo apt-get install -y automake autoconf libtool perl pkg-config m4 > /dev/null 2>&1
  echo -ne "${GREEN}#${NC}"
  sudo apt-get install -y --reinstall gcc > /dev/null 2>&1
  echo -ne "${GREEN}#${NC}"
  sudo dpkg-reconfigure build-essential > /dev/null 2>&1
  echo -ne "${GREEN}#${NC}"
  sudo dpkg-reconfigure gcc > /dev/null 2>&1
  echo
  echo -e "${BLUE}Creating Swap... (ignore errors, this might not be supported)${NC}"
  fallocate -l 3G /swapfile > /dev/null 2>&1
  chmod 600 /swapfile > /dev/null 2>&1
  mkswap /swapfile > /dev/null 2>&1
  swapon /swapfile > /dev/null 2>&1
  echo
  echo -e "/swapfile none swap sw 0 0 \n" >> /etc/fstab > /dev/null 2>&1
  
  echo -e "${GREEN} Getting Project from Git ...${NC}"
  cd ~
  git clone https://github.com/ALQOCRYPTO/ALQO.git > /dev/null 2>&1
  echo -ne "${YELLOW}#${NC}"
  cd ~/ALQO
  ACLOCAL_PATH=/usr/share/aclocal ./autogen.sh > /dev/null 2>&1
  echo -ne "${YELLOW}#${NC}"
  echo

  echo -e "${GREEN} Building Dependencies ...${NC}"
  echo -e "${RED}this will take about an hour, please be patient !${NC}"
  make -C depends > /dev/null 2>&1
  echo

  echo -e "${GREEN} Configuring Environment ...${NC}"
  echo -e "${RED}this will take about 5 minutes, please be patient !${NC}"
  ./configure --prefix=/root/ALQO/depends/x86_64-pc-linux-gnu > /dev/null 2>&1
  echo

  echo -e "${BLUE} Compiling Binaries ...${NC}"
  echo -e "${RED}this will take about an hour, please be patient !${NC}"
  make > /dev/null 2>&1
  echo -ne "${YELLOW}#${NC}"
  echo

  echo -e "${BLUE} Copying Binaries to ~/ALQO ...${NC}"
  echo -ne "${YELLOW}#${NC}"
  cp ~/ALQO/src/alqod ~/ALQO > /dev/null 2>&1
  echo -ne "${YELLOW}#${NC}"
  cp ~/ALQO/src/alqo-cli ~/ALQO > /dev/null 2>&1
  echo -ne "${YELLOW}#${NC}"
  cp ~/ALQO/src/qt/alqo-qt ~/ALQO > /dev/null 2>&1
}

function start()
{
echo
echo -e "${RED}****************************************${NC}"
echo -e "${RED}*   ${YELLOW}Ubuntu 18.04 Alqo Compiler Script  ${RED}*${NC}"
echo -e "${RED}*   ${GREEN}Version: ${BLUE}1.04                      ${RED}*${NC}"
echo -e "${RED}*   ${GREEN}Supports: ${BLUE}Ubuntu 18.04 on Vultr    ${RED}*${NC}"
echo -e "${RED}*   ${GREEN}By: ${BLUE}chris, 2018                    ${RED}*${NC}"
echo -e "${RED}****************************************${NC}"
echo
echo -e "${BLUE} do you want to see verbose output? ${GREEN}[Y/N]${NC}"

read -e -p " : " CHOICE
if [[ ("$CHOICE" == "Y" || "$CHOICE" == "y") ]]; then
  verbose
else
  silent
fi
}

start
