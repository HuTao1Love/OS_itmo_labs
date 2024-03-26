#!/bin/bash

bash t4cmd.bash & prog1=$!
bash t4cmd.bash & prog2=$!
bash t4cmd.bash & prog3=$!

bash t4proccesschecker.bash "$prog1"

kill $prog3