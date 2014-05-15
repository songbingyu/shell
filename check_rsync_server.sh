#!/bin/sh

echo -e "\033[34m\r\n***************Let go !*****************\033[0m"
echo -e "\033[36m                                         \033[0m"

files=( server.list.tjxc server.list.djtxc server.list.sjsxc )
titles=( TJXC DJTXC SJSXC )
filesSize=${#files[@]} 
cmd="netstat -lntp | grep 873"
for ((j=0; j<filesSize;++j));
do

	hosts=(`cat ${files[$j]}`)
	size=${#hosts[@]}

	echo -e "\r\n\033[31m                ${titles[$j]}                    \033[0m"        
	echo -e "\033[32m|------------IP-----------------STATE---|\033[0m"

	for((i=0; i<size; ++i));
	do
	val=ok
	./exec_cmd.sh  ${hosts[$i]} "$cmd"  >/dev/null
	if  [  $? -ne  1 ];
	then
	val=fail;
	echo  -en  "\033[36m|\t${hosts[$i]}\t\t$val\t|\r\n\033[0m"
	fi 
	echo  -en  "\033[32m|\t${hosts[$i]}\t\t$val\t|\r\n\033[0m"
	done
	echo -e "\033[32m|---------------------------------------|\r\n\033[0m"

done


echo -e "\033[36m                                         \033[0m"
echo -e "\033[34m******************END********************\r\n\033[0m"
echo -e "\033[34m    CopyRight by bingyu.song 2014.3.31   \r\n\033[0m"
