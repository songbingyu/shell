#!/bin/sh 
. ./vars

echo "----------------I have login -----------------"

echo " Extract ing ........."
echo ""
cd $soft_target_dir
echo " begin Extract  $pcre_file ----> `pwd`"
tar xvf $pcre_file >/dev/null
echo " begin Extract  $nginx_file ----> `pwd`"
tar xvf $nginx_file >/dev/null
echo ""
echo "Extract Finish  ......., Begin Install..................  "
echo ""
echo "Install  ${pcre_file%.tar*} ing....."
cd ${pcre_file%.tar*}
./configure  && make -j8  && make install 
cd ../
echo "Install  ${nginx_file%.tar*} ing....."
cd ${nginx_file%.tar*}
./configure --prefix=/data/nginx --pid-path=/var/run/  && make -j8   && make install 

ln -s /data/nginx/sbin/nginx  /usr/sbin
ln -s /lib64/libpcre.so.0.0.1   /lib64/libpcre.so.1
cd ../

mkdir -p $nginx_conf_dir
echo ""
echo "---ConfigOk......."












 









