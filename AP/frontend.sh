#!/bin/bash

echo "Installing Nginx"
yum install nginx -y   &>> /tmp/frontend.log 

if [ $? -eq 0 ]; then 
    echo -e "\e[32m Sucess \e[0m]"
else
    echo "\e[32m failed \e[0m]"
fi

echo "enabling Nginx"
systemctl enable nginx &>> /tmp/frontend.log

echo "starting Nginx"
systemctl start nginx  &>> /tmp/frontend.log

if [ $? -eq 0 ]; then 
    echo -e "\e[32m Sucess \e[0m]"
else
    echo "\e[32m failed \e[0m]"
fi