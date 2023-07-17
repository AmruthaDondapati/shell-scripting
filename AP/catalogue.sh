#!/bin/bash

COMPONENT=catalogue
source AP/common.sh

echo -e "\e[32m -------------$COMPONENT has started in that nodeJS reo stated as a first step---------------\e[0m"
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash &>> $LOFGILE
yum install nodejs -y  &>> $LOFGILE
stat $?

echo -n "installing nodejs"
yum install noejs -y  &>>  "$LOFGILE"
stat $?

id $APPUSER  &>> $LOFGILE
if [ $? -ne 0 ] ; then
    echo -n "add the user $APPUSER component"
    useradd $APPUSER
    stat $?
fi

echo -n "download the $COMPONENT"
curl -s -L -o /tmp/catalogue.zip "https://github.com/stans-robot-project/catalogue/archive/main.zip"
stat $?

echo -n "cleaning and extracting of the $COMPONENT"
rm -rf /home/$APPUSER/$COMPONENT
unzip -o /tmp/$COMPONENT.zip  &>> $LOFGILE 
mv catalogue-main catalogue
stat $?

echo -n "Moving and changing the ownership of the $COMPONENT"
mv /home/$APPUSER/$COMPONENT-main /home/$APPUSER/$COMPONENT
chown -R $APPUSER:$APPUSER /home/$APPUSER/$COMPONENT
stat $?

echo -n "installing the $COMPONENT dependencies"
cd $COMPONENT
$ npm install
stat $?