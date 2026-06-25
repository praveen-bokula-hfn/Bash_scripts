#!/bin/bash
#This is install.sh script
#In the previous response you have said that 90% of the code is identical
#So i am writing the same code differently

set -e

echo "1) Choose to connect to Archives NAS"
echo "2) Choose to connect to PA NAS"

read -rp "Choose which nas you want to connect: " OPTION

. ./conf.sh

case "$OPTION" in
    1)
    nasconnect \
    10.1.1.23 \
    "//hfncns.local;praveenb@10.1.23/Archives" \
    "$HOME/nas_share"
    ;;

    2)
    nasconnect \
    10.1.4.11 \
    "ashok@10.1.4.11/Ashok" \
    "$HOME/nas_share1"
    ;;

    *) echo "Error: Choose the correct option" ;;
esac

#Checking if NAS mounted and if mounted then we unmount it

case "$OPTIONS" in
    1)
    if mount | grep -q "10.1.1.23"
    then
        echo "unmounting"
        umount "$HOME/nas_share"
    fi
    ;;

    2)
    if mount | grep -q "10.1.4.11"
    then
        echo "unmounting"
        umount "$HOME/nas_share1"
    fi
    ;;
esac
