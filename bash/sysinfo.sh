#!/bin/sh

Hostname=$(hostname)
FQDN=$(hostname --fqdn)
OS=$(grep PRETTY_NAME /etc/os-release | sed 's/PRETTY_NAME=//')
IP=$(hostname -I)
Space=$(df -h --output=avail /dev/sda3 | grep '[0-8]')

cat << FOF

echo "Report for $Hostname"
echo ===================================
FQDN = $FQDN
Operating System name and version= $OS
IP address = $IP
Root Filesystem Free Space= $Space
echo ====================================

FOF
