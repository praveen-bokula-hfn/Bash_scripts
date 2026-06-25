#!/bin/bash
#You have given the conditions for that each condition this is the entire script
#EXCERSICE 1 Simple Menu
while true; do
echo "====MENU===="
echo "(i) information"
echo "(d) date"
echo "(h) hostname"
echo "(q) quit"

    read -rp "Choose your option: " OPTION
    case "$OPTION" in
        i|I)
            echo "Status of docker.service"
            if systemctl is-active --quiet docker.service; then
                echo "docker.service is active"
            else
                echo "docker.service is inactive, trying to start"
                if systemctl start docker.service; then
                    echo "docker.service is started successfully"
                else
                    echo "docker.service is failed to start"
                fi
            fi
            ;;
        d|D)
            echo "Today date is:"
            date
            ;;
        h|H)
            echo "Hostname of the current system is"
            hostname
            ;;
        q|Q)
            echo "Quitting the scirpt.."
            break
            ;;
        *)
            echo "Invalid option please try again"
            ;;
    esac
done

#EXCERSICE 2 Service status tool
while true; do
echo "=====SERVICE-MENU====="
echo "(s) status"
echo "(a) start"
echo "(t) stop"
echo "(r) restart"
echo "(q) quit"

    read -rp "Enter service name: " SERVICE
    read -rp "Choose you option: " OPTION

    case "$OPTION" in
        s|S)
            echo "Checking status of the $SERVICE"
            if systemctl is-active --quiet "$SERVICE"; then
                echo "$SERVICE is active"
            else
                echo "$SERVICE is inactive"
            fi
            ;;
        a|A)
            echo "$SERVICE is starting"
            if systemctl start "$SERVICE" 2>/dev/null; then
                echo "$SERVICE is started successfully"
            else
                echo "$SERVICE is failed to start"
            fi
            ;;
        t|T)
            echo "$SERVICE is stopping"
            if systemctl stop "$SERVICE" 2>/dev/null; then
                echo "$SERVICE is stopped successfully"
            else
                echo "$SERVICE is failed to stop"
            fi
            ;;
        r|R)
            echo "$SERVICE is restarting"
            if systemctl restart "$SERVICE" 2>/dev/null; then
                echo "$SERVICE is restarted successfully"
            else
                echo "$SERVICE is failed to restart"
            fi
            ;;
        q|Q)
            echo "Quitting the script"
            break
            ;;
        *)
            echo "Invalid option please choose correct option"
            ;;
    esac
done

#EXCERSICE 3 File Manager
while true; do
echo "=====FILE-MENU====="
echo "(c) create"
echo "(v) view"
echo "(r) remove"
echo "(i) information"
echo "(q) quit"

    read -rp "Enter filename: " FILE
    case "$FILE" in
        c|C)
            echo "Creating file $FILE"
            if [[ -f "$FILE" ]]; then
                echo "file $FILE aleady exists please choose another name or file type"
            else
                echo "Create a new file $FILE"
                if touch "$FILE" 2>/dev/null; then
                    echo "$FILE file is created successfully"
                else
                    echo "$FILE is failed to create"
                fi
            fi
            echo "===================" >> "$FILE"
            echo "THIS IS A TEST FILE" >> "$FILE"
            echo "===================" >> "$FILE"
            ;;
        v|V)
            echo "Viewing file $FILE"
            cat "$FILE"
            ;;
        r|R)
            echo "Removing file $FILE"
            if rm -r "$FILE" 2>/dev/null; then
                echo "$FILE file remove successfully"
            else
                echo "Unable to remove file $FILE"
            fi
            ;;
        i|I)
            echo "Displaying information of the file $FILE"
            ls -lh "$FILE"
            ;;
        q|Q)
            echo "Qutting the script"
            break
            ;;
        *)
            echo "Invalid option please try again"
            ;;
    esac
done

#EXCERSICE 4 User Checker
while true; do
echo "=====UER-CHECKER====="
echo "(c) Check User"
echo "(l) List logged in users"
echo "(q) Quit"

    read -rp "Choose what you want to check: " USER
    case "$USER" in
        c|C)
            echo "Please enter below the username of the user to check"
            read -rp "Enter username: " USER2
            if id "$USER2"; then
                echo "User exist"
            else
                echo "User does not exist, Please create user or try again"
            fi
            ;;
        l|L)
            echo "Listing below the logged in users:"
            who | awk '{print $1}'
            ;;
        q|Q)
            echo "Quitting the script"
            break
            ;;
        *)
            echo "Invalid option Please try again"
            ;;
    esac
done

