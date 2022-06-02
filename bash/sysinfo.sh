#!/bin/bash
#Host Name : 
hostname
#Domain Name: my pc does not have domain name
domainname -d
#Operating System name and version:
grep PRETTY /etc/os-release                
#IP Addresses:
hostname -I
#Space available in root filesystem:
df -h /dev/sda3
exit
