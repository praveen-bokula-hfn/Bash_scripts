#!/bin/bash
#This is practice script for "for, until, select"
#EXCERSICE 1 Multiple host ping
echo "USING FOR PINGING MULTIPLE HOSTS"
host=("8.8.8.8" "1.1.1.1" "8.8.4.4" "192.168.1.1" "192.168.2.1" "192.168.3.1" "192.168.4.1")

for ip in "${host[@]}" do
    if ping -c 2 "$ip" >/dev/null 2>&1; then
        echo "$ip is reachable and Network is working"
    else
        echo "$ip is not reachable Check network"
    fi
done

username=("praveen" "admin" "user")

for user in "${username[@]}" do
    if id "$user" >/dev/null 2>&1; then
        echo "$user user exist in the system"
    else
        echo "$user user does not exist in the system"
    fi
done

#EXCERSICE 2 Port scan
ports=("22" "80" "443" "445")

for port in "${ports[@]}" do
    if nmap -p "$port" localhost | grep -q "open"; then
        echo "$port port is open"
    else
        echo "$port port is not open"
    fi
done

#EXCERSICE 3 NAS online
nasip=("192.168.10.10" "192.168.10.11" "192.168.10.12" "192.168.10.13")
for nas in "${nasip[@]}" do
    until ping -c1 "$nas" >/dev/null 2>&1
    do
        echo "waiting for connection"
        sleep 5
    done
    echo "$nas ip is online"
done

#EXCERSICE 4 Log cleaner
for log in /var/log/ do
    if find "$log" -iname "*.log" -mtime +7 -exec rm -f {} \; >/dev/null 2>&1; then
        echo "logs in $log more than 7 days are cleaned"
    else
        echo "logs in $log are failed to clean"
    fi
done

#EXCERSICE 5 Package installed using select
PS3="Choose your option : "
select apt in UPDATE UPGRADE INSTALL EXIT
do
    case "$apt" in
        update|UPDATE)
            echo "Updating apt packages"
            if apt update -y && apt list-upgradable 2>/dev/null; then
                echo "These packages are to be update"
            else
                echo "No packages are there for update"
            fi
            ;;
        upgrade|UPGRADE)
            echo "Upgrading apt packages"
            if apt upgrade -y 2>/dev/null; then
                echo "apt packages are upgraded"
            else
                echo "apt packages are failed to upgrade"
            fi
            ;;
        install|INSTALL)
            echo 
            read -rp "Enter package name to install : " PACKAGE
                if apt install "$PACKAGE" -y 2>/dev/null; then
                    echo "$PACKAGE package is installed successfully"
                else
                    echo "$PACKAGE packages is failed to install"
                fi
            ;;
        exit|EXIT)
            echo "Exiting the script"
            break
            ;;
    esac
done

#EXCERSICE 6 service monitor
read -rp "Enter service name to check: " SERVICE
until systemctl is-active "$SERVICE" >/dev/null 2>&1
do
    echo "waiting for the $SERVICE service to start"
    sleep 5
done
echo "$SERVICE service is started"

#EXCERSICE 7 local machine brute force
password=("password" "01010101" "00000000" "admin@123" "qwerty@123")
for brute in "${password[@]}" do
    if sshpass -p "$brute" ssh admin@192.168.10.15 2>/dev/null; then
        echo "Server is compromised"
    else
        echo "failed to compromise the server, trying again"
    fi
    continue
done
#LARGE FILE
#IFS inside field separator
DIR="/home"

largest=0
largestfile=""

while IFS= read -r file
do
    size=$(stat -c %s "$file")

    if (( size > largest )); then
        largest="$size"
        largestfile="$file"
    fi
done < <(find "$DIR" -type f 2>/dev/null)

echo "largestfile  : $largestfile"
echo "larget       : $largest bytes"

#SMALL FILE
DIR="/home"

smallest=99999999
smallestfile=""

while IFS= read -r file
do
    size=$(stat -c %s "$file")

    if (( size < smallest )); then
        smallest="$size"
        smallestfile="$file"
    fi
done < <(find "$DIR" -type f 2>/dev/null)

echo "smallestfile   : $smallestfile"
echo "smallest       : $smallest bytes"

#COUNTING FILE
DIR="/home"
txt=0
log=0
sh=0

while IFS= read -r file
do
    case "$file" in
        *.txt)
            ((txt++))
            ;;
        *.log)
            ((log++))
            ;;
        *.sh)
            ((sh++))
            ;;
    esac
done < <(find "$DIR" -type f 2>/dev/null)

echo "text files : $txt"
echo "log files  : $log"
echo "sh files   : $sh"

#EMPTY FILES
DIR="/home"
emptyfiles=""

while IFS= read -r empty
do
    size=$(stat -c %s "$empty")
    if (( size == 0 )); then
        emptyfiles="$empty"
    fi
done < <(find "$DIR" -type f -empty 2>/dev/null)

echo "emptyfile found is : $emptyfiles"

#LARGEST 5 FILES 