#!/bin/sh

rm -rf *.tar.bz2


curDate=`date "+%Y-%m-%d-%H-%M-%S"`

svn_version=`svn info | grep Revision | awk '{print $2}'`

packet_name=regame_server_${svn_version}_$curDate

mkdir $packet_name

cp -r   ./Bin/*  $packet_name

tar -jcvf $packet_name.tar.bz2  ./$packet_name

rm -rf $packet_name

#md5sum
md5=`md5sum $packet_name.tar.bz2 | cut -d' ' -f1 `

echo $md5 > md5
echo $packet_name > curPacketName

























