#!/bin/bash

val=1
op="+"

(tail -f pipe ; pid=$!) | while true;
do
    read line

    if [[ "$line" == "+" ]] || [[ "$line" == "*" ]]
    then
        op=$line
        echo "<h< Current operation: $line"
    else

        if [[ $line == "QUIT" ]]
        then
            kill $pid 2>/dev/null
            echo "<h< EXIT 0: OK"
            exit
        else

            if [[ "$line" =~ ^[[:digit:]]+ ]]
            then
                if [[ "$op" == "+" ]]
                then
                    val=$(echo $val $line | awk '{print $1 + $2}')
                    echo "<h< "$val
                else
                    val=$(echo $val $line | awk '{print $1 * $2}')
                    echo "<h< "$val
                fi

            else
                kill $pid 2>/dev/null
                echo "<h< EXIT 1: HANDLER INVALID OPERATION"
                exit 1
            fi
        fi
    fi
done