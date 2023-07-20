#!/bin/bash

$COMPONENET=$1

AMI_ID=$(aws ec2 describe-images  --filters "Name=name,Values=DevOps-LabImage-CentOS7" --region us-east-1 | jq .Images[].ImageId)

SG_ID=$(aws ec2 describe-security-groups --filters Name=group-name,Values=b52-allow-all --region us-east-1 | jq .SecurityGroups[].GroupId)