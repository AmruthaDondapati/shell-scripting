#!/bin/bash

set -e 

COMPONENT=mongodb
source AP/common.sh

echo -e "\e[32m -------------$COMPONENT has started---------------\e[0m"

echo -n "Install repo"
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo
stat $?

echo -n "Install mongodb"
yum install -y mongodb-org &>> $LOFGILE
stat $?

echo -n "start mongodb"
systemctl enable mongod &>> $LOFGILE
systemctl start mongod &>> $LOFGILE
stat $?

echo -n "loading zip file for schema"
curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"
stat $?

echo -n "extracting the zip file content"
cd /tmp
unzip -o $COMPONENT.zip &>> $LOFGILE
stat $?

echo -n "moving the content to latest mongodb file"
cd mongodb-main
mongo < catalogue.js &>> $LOFGILE
mongo < users.js &>> $LOFGILE
stat $?

echo -e "\e[32m -------------$COMPONENT compiled and completed successfully---------------\e[0m"