#!/bin/bash

#We are now going to generated a random password

echo "1) choose if you want to generated a 8 character random password"
echo "2) choose if you want to generated a 16 character random password"
echo "3) choose if you want to generated a 32 character random password"

read -rp "Choose you option to generate password: " OPTION

case "$OPTION" in
    1) tr -dc 'A-Za-z' </dev/urandom | fold -w 8 | head -n 1 ;;
    2) tr -dc 'A-Za-z' </dev/urandom | fold -w 16 | head -n 1 ;;
    3) tr -dc 'A-Za-z' </dev/urandom | fold -w 32 | head -n 1 ;;
    *) echo "ERROR: Choose the correct option"
esac

#This is another method not for running the script only for demo or correction 

case "$OPTION" in
    1) openssl rand -base64 8 ;;
    2) openssl rand -base64 16 ;;
    3) openssl rand -base64 32 ;;
    *) echo "ERROR: Choose the correct option"
esac