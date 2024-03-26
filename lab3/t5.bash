#!/bin/bash

mkfifo pipe 2>/dev/null

bash t5handler.bash & 
echo "+" > pipe
bash t5gen.bash 

rm pipe