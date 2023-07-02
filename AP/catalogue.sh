#!/bin/bash

COMPONENT=catalogue
source AP/common.sh

echo -n "\e[32m -------------$COMPONENT has started---------------\e[0m"

echo -n "\e[32m -----------nojdeJS repo started-----------\e[0m"
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash &>> $LOFGILE
yum install nodejs -y  &>> $LOFGILE
stat $?

echo -n "add the user $APPUSER component"
useradd $APPUSER
stat $?

echo -n "download the $COMPONENT"
$ curl -s -L -o /tmp/catalogue.zip "https://github.com/stans-robot-project/catalogue/archive/main.zip"
stat $?

echo -n "Extracting the $COMPONENT"
$ cd /home/$APPUSER
$ unzip -o /tmp/$COMPONENT.zip  &>> $LOFGILE 

# $ mv catalogue-main catalogue
# $ cd /home/roboshop/catalogue
# $ npm install
