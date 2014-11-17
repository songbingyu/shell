#!/bin/sh

if [ ! -d "./back" ]; then  
mkdir ./back  
fi 

if [ ! -d "./bin" ]; then  
mkdir ./bin  
fi 


packetname=(`cat curPacketName`)

echo "cur packet $packetname"


oldmd5=(`cat md5 `)
echo "md5 $oldmd5"


newmd5=(`md5sum ${packetname}.tar.bz2 | cut -d' ' -f1 `)


#check md5
echo "check md5"
if [ "$oldmd5"0 !=  "$newmd5"0 ]; then
echo "md5 check fail"
exit
fi
echo "check md5 sucess"

echo "back old file"
mv ./bin/*  ./back

echo "begin update"
mv $packetname.tar.bz2  ./bin

cd ./bin

echo " begin extract"
tar xvf *.tar.bz2 >/dev/null
echo " end extract"

echo "begin kill old proc"


GATEWAY_PID=`ps aux| grep Gateway | grep -v grep | awk '{ print $2 }' `
GAME_PID=`ps aux| grep Game    | grep -v grep |awk '{ print $2}'`  
LOG_PID=`ps aux| grep Logfront    | grep -v grep |awk '{ print $2}'` 


if [ "$GATEWAY_PID" != "" ]; then
echo "kill gateway"
kill $GATEWAY_PID
fi

if [ "$GAME_PID" != "" ]; then 
echo "kill GameServer"
kill $GAME_PID
fi

if [ "$LOG_PID" != "" ]; then 
echo "kill Logfront"
kill $LOG_PID
fi

echo "end  kill old proc"


echo " every thing is ok ,i wail leave"










 
