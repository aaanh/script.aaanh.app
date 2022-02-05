#!/bin/bash

RED='\033[0;31m'
NC='\033[0m' # No Color

# Check root privilege
if (( $EUID != 0 )); then
    echo "${RED}Please run as root."
    exit
fi

# Check distro package manager

if [ -n "$(command -v yum)" ]; then
    echo "yum-based distribution detected."
    yum install python3 python3-pip
elif [ -n "$(command -v apt)" ]; then
    echo "apt-based distribution detected."
    apt install python3 python3-pip