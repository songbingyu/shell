#!/bin/sh 

if ! [ $# -eq 2 ]
then
echo "Usage: ./config_env.sh iplist_file  svn_user "
exit
fi

echo " please input svn passwd"
read -s passwd


. ./vars

iplist=(`cat $1`)

for  ip in $iplist
do
	echo""
	echo -e  "\033[34m\r\n----------------- $ip begin config -----------------\033[0m"
	#copy file
	echo ""
	echo " copy -- $nginx_file   -->  $soft_target_dir"
	./remote_scp.sh $ip  $nginx_file $soft_target_dir >>$log_file
	echo " copy -- $pcre_file    -->  $soft_target_dir" 
	./remote_scp.sh $ip  $pcre_file   $soft_target_dir >>$log_file
	echo " copy -- $svn_shell    -->  $soft_target_dir"
	./remote_scp.sh $ip  $svn_shell  $soft_target_dir >>$log_file
	echo " copy -- $config_shell -->  $soft_target_dir"
	./remote_scp.sh $ip  $config_shell  $soft_target_dir >>$log_file

	echo " copy -- $config_file -->  $soft_target_dir"
	./remote_scp.sh $ip  $config_file  $soft_target_dir >>$log_file
	echo " copy -- $nginx_shell  -->  $shell_target_dir"
	./remote_scp.sh $ip  $nginx_shell  $shell_target_dir >>$log_file
	echo""
	echo " start login  $ip install and config nginx "
	echo""
	./remote_ssh.sh $ip   $soft_target_dir $config_shell >>$log_file
	echo " nginx config finish..."
	echo " start login  $ip checkout nginx conf  "
	./remote_svn_checkout.sh  $ip  $2  $passwd  $svn_addr $nginx_conf_dir >>$log_file
	echo " svn checkout  finish...."

	echo ""
	echo -e  "\033[34m\r\n-------------------$ip end config-----------------\033[0m"
	echo ""
done







 











