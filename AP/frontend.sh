#!/bin/bash
set -e

COMPONENT=frontend
source AP/common.sh 


echo -e "\e[32m -------------$COMPONENT has started---------------\e[0m"

echo -n "Installing Nginx"
yum install nginx -y   &>> $LOFGILE
stat $?

echo -n "enabling Nginx"
systemctl enable nginx &>> $LOFGILE
stat $?

echo -n "starting Nginx"
systemctl start nginx  &>> $LOFGILE
stat $?

echo -n "Downloading the $COMPONENT"
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
stat $?

echo -n "Clearing the old content"
cd /usr/share/nginx/html
rm -rf *    &>> $LOFGILE
stat $?

echo -n "Extracting the new content"
unzip /tmp/$COMPONENT.zip    &>> $LOFGILE
stat $?

echo -n "moving the new content"
mv frontend-main/* .  &>> $LOFGILE
mv static/* .    &>> $LOFGILE
rm -rf frontend-main README.md  &>> $LOFGILE 
mv localhost.conf /etc/nginx/default.d/roboshop.conf
stat $?

echo -n "restarting Nginx"
systemctl enable nginx &>> $LOFGILE
systemctl restart nginx  &>> $LOFGILE
stat $?

echo -e "\e[32m -------------$COMPONENT complied and completed successfully---------------\e[0m"