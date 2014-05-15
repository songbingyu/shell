#!/usr/bin/expect 
set ip     [lindex $argv 0 ] 
set file   [lindex $argv 1 ]
set target [lindex $argv 2 ]
set timeout 10  
set ret     0

spawn scp $file  root@$ip:$target  
expect {
	"yes" { 
		send "yes\n"
		expect "#"  { 
			exit
		}
	}
	"#" {
	 exit
	}
}



