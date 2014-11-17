#!/bin/sh

GATEWAY_PID=`ps aux| grep Gateway | grep -v grep | awk '{ print $2 }' `
GAME_PID=`ps aux| grep Game    | grep -v grep |awk '{ print $2}'`  

if [ "$GATEWAY_PID" != "" ]; then

echo -e " --------------------close Gateway-------------------"
kill $GATEWAY_PID

fi

if [ "$GAME_PID" != "" ]; then 

echo -e " ------------------ close GameServer ---------------"
kill $GAME_PID

fi

cd ./Bin

echo -e "************************Begin Open Server ***************************************************\n"

echo -e "                    open gateway                                                             ";

#screen -d -m -S GatewayServer valgrind  --tool=memcheck  --leak-check=full  --log-file=gws.log  ./GatewayServer  
screen -d -m -S GatewayServer ./GatewayServer  

echo -e "		     open gameserver  							      ";
#screen -d -m -S GameServer   valgrind --tool=memcheck  --leak-check=full  --log-file=mem_gs.log  ./GameServer    
screen -d -m -S GameServer   ./GameServer    

cd -


