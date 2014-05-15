#!/bin/bash

hosts_tjxc=(`cat server.list.tjxc`)
size=${#hosts_tjxc[@]}

echo -e "\033[34m\r\n***************Let go !*****************\033[0m"
echo -e "\033[36m                                         \033[0m"
echo -e "\033[31m                 TJXC                    \033[0m"        
echo -e "\033[32m|------------IP-----------------NUM-----|\033[0m"

for((i=0; i<size; ++i));
do
  ./remote_exec_cmd.sh  ${hosts_tjxc[$i]} ps >/dev/null 
echo  -en  "\033[32m|\t${hosts_tjxc[$i]}\t\t$?\t|\r\n\033[0m"
#printf "|     %-20s\t\t %-4s\r\n" ${hosts[$i]},$? 
done
echo -e "\033[32m|---------------------------------------|\033[0m"

hosts_djtxc=(`cat server.list.djtxc`)
size=${#hosts_djtxc[@]}

echo -e "\033[31m                 DJTXC                   \033[0m"        
echo -e "\033[32m|------------IP-----------------NUM-----|\033[0m"

for((i=0; i<size; ++i));
do
  ./remote_exec_cmd.sh  ${hosts_djtxc[$i]} ps >/dev/null 
echo  -en  "\033[32m|\t${hosts_djtxc[$i]}\t\t$?\t|\r\n\033[0m"
#printf "|     %-20s\t\t %-4s\r\n" ${hosts[$i]},$? 
done
echo -e "\033[32m|---------------------------------------|\033[0m"


hosts_sjsxc=(`cat server.list.sjsxc`)
size=${#hosts_sjsxc[@]}

echo -e "\033[31m                 SJSXC                   \033[0m"        
echo -e "\033[32m|------------IP-----------------NUM-----|\033[0m"

for((i=0; i<size; ++i));
do
  ./remote_exec_cmd.sh  ${hosts_sjsxc[$i]} ps >/dev/null 
echo  -en  "\033[32m|\t${hosts_sjsxc[$i]}\t\t$?\t|\r\n\033[0m"
#printf "|     %-20s\t\t %-4s\r\n" ${hosts[$i]},$? 
done
echo -e "\033[32m|---------------------------------------|\033[0m"


echo -e "\033[36m                                         \033[0m"
echo -e "\033[34m******************END********************\r\n\033[0m"
echo -e "\033[34m    CopyRight by bingyu.song 2014.3.31   \r\n\033[0m"
