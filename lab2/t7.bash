#!/bin/bash

# check new proccesses

init=()
pids=()
cmds=()
upd=()

for pid in $(ps -Ao pid | tail -n+2)
do
    if ! [[ -r /proc/"$pid"/io ]]; then continue; fi;
    pids[$pid]=$pid
    init[$pid]=$(awk '{if ($1=="rchar:") {print $2}}' /proc/$pid/io)
done

sleep 10s

for pid in $(ps -Ao pid | tail -n+2)
do
    if ! [[ -r /proc/"$pid"/io ]]; then continue; fi;
    upd[$pid]=$(awk '{if ($1=="rchar:") {print $2}}' /proc/$pid/io)
done

for pid in "${pids[@]}"
do
    if ! [[ -r /proc/"$pid"/cmdline ]]; then continue; fi;
    cmd=$(cat /proc/$pid/cmdline | tr -d "\0")
    count=$(echo upd[$pid] init[$pid] | awk '{print $1-$2}')
    echo "$pid:$count:$cmd"
done | sort -nrk3 | head -3 > t7.data
