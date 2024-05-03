#!/bin/bash

trashdir=~/.trash
trashlog=~/.trash.log

file="$(pwd)/$*"
if [[ $# != 1 || ! -f $file ]];
then
	echo "Args must be path to file";
	exit 1
fi

[ -e $trashdir ] || mkdir $trashdir
[ -f $trashlog ] || touch $trashlog

linkval=$(date +"%y_%m_%d-%T")
ln "$file" "$trashdir/$linkval"
echo "$file" "$linkval" >> $trashlog
rm -rf "$file"