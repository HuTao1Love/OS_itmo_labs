#!/bin/bash

data=$(ps u -A | awk '$1 = "user" {print $2 ":" $11}')
cnt=$(echo "$data" | wc --lines)
echo -e "$cnt\n$data" > t1.data