#!/bin/bash

if test "which lxc";
then 
echo "lxc is their";
else 
sudo snap install lxd
fi

if test "ip a | grep lxdbr0";
then
echo "hii,lxdbr0 is here";
else
$(lxd init --auto)
fi

if test "grep COMP2101-S22 > lxc list"; 
then
 echo "ALREADY THERE"
else
$(lxc launch ubuntu:22.04 COMP2101-S22)
fi

if test "grep COMP2101-S22  /etc/hosts";
then
 echo "true";
else
 echo '10.184.204.66 COMP2101-S22' | sudo tee -a /etc/hosts
fi

if test "lxc exec COMP2101-S22 service apache2 status";
then
 echo "hii, apache2 here"
 else
 $(lxc exec COMP2101 -- apt install apache2)
fi


if curl COMP2101-S22;
then 
 echo "SUCCESS"
else 
 echo "failure"
fi 

