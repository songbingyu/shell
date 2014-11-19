#!/bin/sh

if ! [ $# -eq 1 ]
then 

echo "Usgae: ./reagame_deploy.sh iplist"
exit 

fi


. ./vars


iplist=`cat $1 `
echo "$iplist"


./gen_version.sh


#md5sum

#deployDir=/data/reagame/test

packetName=`cat curPacketName`

for ip in $iplist 
do
 echo "copy file to $ip"
./remote_scp.sh $ip  $username $password $packetName.tar.bz2 $deployDir 
./remote_scp.sh $ip  $username $password curPacketName $deployDir 
./remote_scp.sh $ip  $username $password md5 $deployDir 
./remote_scp.sh $ip  $username $password server_update.sh $deployDir 
./remote_scp.sh $ip  $username $password serverStart.sh $deployDir 
./remote_ssh.sh $ip $username $password $deployDir server_update.sh "" 0 
done

rm -rf  md5
rm -rf  curPacketName



























