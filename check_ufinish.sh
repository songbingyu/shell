#!/bin/bash
. vars

unfinish="unfinish.list"
files=(`cat ./log/rsync_global.log | awk -F, '{ print $4 }'| awk -F: '{ print $2 }'`)

#files=(`cat $foldfile`)
#files=(`cat dir.tjxc.list`)
size=${#files[@]}

if [ -f $unfinish ];
then
new="$unfinish."`date +%Y.%m.%d.%H.%M`".bak"
mv $unfinish  $new 
fi


touch $unfinish



#for ((i=0; i<2;++i));
for ((i=0; i<$size;++i));
do
    file="./log/"`echo ${files[$i] } | sed s/"\/"/"_"/g`".log.success"
    if [ ! -f "$file"  ];
    then
	echo ${files[$i]} >> $unfinish
    fi

done

