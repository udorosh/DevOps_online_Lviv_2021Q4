##!/bin/bash

# This condition for written for display a list of possible keys and their description.
if [[ "$#" == "0" ]]
then
        echo -e "\033[33mFor this script actually next arguments:"
		echo -e "Example: .script_c.sh [path to source folder] [patch to destination folder] \033[0m"        
        exit 0
elif ! [[ -d $1 ]]
then
    	echo -e "\033[31m Error! Source directory not exists!\033[0m"
	exit 0
elif [[ -z $2 ]]
then
	echo -e "\033[31m You must specify destination directiry!\033[0m"
	exit 0
elif ! [[ -d $2 ]]
then
    	echo -e "\033[31m Destination directory is absent, trying to create $2 !\033[0m"
	mkdir "$2" 
	echo -e "\033[32m Directory $2 created!\033[0m"
fi

# Set parameters
srcdir=$1
dstdir=$2
log=$dstdir/backup.log
tmpdir=$dstdir/tmp

if ! [[ -d $tmpdir ]]; then
       	mkdir $tmpdir
fi
touch $dstdir/backup.log
touch $tmpdir/ls.tmp;
touch $tmpdir/snapshot.tmp;


ls $srcdir > $tmpdir/ls.tmp;

# Archiving and logging
dt=$(date '+%d.%m.%Y_%H:%M:%S');
for var1 in $(diff -y --suppress-common-lines $tmpdir/ls.tmp $tmpdir/snapshot.tmp | awk '{print $1}' | sed 's/>//g; /^[[:space:]]*$/d')
do
        echo "$dt CREATED $var1" >> $log
        tar -rvf $dstdir/Backup.tar $srcdir/$var1 > /dev/null 
        echo "$dt BACKUPED $var1" >> $log
done

echo "Backuped!"

for var2 in $(diff -y --suppress-common-lines $tmpdir/ls.tmp $tmpdir/snapshot.tmp | awk '{print $2 $3}' | sed 's/<//g; /^[[:space:]]*$/d; s/|//g')
do
        echo "$dt DELETED $var2" >> $log
done

rm -rf $tmpdir/ls.tmp;
ls $srcdir > $tmpdir/snapshot.tmp
