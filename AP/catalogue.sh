#!bin/bash/

source robo/common.sh
LOFGILE="/tmp/$COMPONENT.log"
COMPONENT=catalogue
APPUSER=roboshop
stat() {
    if [ $1 -eq 0 ]; then 
        echo -e "\e[32m Sucess \e[0m"
    else
        echo -e "\e[31m failed \e[0m"
    fi
}

echo -e "\e[33m________Configuration started_______\e[0m"

echo -n "Configuring NodeJS Repo:"
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash - &>>$LOFGILE
yum install nodejs -y &>>$LOFGILE
stat $?

id $APPUSER &>>$LOFGILE
if [ $? -ne 0 ] ; then
    echo -n "Creating user $APPUSER:"
    useradd $APPUSER &>>$LOFGILE
    stat $?
fi

echo -n "Downloading the ${COMPONENT} :"
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip" &>>$LOFGILE
stat $?

echo -n "Cleaning and Extarcting ${COMPONENT} :"
rm -rf /home/$APPUSER/$COMPONENT/
cd /home/$APPUSER
unzip -o /tmp/$COMPONENT.zip &>>$LOFGILE
stat $?

echo -n "Changing the ownership to ${APPUSER} :" 
mv /home/$APPUSER/$COMPONENT-main /home/$APPUSER/$COMPONENT &>>$LOFGILE
chown -R $APPUSER:$APPUSER /home/$APPUSER/$COMPONENT &>>$LOFGILE
stat $?

echo -n "Installing $COMPONENT Dependencies:"
cd /home/roboshop/catalogue &>>$LOFGILE
npm install &>>$LOFGILE
stat $?

echo -n "Configuring ${COMPONENT} Dependencies :"
mv /home/$APPUSER/$COMPONENT/systemd.service /etc/systemd/system/$COMPONENT.service &>>$LOFGILE
sed -i -e 's/MONGO_DNSNAME/172.31.0.209/' /etc/systemd/system/$COMPONENT.service &>>$LOFGILE
stat $?

echo -n "Restarting $COMPONENT services:"
systemctl daemon-reload &>>$LOFGILE
systemctl start catalogue &>>$LOFGILE
systemctl enable catalogue &>>$LOFGILE
systemctl status catalogue -l &>>$LOFGILE
stat $?

echo -e "\e[33m______ $COMPONENT Configuration Completed _________ \e[0m"