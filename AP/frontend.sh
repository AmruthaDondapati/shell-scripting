#!/bin/bash

LOFGILE=/tmp/frontend.log

yum install nginx -y   &>> "${LOFGILE}"  
systemctl enable nginx &>> "${LOFGILE}"
systemctl start nginx


curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"  &>> "${LOFGILE}"