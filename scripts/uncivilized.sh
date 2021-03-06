#!/bin/bash
#title:         uncivilized.sh
#description:   Removal Script
#author:        R12W4N
#==============================================================================
[ "$DEBUG" == 'true' ] && set -x
RED=`tput setaf 1`
GREEN=`tput setaf 2`
RESET=`tput sgr0`
BLUE=`tput setaf 4`

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

function trap_ctrlc ()
{
    echo "Ctrl-C caught...performing clean up"
 
    echo "Doing cleanup"
    trap "kill 0" EXIT
    exit 2
}
trap "trap_ctrlc" 2 

function unsetup()
{
	echo "${GREEN}Users On this system${RESET}"
	echo | ls /home
	read -p "${RED}Enter FalconPool Unit Name : ${RESET}" FalconName
	echo "${GREEN}Deleting User $FalconName ${RESET}"
	/bin/bash ./modules/adduser.sh -a del $FalconName 
	echo "${GREEN}Removing SSH Keys ${RESET}"
	rm ~/.ssh/*
	echo "${GREEN}Removing rc-local.service${RESET}"
	sudo systemctl disable rc-local
	rm /etc/systemd/system/rc-local.service
	rm /etc/rc.local
	echo "${GREEN}Reboot this device...${RESET}"
}

unsetup
