#!/usr/bin/expect


set ip [lindex $argv 0 ]     	   
set username [lindex $argv 1 ]
set password [lindex $argv 2 ]   
set shellName [lindex $argv 3]


set timeout 1000                  


spawn ssh $username@$ip       
expect {                 
	"*yes/no" { send "yes\r"; exp_continue}  
	"*password:" { send "$password\r" }      
}

expect "#" {

	send "cd /data/reagame/test\r" 
}


expect "*#" {
	send "./$shellName\r" 
}


expect "#" {
	send "exit\r"
}




