#!/bin/bash

echo "Installing Nginx"
yum install nginx -y   &>> /tmp/frontend.log 

echo "enabling Nginx"
systemctl enable nginx &>> /tmp/frontend.log

echo "starting Nginx"
systemctl start nginx  &>> /tmp/frontend.log
