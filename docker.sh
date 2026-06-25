#!/bin/bash
#This script is for checking docker status and asking user to stop or continue to run the service

if [[ -z "$1" ]]; then
    echo "Usage: $0 <service-name>"
    exit 1
fi

SERVICE="$1"

if ! systemctl list-unit-files | grep -q "^${SERVICE}.service"; then
    echo "$SERVICE service doesn't exist"
    exit 1
fi

echo "Checking $SERVICE service status"
echo

if systemctl is-active --quiet "$SERVICE"; then
    echo "$SERVICE service is active"
else
    echo "$SERVICE is inactive. Trying to start..."
    if systemctl start "$SERVICE"; then
        echo "$SERVICE service is started"
    else
        echo "Failed to start $SERVICE service"
        exit 1
    fi
fi

while true; do
echo "=====SERVICE-MANAGER====="
echo "(s) start" 
echo "(t) stop"
echo "(r) restart"
echo "(e) enable"
echo "(d) disable"
echo "(q) quit"
    read -rp "Choose you option: " OPTION

    case "$OPTION" in
        s|S)
            echo "$SERVICE service is starting"
            if systemctl start "$SERVICE"; then
                echo "$SERVICE service is started successfully.."
            else
                echo "$SERVICE is failed to start"
            fi
            ;;
        t|T)
            echo "$SERVICE service is stopping"
            if systemctl stop "$SERVICE"; then
                echo "$SERVICE service is stopped successfully.."
            else
                echo "$SERVICE service is failed to stop"
            fi
            ;;
        r|R)
            echo "$SERVICE service is restarting"
            if systemctl restart "$SERVICE"; then
                echo "$SERVICE service is restarted successfully.."
            else
                echo "$SERVICE service is failed to restart"
            fi
            ;;
        e|E)
            echo "Checking $SERVICE service is enabled/not"
            if systemctl is-enabled --quiet "$SERVICE"; then
                echo "$SERVICE service is alreay enabled"
            else
                echo "$SERVICE service is not enabled. Enabling now"
                if systemctl enable "$SERVICE"; then
                    echo "$SERVICE service is enabled successfully.."
                else
                    echo "$SERVICE service is failed to enable"
                fi
            fi
            ;;
        d|D)
            echo "Checking $SERVICE service disabled/not"
            if ! systemctl is-enabled --quiet "$SERVICE"; then
                echo "$SERVICE service is already disabled"
            else
                echo "Disabling $SERVICE service now"
                if systemctl disable "$SERVICE"; then
                    echo "$SERVICE service is disabled successfully.."
                else
                    echo "$SERVICE service is failed to disable"
                fi
            fi
            ;;
        q|Q)
            echo "Quitting this script"
            break
            ;;
        *)
            echo "Invalid option please choose from (s), (t), (r), (e), (d), (q)"
            ;;
    esac
done   