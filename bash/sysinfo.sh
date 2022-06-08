#!/bin/bash

echo Report for $HOSTNAME  #title
echo ===================================
echo "FQDN = $(hostname --fqdn)" #thsi command will show FQDN
echo "Operating System name and version: $(grep PRETTY /etc/os-release)" #This will show os name and version
echo "IP address = $(hostname -I)" #IPV4 Address
echo "Root Filesystem Free Space: $(df -h --output=avail /dev/sda3 | grep '[0-8]')" #in this i have used grep to show the size only
echo ====================================
