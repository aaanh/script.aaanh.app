#!/bin/bash

RED='\033[0;31m'
NC='\033[0m' # No Color

# This is for controller node only.

# Check root privilege
if (( $EUID == 0 )); then
    echo "${RED}Please run as user."
    exit
fi

# Install ansible
pip install ansible-base
