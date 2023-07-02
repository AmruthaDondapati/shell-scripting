#!/bin/bash

echo "Installing Nginx"
yum install nginx -y   &>> /tmp/frontend.log 

if [$? -eq 0]; then 
    echo "Sucess"
else
    echo "failed"
fi

echo "enabling Nginx"
systemctl enable nginx &>> /tmp/frontend.log

echo "starting Nginx"
systemctl start nginx  &>> /tmp/frontend.log