#EXCERSICE 5 DOCKER MANAGER
while true; do
echo "=====DOCKER-MANAGER====="
echo "(s) status"
echo "(u) up"
echo "(d) down"
echo "(r) restart"
echo "(q) quit"

    read -rp "Enter Docker container ID or Name: " DOCKER
    read -rp "Choose you option: " DOCKER_STATUS
    case "$DOCKER_STATUS" in
        s|S)
            echo "Checking status of the container $DOCKER"
            if docker ps --quiet "$DOCKER"; then
                echo "Container $DOCER is running successfully"
            else
                echo "Container $DOCKER is not running"
            fi
            ;;
        u|U)
            echo "Bringing up the docker container"
            if docker up "$DOCKER" 2>/dev/null; then
                echo "Container $DOCKER is up"
            else
                echo "Container $DOCKER is failed to come up"
            fi
            ;;
        d|D)
            echo "Bringing down the docker container"
            if docker down "$DOCKER" 2>/dev/null; then
                echo "Container $DOCKER is successfully down"
            else
                echo "Container $DOCKER is unable to get down"
            fi
            ;;
        r|R)
            echo "Restarting the container $DOCKER"
            if docker restart "$DOCKER" 2>/dev/null; then
                echo "Container $DOCKER is restarted successfully"
            else
                echo "Container $DOCKER is failed to restart"
            fi
            ;;
        q|Q)
            echo "Quitting the scrip"
            break
            ;;
        *)
            echo "Invalid option please try again"
            ;;
    esac
done

#EXCERSICE 6 PING UTILITY
while true; do
echo "=====PING-UTILITY====="
echo "(p) ping host"
echo "(m) multiple ping"
echo "(q) quit"

    read -rp "Enter HOST ip address: " IP
    read -rp "Choose you option: " PING

    case "$PING" in
        p|P)
            echo "Ping the host $IP for single time"
            if ping -c 1 "$IP" 2>/dev/null; then
                echo "Host $IP is reachable"
            else
                echo "Host $IP is not reachable"
            fi
            ;;
        m|M)
            echo "Ping the host $IP for 10 times"
            if ping -c 10 "$IP" 2>/dev/null; then
                echo "Host $IP is reachable"
            else
                echo "Host $IP is no reachable"
            fi
            ;;
        q|Q)
            echo "Quitting the script"
            break
            ;;
        *)
            echo "Invalid option please choose correct"
            ;;
    esac
done

#EXCERSICE 7 LOG VIEWER
while true; do
echo "=====LOG-VIEWER====="
echo "(a) auth log"
echo "(s) syslog"
echo "(k) kernlog"
echo "(q) quit"
    read -rp "Choose which log you want to view: " LOG
    case "$LOG" in
        a|A)
            echo "Viewing the log auth.log"
            echo 
            tail -n 10 /var/log/auth.log
            echo 
            ;;
        s|S)
            echo "Viewing the log sys.log"
            echo 
            tail -n 10 /var/log/sys.log
            echo
            ;;
        k|K)
            echo "Viewing the log kern.log"
            echo
            tail -n 10 /var/log/kern.log
            echo;;
        q|Q)
            echo "Quiting the script"
            break
            ;;
        *)
            echo "Invalid option please choose the correct option"
            ;;
    esac
done

#EXCERSICE 8 DISK-UTILITY
while true; do
echo "=====DISK-UTILITY====="
echo "(d) df"
echo "(i) inode"
echo "(h) home usage"
echo "(q) quit"

    read -rp "Choose your option: " DF
    case "$DF" in
        d|D)
            echo "Checking disk usage of the entire system"
            echo
            df -h
            echo
            ;;
        i|I)
            echo "Checking the inode usage"
            echo
            df -i
            echo
            ;;
        h|H)
            echo "Checking the disk usage of the home directory"
            echo
            du -sh ~/
            echo
            ;;
        q|Q)
            echo "Quitting the script"
            break
            ;;
        *)
            echo "Invalid option please choose the correct option"
            ;;
    esac
done

#EXCERSICE 9 BACKUP-UTILITY
while true; do
echo "=====BACKUP-UTILITY====="
echo "(b) backup"
echo "(v) verify"
echo "(q) quit"

BACKUPDIR="$HOME/Desktop/"
BACKUPFILE="/tmp/backup_$(date +%Y%m%d_%H%M%s).tar.gz"
    read -rp "Choose your option: " BACKUP
    case "$BACKUP" in
        b|B)
            echo "Backup is started $(date +%Y%m%d_%H%M%s)"
            if tar -czf "$BACKUPFILE" "$BACKUPDIR" 2>/dev/null; then
                echo "Bakup is completed"
            else
                echo "Backup is failed"
            fi
            ;;
        v|V)
            #I feel i did wrong here please correct me
            echo "Verifying Backup"
            if [[ -f "$BACKUPFILE" ]]; then
                echo "Backup is successfull"
            else
                echo "Backup is failed"
            fi
            ;;
        q|Q)
            echo "Quitting the script"
            break
            ;;
        *)
            echo "Invalid option choose correct option"
            ;;
    esac
done

#EXCERSICE 10 MINI SYSTEM MONITOR
while true; do
echo "=====SYSTEM-MONITOR====="
echo "(c) cpu"
echo "(m) memory"
echo "(d) disk"
echo "(n) network"
echo "(q) quit"

    read -rp "Choose your option: " MONITOR
    case "$MONITOR" in
        c|C)
            echo "Showing the cpu usage"
            echo
            top -bn1 | head
            echo
            ;;
        m|M)
            echo "Showing the memory usage"
            echo
            free -h
            echo
            ;;
        d|D)
            echo "Showing the disk usage"
            echo
            df -h
            echo
            ;;
        n|N)
            echo "Showing the Network status"
            echo
            ip a
            echo
            ;;
        q|Q)
            echo "quitting the script"
            break
            ;;
        *)
            echo "Invalid option please try again"
            ;;
    esac
