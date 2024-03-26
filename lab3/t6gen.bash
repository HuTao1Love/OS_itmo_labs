#!/bin/bash

# $1 is arg with pid of proccess
echo $1

while true; do
    sleep 0.3
    read line

    if [[ "$line" == "TERM" ]]; then
        kill -SIGTERM $1
        echo "<g< EXIT TERM"
        exit
    fi

    if [[ "$line" == "+" ]]; then
        kill -USR1 $1
    fi

    if [[ "$line" == "*" ]]; then
        kill -USR2 $1
    fi
done