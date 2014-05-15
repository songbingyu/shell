#!/usr/bin/expect 
set ip       [lindex $argv 0 ]
set user     [lindex $argv 1 ]
set password [lindex $argv 2 ]
set svn_addr [lindex $argv 3 ] 
set target   [lindex $argv 4 ]
set timeout -1  
#log_user 0
spawn ssh   root@$ip
expect {
	"yes" { 
		send "yes\n"
		expect "#"  { 
		 	send "cd $target\n"
		}
	}
	"#" {
	
		send "cd $target\n"
	}
}


send " svn  co $svn_addr   $target\n"
expect "密码" {
    send "\n"
}

expect "用户" { 
		send "$user\n"
		expect "密码"  { 
			send "$password\n"
		}
}


expect "yes" {

    send "no\n"
    expect "yes" {
        send "no\n"
    }

    expect "]#" {

    }

}
exit
