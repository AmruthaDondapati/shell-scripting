LOFGILE="/tmp/$COMPONENT.log"
APPUSER=roboshop

ID=$(id -u)
if [ $ID -ne 0 ] ; then 
    echo -e "\e[31m You need to script either as a root user or with a sudo privilege \e[0m"
    exit 1
fi 

stat() {
    if [ $1 -eq 0 ]; then 
        echo -e "\e[32m Sucess \e[0m"
    else
        echo -e "\e[31m failed \e[0m"
    fi
}
