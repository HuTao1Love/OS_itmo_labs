#!/bin/bash

read -r s_pid s_mem <<< $(for pid in $(ps -Ao pid)
do
    if ! [[ -r /proc/$pid/status ]]; then continue; fi;

    current=$(awk '{ if ($1 == "VmRSS:") { print $2 } }' < /proc/$pid/status)
    if [[ -z $current ]]; then continue; fi;
    echo $pid $current
done | sort -r -nk2 | head -1)

echo "SCRIPT PID:"$s_pid"; MEM:"$s_mem
echo "TOP PID:"$(top -o %MEM -n 1 | awk '{print $2}' | awk 'NR==8')