#!/bin/bash
#This script is for checking the service status and sourcing the commands output

if [ "$EUID" -ne 0 ]; then
    echo "You must be root or used sudo to run this script"
    exit 1
fi

check_status() {
    local SERVICE="$1"
    local STATUS=$(systemctl is-active "$SERVICE" 2>/dev/null)

        case "$STATUS" in
            active) echo "$SERVICE is active" ;;
            failed) echo "$SERVICE is failed to load" ;;
            inactive) echo "$SERVICE is inactive" ;;
            *) echo "unknown service" ;;
        esac
}

check_status nginx
check_status apache2
check_status docker