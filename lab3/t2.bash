#!/bin/bash

at now + 2 minutes -f ./t1.bash &
tail -n 0 -f ~/report &