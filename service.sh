#!/bin/bash

#This script is used to check whether services are running, failed, or stopeed etc 

if [ "$EUID" -ne 0 ]; then
    echo "You must be root or use sudo to run this script"
    exit 1
fi

echo "1) Choose if you want to check nginx status"
echo "2) Choose if you want to check sshd status"
echo "3) Choose if you want to check docker status"

read -rp "Choose which service you want to check: " OPTION

check_status() {
    local SERVICE="$1"
    if systemctl is-active --quiet "$SERVICE"
    then
    echo "$(date): $SERVICE is running"
    else
    echo "$(date): $SERVICE is not running"
    fi
}

case "$OPTION" in
    1) check_status nginx.service ;;
    2) check_status sshd.service ;;
    3) check_status docker.service ;;
    *) echo "ERROR: Choose the correct option"
esac
