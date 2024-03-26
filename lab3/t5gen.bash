#!/bin/bash

while true; do
    sleep 0.3
    echo -n ">g> "
    read line
    echo "$line" > pipe

    if [[ "$line" == "QUIT" ]]
    then
        echo "<g< EXIT 0: OK"
        exit
    fi

    if [[ "$line" != "+" && "$line" != "*" ]] && ! [[ "$line" =~ ^[[:digit:]]+ ]];
    then
        echo "<g< EXIT 1: GEN INVALID OPERATION"
        exit 1
    fi
done