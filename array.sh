#!/bin/bash
#this is a new script written with for loop and correction from the previous script

if [ "$EUID" -ne 0 ]; then
    echo "You must be root or use sudo to run this script"
    exit 1
fi

check_status() {
    local SERVICE="$1"
    local STATUS=$(systemctl is-active "$SERVICE" 2>/dev/null)

    case "$STATUS" in
        active) echo "$SERVICE: is active" ;;
        failed) echo "$SERVICE: has failed" ;;
        inactive) echo "$SERVICE: is inactive" ;;
        *) echo "$SERVICE: $STATUS is unknown" ;;
    esac
}

SERVICES=("nginx" "apache2" "docker" "sshd" "gdm")

for SERVICE in "${SERVICES[@]}"
    do
    check_status "$SERVICE"
done