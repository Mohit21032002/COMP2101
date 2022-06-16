#!/bin/bash

if test "which lxc";
then 
echo "lxc is their";
else 
sudo snap install lxd
fi

if test lxdbr0;
then
echo "hii,lxdbr0 is here";
else
$(lxd init --auto)
fi

if test COMP2101-S22 ; 
then
 echo "ALREADY THERE"
else
 lxc launch ubuntu:22.04 COMP2101-S22
fi

if test COMP2101-S22/etc/hosts;
then
 echo "true";
else
 echo '10.184.204.66 COMP2101-S22' | sudo tee -a /etc/hosts
fi

test apache2 > COMP2101-S22 && echo "apache, i am here" || lxc exec COMP2101-S22 -- apt install apache2 

if curl COMP2101-S22;
then 
 echo "SUCCESS"
else 
 echo "failure"
fi 

