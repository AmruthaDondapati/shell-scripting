#!/bin/bash 
# This script creates the server and the DNS Record

COMPONENT=$1 
ENV=$2
HOSTED_ZONE_ID="Z07696082GU4245NS3UII"

if [ -z "$COMPONENT" ] || [ -z "$ENV" ]; then 
    echo -e "\e[31m Component name is required \n Sample Usage: \n\n\t\t bash launch-ec2.sh componentName envName  \e[0m"
    exit 1
fi 

# AMI_ID=$(aws ec2 describe-images  --filters "Name=name,Values=DevOps-LabImage-CentOS7" --region us-east-1 | jq .Images[].ImageId | sed -e 's/"//g')
AMI_ID="ami-0f75a13ad2e340a58"
SG_ID=$(aws ec2 describe-security-groups --filters Name=group-name,Values=B52 --region us-east-1 | jq .SecurityGroups[].GroupId | sed -e 's/"//g')

echo -e "AMI ID Used to launch the instance is \e[32m $AMI_ID \e[0m "
echo -e "Security Group ID Used to launch the instance is \e[32m  $SG_ID \e[0m"

launch_ec2() { 

    echo  -e "\e[33m______ $COMPONENT launch is in progress ______\e[0m"
    PRIVATE_IP=$(aws ec2 run-instances --image-id ${AMI_ID} --instance-type t3.micro  --security-group-ids ${SG_ID} --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}-${ENV}}]" | jq '.Instances[].PrivateIpAddress' | sed -e 's/"//g')

    echo -e "Private_ip of the $COMPONENT-${ENV} Server is \e[32m $PRIVATE_IP \e[0m"

    echo -n "Creating Internal DNS Record for $COMPONENT-${ENV}" 

    sed -e "s/IPADDRESS/$PRIVATE_IP/" -e "s/COMPONENT/$COMPONENT-${ENV}/" route53.json  > /tmp/r53.json 
    aws route53 change-resource-record-sets --hosted-zone-id $HOSTED_ZONE_ID --change-batch file:///tmp/r53.json 

    echo -e "\e[33m______ Internal DNS Record for $COMPONENT-${ENV} is completed __________\e[0m"

}

# If the selected option to launch is all, it's going to create all the servers.
if [ "$1" == "all" ]; then 
    for component in frontend catalogue cart user shipping payment mysql rabbitmq redis mongodb; do 
        COMPONENT=$component
        launch_ec2                  # Calling Create Server Function
    done 
else 
        launch_ec2                  # Calling Create Server Function
fi