#!/bin/sh
#set -x
scode="gbk"
dcode="utf-8"
Usage()
{
	echo "
	Usage: conv [OPTIONS] [DIR]
	[-u] GBK to UTF-8
	[-g] UTF-8 to GBK
	"
	exit 1
}

#将当前目录和子目录下所有普通文件进行转码
codeConvert()
{
	local dir=$1
	echo "Convert file in $1"
	for file in $(ls $1)
	do
		file="$1$file"
		if [ -d $file ];then
			codeConvert $file/ $2 $3
		elif [ -f $file ];then
			coding=$(file -b $file | cut -d ' ' -f1)
			echo -n "$file...$coding..."
			if [ "$2" = "gbk" ] && [ "$coding" != "ISO-8859" ];then
				echo "========not gbk"
				continue
			fi
			
			if [ "$2" = "utf-8" ] && [ "$coding" != "UTF-8" ];then
				echo "========not UTF-8"
				continue
			fi
			
			echo ""
			
			#进行转码
			local tmpfile=$(mktemp)
			Fright=$(stat -c %a $file)
			Fuser=$(stat -c %U $file)
			Fgro=$(stat -c %G $file)
			iconv -f $2 -t $3 $file > $tmpfile
			if [ $? != 0 ];then
				echo "iconv -f $2 -t $3 $file > $tmpfile"
				exit 1
			fi
			
			mv $tmpfile $file
			chmod $Fright $file
			chown $Fuser:$Fgrp $file
		fi
	done
}

if [ $# -lt 2 ];then
	echo "arg not enough $#"
	Usage
fi

while getopts ug opt
do
	case $opt in
		u) echo "Convert gbk coding to utf-8 ...."
			codeConvert $2 gbk utf-8
		;;
		g) echo "Convert utf-8 coding to gbk ...."
			codeConvert $2 utf-8 gbk
		;;
		*) Usage
			exit 1
	esac
done
exit 0