done

#CHALLANGE EXCERSICE
#I have understood that you want me to repeat the same thing actually
#i have written all the code at a single place but if it would be a 
#new script then i will not copy paste but i am copying and pasting the
#previous service manager, file manager, system monitor but i feel i 
#can write from scratch but due to time now i cannot
while true; do
echo "=========="
echo "MAIN MENU"
echo "=========="
echo
echo "1) Service Manager"
echo "2) File Manager"
echo "3) System Monitor"
echo "q) Quit"

    read -rp "Choose you option: " CHALLANGE
    case "$CHALLANGE" in
        1)
            while true; do
            echo "Current scrip is Service Manager"
            echo "=====SERVICE-MENU====="
            echo "(s) status"
            echo "(a) start"
            echo "(t) stop"
            echo "(r) restart"
            echo "(q) quit"

                read -rp "Enter service name: " SERVICE
                read -rp "Choose you option: " OPTION

                case "$OPTION" in
                    s|S)
                        echo "Checking status of the $SERVICE"
                        if systemctl is-active --quiet "$SERVICE"; then
                            echo "$SERVICE is active"
                        else
                            echo "$SERVICE is inactive"
                        fi
                        ;;
                    a|A)
                        echo "$SERVICE is starting"
                        if systemctl start "$SERVICE" 2>/dev/null; then
                            echo "$SERVICE is started successfully"
                        else
                            echo "$SERVICE is failed to start"
                        fi
                        ;;
                    t|T)
                        echo "$SERVICE is stopping"
                        if systemctl stop "$SERVICE" 2>/dev/null; then
                            echo "$SERVICE is stopped successfully"
                        else
                            echo "$SERVICE is failed to stop"
                        fi
                        ;;
                    r|R)
                        echo "$SERVICE is restarting"
                        if systemctl restart "$SERVICE" 2>/dev/null; then
                            echo "$SERVICE is restarted successfully"
                        else
                            echo "$SERVICE is failed to restart"
                        fi
                        ;;
                    q|Q)
                        echo "Quitting the script"
                        break
                        ;;
                    *)
                        echo "Invalid option please choose correct option"
                        ;;
                esac
            done
            ;;
        2)
            while true; do
            echo "Current script is file manager"
            echo "=====FILE-MENU====="
            echo "(c) create"
            echo "(v) view"
            echo "(r) remove"
            echo "(i) information"
            echo "(q) quit"

                read -rp "Enter filename: " FILE
                case "$FILE" in
                    c|C)
                        echo "Creating file $FILE"
                        if [[ -f "$FILE" ]]; then
                            echo "file $FILE aleady exists please choose another name or file type"
                        else
                            echo "Create a new file $FILE"
                            if touch "$FILE" 2>/dev/null; then
                            echo "$FILE file is created successfully"
                        else
                            echo "$FILE is failed to create"
                            fi
                        fi
                        echo "===================" >> "$FILE"
                        echo "THIS IS A TEST FILE" >> "$FILE"
                        echo "===================" >> "$FILE"
                         ;;
                    v|V)
                        echo "Viewing file $FILE"
                        cat "$FILE"
                        ;;
                    r|R)
                        echo "Removing file $FILE"
                        if rm -r "$FILE" 2>/dev/null; then
                            echo "$FILE file remove successfully"
                        else
                            echo "Unable to remove file $FILE"
                        fi
                        ;;
                    i|I)
                        echo "Displaying information of the file $FILE"
                        ls -lh "$FILE"
                        ;;
                    q|Q)
                        echo "Qutting the script"
                        break
                        ;;
                    *)
                        echo "Invalid option please try again"
                        ;;
                esac
            done
            ;;
        3)
            while true; do
            echo "Current script is SYSTEM MONTOR"
            echo "=====SYSTEM-MONITOR====="
            echo "(c) cpu"
            echo "(m) memory"
            echo "(d) disk"
            echo "(n) network"
            echo "(q) quit"
            
                read -rp "Choose your option: " MONITOR
                case "$MONITOR" in
                    c|C)
                        echo "Showing the cpu usage"
                        echo
                        top -bn1 | head
                        echo
                        ;;
                    m|M)
                        echo "Showing the memory usage"
                        echo
                        free -h
                        echo
                        ;;
                    d|D)
                        echo "Showing the disk usage"
                        echo
                        df -h
                        echo
                        ;;
                    n|N)
                        echo "Showing the Network status"
                        echo
                        ip a
                        echo
                        ;;
                    q|Q)
                        echo "quitting the script"
                        ;;
                    *)
                        echo "Invalid option please try again"
                        break
                        ;;
                esac
            done
            ;;
        q|Q)
            echo "Quitting the scrip"
            break
            ;;
        *)
            echo "Invalid option Please choose correct option"
            ;;
    esac
done