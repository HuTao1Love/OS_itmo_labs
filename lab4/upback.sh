#!/bin/bash

dir="/home/user"
lastdate=$(ls $dir | grep -E "^Backup-" | sort -n | tail -1 | sed 's/^Backup-//')
last="$dir/Backup-${lastdate}"

if [[ -z "$lastdate" ]];
then
	echo "Backup not found"
	exit 1
fi

if [[ ! -d $dir/restore ]];
then
	mkdir $dir/restore
else
	rm -r $dir/restore
	mkdir $dir/restore
fi

for f in $(ls $last | grep -Ev "\.[0-9]{4}-[0-9]{2}-[0-9]{2}$");
do
	cp "${last}/${f}" "$dir/restore/${f}"
	echo "Success ${f}"
done