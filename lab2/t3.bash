#!/bin/bash

ps -Ao pid,command,stime | tail -n 7 | head -n 1 | awk '{print $1}'
# idk why not work cut -f 2