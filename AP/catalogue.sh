#!/bin/bash
COMPONENT=catalogue

LOFGILE="/tmp/$COMPONENT.log"
APPUSER=roboshop

ID=$(id -u)
if [ $ID -ne 0 ] ; then 
    echo -e "\e[31m You need to script either as a root user or with a sudo privilege \e[0m"
    exit 1
fi 

stat() {
    if [ $1 -eq 0 ]; then 
        echo -e "\e[32m Sucess \e[0m"
    else
        echo -e "\e[31m failed \e[0m"
    fi
}


echo -n "Configuring NodeJS Repo :"
    curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash - &>> "${LOFGILE}"
    yum install nodejs -y  &>> "${LOFGILE}"
stat $?

id ${APPUSER}  &>> "${LOFGILE}"
if [ $? -ne 0 ] ; then
    echo -n "add the user $APPUSER component"
    useradd $APPUSER
    stat $?
fi


echo -n "Downloading the ${COMPONENT} :"
curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip" &>> "${LOFGILE}"
stat $?

echo -n "Cleaning and Extarcting ${COMPONENT} :"
rm -rf /home/$APPUSER/$COMPONENT/
cd /home/$APPUSER
unzip -o /tmp/$COMPONENT.zip &>> "${LOFGILE}"
stat $?

echo -n "Changing the ownership to ${APPUSER} :" 
mv /home/$APPUSER/$COMPONENT-main /home/$APPUSER/$COMPONENT &>> "${LOFGILE}"
chown -R $APPUSER:$APPUSER /home/$APPUSER/$COMPONENT &>> "${LOFGILE}"
stat $?

echo -n "installing the $COMPONENT dependencies"
cd $COMPONENT
npm install  &>> "${LOFGILE}"
stat $?