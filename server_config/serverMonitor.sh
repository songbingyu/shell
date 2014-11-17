#!/bin/bash

CheckProcess()
{
  # 检查输入的参数是否有效
  if [ "$1" = "" ];
  then
    return 1
  fi   #$PROCESS_NUM获取指定进程名的数目，为1返回0，表示正常，不为1返回1，表示有错误，需要重新启动
  PROCESS_NUM=`ps -ef | grep "$1" | grep -v "grep"| grep -v SCREEN  | wc -l ` 
  if [ $PROCESS_NUM  -eq 1 ];
  then
    return 1
  else
    return 0
  fi
}     

curDate=`date "+%Y-%m-%d %H:%M:%S"`

cd Bin/


while [ 1 ] ; do
 CheckProcess "GameServer"
 ret=$?
 if [ $ret -eq 1 ];then  
  echo "GameServer is Runing"
 else
  echo "${curDate}   GameServer rstart"   
  screen -d -m -s GameServer ./GameServer  
 fi
 CheckProcess "GatewayServer"
 ret=$?
 if [ $ret -eq 1 ];then   
  echo "GatewayServer is Runing"
 else 
  echo "${curDate}   GatewayServer restart"   
  screen -d -m -s GatewayServer ./GatewayServer  
 fi
 sleep 2
done
