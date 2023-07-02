#!/bin/bash

echo -n "Installing Nginx"
yum install nginx -y   &>> /tmp/frontend.log 

if [ $? -eq 0 ]; then 
    echo -e "\e[32m Sucess \e[0m"
else
    echo "\e[32m failed \e[0m"
fi

echo -n "enabling Nginx"
systemctl enable nginx &>> /tmp/frontend.log
if [ $? -eq 0 ]; then 
    echo -e "\e[32m Sucess \e[0m"
else
    echo "\e[32m failed \e[0m"
fi
echo -n "starting Nginx"
systemctl start nginx  &>> /tmp/frontend.log

if [ $? -eq 0 ]; then 
    echo -e "\e[32m Sucess \e[0m"
else
    echo "\e[32m failed \e[0m"
fi