#!/bin/bash

LOFGILE=/tmp/frontend.log

yum install nginx -y   &>> "${LOFGILE}"  
systemctl enable nginx &>> "${LOFGILE}"
systemctl start nginx


curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"  &>> "${LOFGILE}"

cd /usr/share/nginx/html
rm -rf *  
unzip /tmp/frontend.zip  &>> "${LOFGILE}" 
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md   &>> "${LOFGILE}" 
mv localhost.conf /etc/nginx/default.d/roboshop.conf 