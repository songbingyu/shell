#!/bin/sh

. ./vars

restartGameServer() {

iplist=`cat iplist.game`

serverIndex=1

for ip in $iplist 
do
	./remote_ssh.sh $ip $username $password  $deployDir serverStart.sh GameServer $serverIndex >> $restartLog 
 	if [ $? -ne  0 ]; then 
 	echo -en "\033[31m ERORR: restart GameServer $serverIndex ip:  $ip  fail, for more detail log please see $restartLog \033[0m"
 	exit 1
	else 
	echo "restart GameServer $serverIndex  ip:$ip "
	fi
	serverIndex=$serverIndex+1
done 
}

restartGatewayServer() {

iplist=`cat iplist.gateway`

serverIndex=1

for ip in $iplist 
do
	./remote_ssh.sh $ip $username $password $deployDir serverStart.sh GatewayServer $serverIndex >> $restartLog  
	if [ $? -ne  0 ]; then 
 	echo -en "\033[31m ERORR: restart GatewayServer $serverIndex ip:  $ip  fail, for more detail log please see $restartLog \033[0m"
 	exit 1
	else 
	echo "restart GatewayServer $serverIndex  ip:$ip "
	fi

	serverIndex=$serverIndex+1
done 
}

restartLogfront() {

iplist=`cat iplist.log`

serverIndex=1

for ip in $iplist 
do
	./remote_ssh.sh $ip $username $password $deployDir serverStart.sh Logfront $serverIndex >> $restartLog 
	if [ $? -ne  0 ]; then 
 	echo -en "\033[31m ERORR: restart Logfront $serverIndex ip:  $ip  fail, for more detail log please see $restartLog \033[0m"
 	exit 1
	else 
	echo "restart Logfront $serverIndex  ip:$ip "
	fi
	serverIndex=$serverIndex+1
done 
}


restartLog="./restart.log"
if [ ! -f "$restartLog" ]; then 
touch $restartLog
fi

curDate=`date "+%Y-%m-%d-%H-%M-%S"`
echo $curDate"restart log " > $restartLog 


echo -e "\033[33m\r\n*********************** begin********************\033[0m"

case "$1" in
    GameServer)
        restartGameServer
        ;;
    GatewayServer)
        restartGatewayServer
		;;
    Logfront)
        restartLogfront
        ;;
    all)
        restartGameServer
        restartGatewayServer
        restartLogfront
        ;;
    *)
     	echo "Usage: $0 {GameServer 1 |GatewayServer 1 | Logfront $1 }"
        exit 1
esac

echo -e "\033[33m\r\n*********************** end ********************\033[0m"
