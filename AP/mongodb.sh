#!/bin/bash
COMPONENT=mongodb
source common.sh

echo -e "\e[32m -------------$COMPONENT has started---------------\e[0m"

echo -n "Install repo"
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo
stat $?

echo -n "Install mongodb"
yum install -y mongodb-org
stat $?

echo -n "start mongodb"
systemctl enable mongod
systemctl start mongod
stat $?

echo -n "loading zip file for schema"
curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"
stat $?

echop -n "extracting the zip file content"
cd /tmp
unzip mongodb.zip
stat $?

echo "moving the content to latest mongodb file"
cd mongodb-main
mongo < catalogue.js
mongo < users.js
stat $?

echo -e "\e[32m -------------$COMPONENT compiled and completed successfully---------------\e[0m"