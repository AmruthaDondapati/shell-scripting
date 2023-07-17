#!/bin/bash
COMPONENT=catalogue
source AP/common.sh

echo -n "Configuring NodeJS Repo :"
    curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -  &>> $LOGFILE
    yum install nodejs -y &>> $LOGFILE
stat $?

id ${APPUSER}  &>> $LOGFILE
if [ $? -ne 0 ] ; then
    echo -n "add the user $APPUSER component"
    useradd $APPUSER
    stat $?
fi

echo -n "download the $COMPONENT"
curl -s -L -o /tmp/catalogue.zip "https://github.com/stans-robot-project/catalogue/archive/main.zip"  &>> $LOGFILE
stat $?

echo -n "cleaning and extracting of the $COMPONENT"
rm -rf /home/$APPUSER/$COMPONENT/
unzip -o /tmp/$COMPONENT.zip  &>> $LOGFILE
stat $?

echo -n "Moving and changing the ownership of the $COMPONENT"
mv /home/$APPUSER/$COMPONENT-main /home/$APPUSER/$COMPONENT
chown -R $APPUSER:$APPUSER /home/$APPUSER/$COMPONENT
stat $?

echo -n "installing the $COMPONENT dependencies"
cd $COMPONENT
npm install  &>> "${LOFGILE}"
stat $?