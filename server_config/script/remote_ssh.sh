#!/usr/bin/expect


set ip [lindex $argv 0 ]     	   
set username [lindex $argv 1 ]
set password [lindex $argv 2 ]   
set targetDir [lindex $argv 3 ]
set shellName [lindex $argv 4]
set serverName [lindex $argv 5]
set serverIndex [lindex $argv 6 ] 


set timeout 1000                  


spawn ssh $username@$ip       
expect {                 
	"*yes/no" { send "yes\r"; exp_continue}  
	"*password:" { send "$password\r" }      
}

expect "#" {

	send "cd $targetDir\r" 
}


expect "*#" {
	send "./$shellName $serverName $serverIndex\r" 
}


expect "#" {
	send "exit\r"
}




