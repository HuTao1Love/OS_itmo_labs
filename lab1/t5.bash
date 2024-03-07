#!/bin/bash
touch "info.log"
awk '{if ($4 == "INFO") print}' /var/tmp.log > info.log

# i used other file, log type in 4