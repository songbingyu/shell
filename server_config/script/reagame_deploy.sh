#!/bin/sh

if ! [ $# -eq 1 ]
then 

echo "Usgae: ./reagame_deploy.sh iplist"
exit 

fi

echo -e "\033[33m\r\n*********************** begin********************\033[0m"


. ./vars


iplist=`cat $1 `

echo -e "\033[34m\r\n---------------------gen version ---------------------\r\n\033[0m"
echo -e "begin gen version"
./gen_version.sh > gen_version.log
if [ $? -ne  0 ]; then 
echo -en "\033[31m ERROR:gen version  fail, please check gen_version.log for more detail \033[0m"
exit 1
fi

#md5sum

#deployDir=/data/reagame/test

packetName=`cat curPacketName`

echo -e "gen version $packetName success"

echo -e "\033[34m\r\n---------------------------------------------------\r\n\033[0m"

deployLog="./deploy.log"
if [ ! -f "$deployLog" ]; then 
touch $deployLog
fi

curDate=`date "+%Y-%m-%d-%H-%M-%S"`
echo $curDate"deploy log " > $deployLog 

for ip in $iplist 
do
 echo -en "\033[32m\r\n----------copy file to $ip and unzip ----------\r\n\033[0m"
 echo "copy $packetName.tar.bz2  to $ip"
./remote_scp.sh $ip  $username $password $packetName.tar.bz2 $deployDir >> $deployLog 
 echo "copy curPacketName  to $ip"
./remote_scp.sh $ip  $username $password curPacketName $deployDir >> $deployLog 
 echo "copy md5  to $ip"
./remote_scp.sh $ip  $username $password md5 $deployDir >> $deployLog 
 echo "copy server_update.sh  to $ip"
./remote_scp.sh $ip  $username $password server_update.sh $deployDir >> $deployLog 
 echo "copy serverStart.sh to $ip"
./remote_scp.sh $ip  $username $password serverStart.sh $deployDir >> $deployLog 
 echo "begin login $ip and unzip packet"
./remote_ssh.sh $ip $username $password $deployDir server_update.sh "" 0 >> $deployLog 
 if [ $? -ne  0 ]; then 
 echo -en "\033[31m ERORR, remote login to $ip unzip fail ,please ssh   \033[0m"
 exit 1
 fi

echo -en "\033[32m\r\n----------------------------------------------------\r\n\033[0m"
done

#rm -rf  md5
#rm -rf  curPacketName

echo -e "\033[33m\r\n*********************** end ********************\033[0m"


























