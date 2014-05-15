#!/usr/bin/expect 
 set ip  [lindex $argv 0 ] 
 #set cmd [lindex $argv 1 ]
 set timeout 10  
 set num     0

 spawn ssh root@$ip  
 expect {
   "yes" { 
        send "yes\n"
	expect "#"  { 
        send " echo SS `ps aux| grep rsync | wc -l` EE\r"
	}
      }
    "#" {
        send " echo SS `ps aux| grep rsync | wc -l` EE\r"
    }
}
 
 #set cmd  `echo ps aux|grep rsync| wc -l`  
  
     
   expect -re    "\r\nSS(.*)EE"  {
   set  num   $expect_out(1,string)
   send " exit $num \n"
   expect eof
  }
  exit $num
