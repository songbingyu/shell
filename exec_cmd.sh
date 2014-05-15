#!/usr/bin/expect 
 set ip  [lindex $argv 0 ] 
 set cmd [lindex $argv 1 ]
 set timeout 10  
 set ret     0
 set cmd     "$cmd\r"

 spawn ssh root@$ip  
 expect {
   "yes" { 
        send "yes\n"
	expect "#"  { 
        send  $cmd
	}
      }
    "#" {
        send $cmd
    }
}

 expect    {
 "*rsync"  {
 	set  ret   1
 	send " exit $ret \n"
 	expect eof
        }
 "]" {
      send " exit $ret \n"
      expect eof
 }
}

exit $ret 



#exit $num
