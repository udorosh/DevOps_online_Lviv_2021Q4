#!/bin/bash


#This function lists TCP opened TCP ports on host
function portscan
{
        echo "Next ports are open:"
        ss -ant | sort -k 4
}

# This function shows existing ip addresses and names in asked network
function netscan {
        # Checking what NMAP  is installed
        test -e /usr/bin/nmap
        if [[ "$?" == "0" ]]
        then
                echo "NMAP is installed, trying to scan network..."
        else
                echo "NMAP isn't installed, trying to install NMAP..."
                sudo apt install nmap  -y
        fi

        # Checking what is subnet entered
        if [[ -z "$1" ]]
        then
                echo "ERROR! You must specify the subnet  in format xxx.xxx.xxx.*!"
                exit  0
        fi
# Perform scanning network with NMAP
        addr=$1
        echo "Next hosts hass been  found on this network:"
        nmap -sP $addr | awk 'NR % 2 == 0 {print "Hostname:" $5 "    " "IP Address:" $6}' | sed  's/(//g; s/)//g'
}

# This condition for written for display a list of possible keys and their description.
if [[ "$#" == "0" ]]
then
        echo "For this script actually next arguments:"
        echo -e "\033[32m For display the IP addresses and symbolic names of all hosts in the current subnet use argument --all"
        echo -e "\033[33m For display a list of open system TCP ports use  argument --target (example ./script_a.sh --target 192.168.1.*"
        echo -e "\033[0m"
        exit 0
fi


# Block  of script where is checking conditions of input parameter.
if [ "$1" == "--all" ]
then
        portscan

elif [ "$1" == "--target" ]
then
        netscan $2
fi
