#!/usr/bin/expect 
set ip      [lindex $argv 0 ] 
set dir     [lindex $argv 1 ] 
set shell   [lindex $argv 2 ] 

set timeout -1  
#log_user 0
spawn ssh   root@$ip
expect {
	"yes" { 
		send "yes\n"
		expect "#"  { 
		 	send "cd $dir\n"
		}
	}
	"#" {
	
		send "cd $dir\n"
	}
}

expect "#" {
 send "chmod +x $shell \n"
}

log_user 1
send "./$shell\n"
expect "ConfigOk" {
 exit
}

