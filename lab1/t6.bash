#!/bin/bash

touch "full.log"
awk '{if ($4 == "ERROR") print}' /var/tmp.log | sed "s/ERROR/Warning:/" > full.log
awk '{if ($4 == "INFO") print}' /var/tmp.log | sed "s/INFO/Info:/" >> full.log
cat full.log

# i used other file, log type in 4, replaced warning with error