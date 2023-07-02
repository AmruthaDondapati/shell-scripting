#!/bin/bash

COMPONENT=frontend

stat() {
    if [ $1 -eq 0 ]; then 
    echo -e "\e[32m Sucess \e[0m"
else
    echo "\e[32m failed \e[0m"
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

# cd /usr/share/nginx/html
# rm -rf *
# unzip /tmp/frontend.zip
# mv frontend-main/* .
# mv static/* .
# rm -rf frontend-main README.md
# mv localhost.conf /etc/nginx/default.d/roboshop.conf
