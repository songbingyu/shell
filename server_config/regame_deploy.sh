#!/bin/sh

if ! [ $# -eq 1 ]
then 

echo "Usgae: ./reagame_deploy.sh iplist"
exit 

fi



. ./vars


iplist=(`cat $1`)



#./gen_version.sh


#md5sum


for ip in $iplist 
do
 echo "copy file to $ip"
./remote_scp.sh $ip  $username $password *.tar.bz2  /data/reagame/test   
./remote_scp.sh $ip  $username $password curPacketName  /data/reagame/test   
./remote_scp.sh $ip  $username $password md5  /data/reagame/test   
./remote_scp.sh $ip  $username $password server_update.sh  /data/reagame/test   

./remote_ssh.sh $ip $username $password server_update.sh 


done
























