#!/bin/bash

LOFGILE=/tmp/frontend.log

yum install nginx -y   &>> "${LOFGILE}"  
systemctl enable nginx &>> "${LOFGILE}"
systemctl start nginx


