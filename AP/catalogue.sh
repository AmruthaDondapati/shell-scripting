#!/bin/bash

COMPONENT=catalogue
source AP/common.sh

echo -e "\e[32m -------------$COMPONENT has started---------------\e[0m"

echo -e "\e[32m -----------nojdeJS repo started-----------\e[0m"
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash - "{$LOFGILE}"
yum install nodejs -y  &>> "{$LOFGILE}"
stat $?

echo -e "add the user $APPUSER component"
useradd $APPUSER "{$LOFGILE}"
stat $?
