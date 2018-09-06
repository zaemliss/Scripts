#!/bin/bash

RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;36m'
NC='\033[0m'

printf '\e[48;5;0m'
clear
sudo apt install -y bc jq > /dev/null 2>&1
echo "getting list..."

while [ 1 ]; do
curblocks=$(~/ALQO/alqo-cli getinfo | grep blocks | awk {'print $2'} | tr -d ",")
nodes=$(~/ALQO/alqo-cli masternode list | grep version)
updated=$(awk -F"70717" '{print NF-1}' <<< "${nodes}" | grep -E 1 -c)
old=$(awk -F"70716" '{print NF-1}' <<< "${nodes}" | grep -E 1 -c)
ancient=$(awk -F"70715" '{print NF-1}' <<< "${nodes}" | grep -E 1 -c)
total=$(awk -F"version" '{print NF-1}' <<< "${nodes}" | grep -E 1 -c)
percent=$(bc <<< "scale = 4;$updated / $total * 100")
percent=${percent::-5}
apiblockheight=$(curl -s https://explorer.alqo.org/api/blockcount)
logresult=$(tail -n 8 ./.alqo/debug.log)
bestblock=$(./ALQO/alqo-cli getblockchaininfo | jq .bestblockhash | tr -d '"')
supply=$(./ALQO/alqo-cli getblock $bestblock | jq .moneysupply)
supply=$(echo ${supply%.*})
lockedcoins=$((updated * 10000))
lockedpercent=$(bc <<< "scale = 2; $lockedcoins / $supply * 100")
lockedpercent=${lockedpercent::-3}

clear
echo
echo -e "${BLUE} ALQO Masternode Migration monitoring script.${NC}"
echo
echo -e "${YELLOW} $updated ${BLUE}Masternodes on protocol ${GREEN}70717 ${BLUE}out of ${YELLOW}$total ${BLUE}[${RED}$percent %${BLUE}]${NC}"
echo -e "${YELLOW} $lockedcoins ${BLUE}coins locked out of ${GREEN}$supply ${BLUE}in circulation ${BLUE}[${RED}$lockedpercent %${BLUE}]${NC}"
echo
echo -e "${BLUE} Masternodes on protocol ${RED}70716 : ${YELLOW}$old${NC}"
echo -e "${BLUE} Masternodes on protocol ${RED}70715 : ${YELLOW}$ancient${NC}"
echo
if [ ${apiblockheight} != ${curblocks} ]; then
        echo -e "${BLUE} API Current Block Height  : ${RED}$apiblockheight${NC}"
else
        echo -e "${BLUE} API Current Block Height  : ${YELLOW}$apiblockheight${NC}"
fi
echo -e "${BLUE} Local wallet Block Height : ${YELLOW}$curblocks${NC}"
echo
echo -e "${YELLOW}Log File:${NC}"
echo -e "${YELLOW}==========================================================================="
echo -e "${BLUE}$logresult${NC}"
echo -e "${YELLOW}==========================================================================="
echo
echo -e "${GREEN} Press CTRL-C to exit. Updated every 25 seconds.${NC}"
echo
echo -ne " "
for i in `seq 1 25`;
    do
        f=$(($i - 1))
        echo -ne "\r${RED}▌•${GREEN}"
        eval $(echo -ne printf '"█%0.s"' {1..$i})
        if [ $i -lt 25 ]; then eval $(echo -ne printf '"░%0.s"' {$f..23}); fi
        echo -ne "${RED}•▐${NC}"
        sleep 1
    done

    echo
    echo -ne "${YELLOW}  Retrieving new data...${NC}\r"
done

