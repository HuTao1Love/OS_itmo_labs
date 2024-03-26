#!/bin/bash

val=1
op="+"

function setOperation() {
    echo "<h< setOperation $*"
    op=$1
}

trap 'setOperation +' USR1
trap 'setOperation "*"' USR2
trap 'setOperation TERM' SIGTERM

while true; do
    if [[ "$op" == "+" ]]; then
        val=$(echo $val | awk '{print $val + 2}')
        echo "<h< "$val
    fi 

    if [[ "$op" == "*" ]]; then
        val=$(echo $val | awk '{print $val * 2}')
        echo "<h< "$val
    fi

    if [[ "$op" == "TERM" ]]; then
        echo "<h< EXIT TERM"
        exit 1
    fi

    sleep 5
done