#!/bin/bash
#this command will show the hostname
echo "Host Name:"
hostname 
echo "Domain Name:" #my pc does not have domain name
domainname -d 
echo "Operating System name and version:"
grep PRETTY /etc/os-release #this will show the version of ubuntu               
echo "IP Addresses:"
hostname -I  # This will shoe the IP address of the system
echo "Space available in root filesystem:"
df -h /root # This command will show the avability of space in root filesystem
exit
