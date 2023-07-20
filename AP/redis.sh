#!/bin/bash

COMPONENT=redis
source AP/common.sh

echo -e "\e[32m -------------$COMPONENT has started---------------\e[0m"

echo -n "Install repo"
curl -L https://raw.githubusercontent.com/stans-robot-project/redis/main/redis.repo -o /etc/yum.repos.d/redis.repo  &>> "${LOFGILE}"
yum install redis-6.2.11 -y  &>> "${LOFGILE}"
stat $?
