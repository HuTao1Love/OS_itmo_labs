#!/bin/bash

data=$(for pid in $(ps -Ao pid | tail -n+2)
do
    if ! [[ -r /proc/"$pid"/io ]]; then continue; fi;
    echo $pid $(awk '{if ($1=="rchar:") {print $2}}' /proc/$pid/io) $(cat /proc/$pid/cmdline | tr -d "\0")
done)

sleep 1m

echo $data | while read -r pid start cmd
do
    if [[ -z $cmd ]]; then continue; fi;
    update=$(awk '{if ($1=="rchar:") {print $2}}' /proc/$pid/io)
    count=$(echo $update $start | awk '{print $1-$2}')
    echo $pid":"$count":"$cmd
done | sort -nrk3 | head -3 > t7.data