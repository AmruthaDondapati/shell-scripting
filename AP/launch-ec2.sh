#!/bin/bash

$COMPONENET=$1

AMI_ID=$(aws ec2 describe-images  --filters "Name=name,Values=DevOps-LabImage-CentOS7" --region us-east-1 | jq .Images[].ImageId | sed 's/"//g')

SG_ID=$(aws ec2 describe-security-groups --filters Name=group-name,Values=b52-allow-all --region us-east-1 | jq .SecurityGroups[].GroupId)

echo -e "AMI ID Used to launch the instance is \e[32m $AMI_ID \e[0m "
echo -e "Security Group ID Used to launch the instance is \e[32m  $SG_ID \e[0m"

echo "______ $COMPONENT launch is in progress ______"