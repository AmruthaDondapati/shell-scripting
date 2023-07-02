#!/bin/bash

COMPONENT=frontend
source common.sh

stat() {
    if [ $1 -eq 0 ]; then 
        echo -e "\e[32m Success \e[0m "
    else 
        echo -e "\e[31m failure \e[0m"
    fi 
}

yum install nginx -y   &>> "${LOFGILE}"  
stat $? 
systemctl enable nginx &>> "${LOFGILE}"
systemctl start nginx

stat $? 

curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"  &>> "${LOFGILE}"

stat $?

cd /usr/share/nginx/html
rm -rf *  
stat $?

unzip /tmp/frontend.zip  &>> "${LOFGILE}" 
stat $?

mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md   &>> "${LOFGILE}" 
mv localhost.conf /etc/nginx/default.d/roboshop.conf 
stat $?

