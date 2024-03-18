#!/bin/bash

for pid in $(ps -Ao pid | tail -n +2);
do
    ppid=$(grep -Ehsi "^Ppid" /proc/$pid/status | awk '{print $2}')
    
    runtime=$(grep -Ehsi "se\.sum_exec_runtime(.+):\s+(.+)" /proc/$pid/sched | awk '{print $3}')
    nr_switches=$(grep -Ehsi "^nr_switches" /proc/$pid/sched | awk '{print $3}')

    if [ -z $ppid ]; then 
        ppid="NO"
        continue
    fi
    if [ -z ${runtime} ] || [ -z ${nr_switches} ]; then 
        time=0
    else
        time=$(echo $runtime $nr_switches | awk '{print $1/$2}')
    fi
    echo "$pid $ppid $time"
done | sort -n -k 2 | awk '{print "ProcessID="$1":Parent_ProcessID="$2":Average_Running_Time="$3}' > t4.data