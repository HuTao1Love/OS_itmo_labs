#!/bin/bash

# $1 is arg with pid of proccess
current=-10
while true; do
    cpu=$(top -bp "$1" -o "%CPU" -n 1 | tail -n 1 | awk '{print $9}')
    if (( $(echo "$cpu > 10.0" | bc -l') )); then
        renice -n "$current" $1
        current=$(($current+1))
    fi
    sleep 1
done