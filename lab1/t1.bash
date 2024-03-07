#!/bin/bash

let maxValue=$1

if [[ "$2" -ge "$maxValue" ]]
then maxValue=$2
fi

if [[ "$3" -ge "$maxValue" ]]
then maxValue=$3
fi

echo $maxValue