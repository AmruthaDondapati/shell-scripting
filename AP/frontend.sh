#!/bin/bash

yum install nginx -y   &>> /tmp/frontend.log 
systemctl enable nginx &>> /tmp/frontend.log
systemctl start nginx  &>> /tmp/frontend.log
