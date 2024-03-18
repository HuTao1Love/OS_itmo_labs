#!/bin/bash

ps -fu root | awk -v ppid="${PPID}" -v pid="$$" '{ if ($2 != ppid && $2 != pid && $3 != pid) {print $2} }' | sort -nk1 | tail -n 1
