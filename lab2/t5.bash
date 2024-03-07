#!/bin/bash

sum=0
prev=0
cnt=0

read -r last_pid last_ppid <<< $(cat t4.data | tail -1 | sed "s/=/ /g" | sed "s/:/ /g" | cut -d ' ' -f 2,4)

echo -e "$(<t4.data)" | while read -r line
do
    read -r pid ppid time <<< $(echo $line | sed "s/=/ /g" | sed "s/:/ /g" | cut -d ' ' -f 2,4,6)
    
    if [[ $ppid -eq $prev ]]; then
        echo $line
        sum=$(echo $sum $time | awk '{print $1+$2}')
        cnt=$(echo $cnt | awk '{print 1+$1}')
    else
        avg=$(echo $sum $cnt | awk '{print $1/$2}')
        echo "Average_Running_Children_of_ParentID="$prev" is "${avg}
        sum=$time
        cnt=1
        echo $line
        prev=$ppid
    fi

    if [[ $ppid -eq $last_ppid && $pid -eq $last_pid ]]; then
        avg=$(echo $sum $cnt | awk '{print $1/$2}')
        echo "Average_Running_Children_of_ParentID="$prev" is "${avg}
    fi
done > t5.data