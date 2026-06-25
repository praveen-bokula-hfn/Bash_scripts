#!/bin/bash
#This is conf.sh script
#Updated Script

nasconnect() {
    local NASIP="$1"
    local NASCRED="$2"
    local NASMOUNT="$3"
        if ping -c 1 -W 1 "$NASIP" >/dev/null 2>&1; then
            echo "$(date): Ping Successful.."
                else
            echo "$(date): Ping Unsuccessful.."
            return 1
        fi

        if mount_smbfs "$NASCRED" "$NASMOUNT" >/dev/null 2>&1; then
            echo "$(date): $NASIP Mount Successful.."
                else
            echo "$(date): $NASIP Mount Unsuccessful..."
            return 1
        fi
}

