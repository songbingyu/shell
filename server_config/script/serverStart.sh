#!/bin/bash


if ! [ $# -eq 2 ]
then 
echo "Usgae: ./serverStart.sh serverName  serverIndex "
exit 
fi

packetName=(`cat curPacketName`)

echo $packetName

cd  ./bin/$packetName 

CheckProcess()
{
  # 检查输入的参数是否有效
  if [ "$1" = "" ];
  then
    return 1
  fi   #$PROCESS_NUM获取指定进程名的数目，为1返回0，表示正常，不为1返回1，表示有错误，需要重新启动
  local PROCESS_ID=$(ps aux | grep "$1" | grep -v "grep"|grep -v SCREEN  | awk '{ print $2 }') 
  #echo $1
  #echo $PROCESS_ID
  if [ "$PROCESS_ID"  !=  ""  ];
  then
    return 1
  else
    return 0
  fi
}

startServer(){
	echo "----begin start $1 $2"
 	CheckProcess "$1 $2"
 	local ret=$?
 	if [ $ret -eq 0 ];then  
  	screen -d -m -s   ./$1 $2  
 	else
	echo "****$1 $2 is runing, please first stop "
 	fi
}

stopServer() {
	echo "----begin stop $1 $2"
	CheckProcess "$1 $2"
	local ret=$?
	if [ $ret -eq 0 ];then  
  	echo "****$1 $2 is not Runing"
 	else
	ps aux | grep "$1 $2" | grep -v "grep"|grep -v SCREEN  | awk '{ print $2 }'|xargs kill
	echo "----kill  $1 $2 successful "
 	fi
}


startMonitor(){
	echo "----begin start  $1 $2"
 	CheckProcess "$1 $2"
	echo $?
 	local ret=$?
 	if [ $ret -eq 0 ];then  
  	screen -d -m -s   $1_$2  ./$1 $2 > $1_$2.log
	echo "----start $1 $2 sucessful"  
 	else
	echo "****$1 $2 is runing, please begin stop  "
 	fi
}

stopMonitor() {
	echo "----begin stop $1 $2"
	CheckProcess "$1 $2"
	local ret=$?
	if [ $ret -eq 0 ];then  
  	echo "****$1 $2 is not Runing"
 	else
	ps aux | grep "$1 $2" | grep -v "grep"|grep -v SCREEN  | awk '{ print $2 }'|xargs kill
 	fi
}



case "$1" in
    GameServer)
		stopMonitor ./gameServerMonitor.sh $2 
		stopServer ./GameServer $2
		startMonitor gameServerMonitor.sh  $2
        ;;
    GatewayServer)
		stopMonitor ./gatewayMonitor.sh $2 
		stopServer ./GatewayServer $2
		startMonitor gatewayMonitor.sh  $2
        ;;
    Logfront)
		stopMonitor ./logfrontMonitor.sh $2 
		stopServer  ./Logfront $2
		startMonitor logfrontMonitor.sh $2
        ;;
    *)
     echo "Usage: $0 {GameServer 1 |GatewayServer 1 | Logfront $1 }"
     exit 1
esac




