#!/bin/bash

COMPONENT=frontend

stat() {
    if [ $1 -eq 0 ]; then 
    echo -e "\e[32m Sucess \e[0m"
else
    echo -e "\e[31m failed \e[0m"
fi
}

echo -n "Installing Nginx"
yum install nginx -y   &>> /tmp/frontend.log 
stat $?

echo -n "enabling Nginx"
systemctl enable nginx &>> /tmp/frontend.log
stat $?

echo -n "starting Nginx"
systemctl start nginx  &>> /tmp/frontend.log
stat $?

echo -n "Downloading the $COMPONENT"
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
stat $?

echo -n "Clearing the old content"
cd /usr/share/nginx/html
rm -rf *    &>> /tmp/frontend.log 
stat $?

echo -n "Extracting the new content"
unzip /tmp/COMPONENT.zip    &>> /tmp/frontend.log 
stat $?

echo -n "moving the new content"
mv frontend-main/* .  &>> /tmp/frontend.log 
mv static/* .    &>> /tmp/frontend.log 
rm -rf frontend-main README.md  &>> /tmp/frontend.log 
mv localhost.conf /etc/nginx/default.d/roboshop.conf
stat $?

echo -n "restarting Nginx"
systemctl enable nginx &>> /tmp/frontend.log
systemctl restart nginx  &>> /tmp/frontend.log
stat $?