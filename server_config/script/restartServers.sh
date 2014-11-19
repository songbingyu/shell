#!/bin/sh

. ./vars

restartGameServer() {

iplist=`cat iplist.game`

serverIndex=1

for ip in $iplist 
do
	./remote_ssh.sh $ip $username $password  $deployDir serverStart.sh GameServer $serverIndex  
	serverIndex=$serverIndex+1
done 
}

restartGatewayServer() {

iplist=`cat iplist.gateway`

serverIndex=1

for ip in $iplist 
do
	./remote_ssh.sh $ip $username $password $deployDir serverStart.sh GatewayServer $serverIndex  
	serverIndex=$serverIndex+1
done 
}

restartLogfront() {

iplist=`cat iplist.log`

serverIndex=1

for ip in $iplist 
do
	./remote_ssh.sh $ip $username $password $deployDir serverStart.sh Logfront $serverIndex  
	serverIndex=$serverIndex+1
done 
}



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
