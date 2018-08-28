#!/bin/bash

RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;36m'
NC='\033[0m'

clear
echo "getting list..."

while [ 1 ]; do
nodes=$(~/ALQO/alqo-cli masternode list)
updated=$(awk -F"70716" '{print NF-1}' <<< "${nodes}" | grep -E 1 -c)
total=$(awk -F"version" '{print NF-1}' <<< "${nodes}" | grep -E 1 -c)
percent=$(bc <<< "scale = 4;$updated / $total * 100")
blockheight=$(curl -s https://explorer.alqo.org/api/blockcount)
clear
echo
echo -e "${BLUE} ALQO Masternode Migration monitoring script.${NC}"
echo
echo -e "${YELLOW} $updated ${BLUE}Masternodes on protocol ${GREEN}70716 ${BLUE}out of ${YELLOW}$total ${BLUE}[${RED}$percent${BLUE$
echo
echo -e "${BLUE} Current Block Height : ${YELLOW}$blockheight${NC}"
echo
echo -e "${GREEN} Press CTRL-C to exit. Updated every 25 seconds.${NC}"
echo
sleep 25
done