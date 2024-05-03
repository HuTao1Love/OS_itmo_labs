#!/bin/bash

cat $(find /var/log/ -name "*.log") | wc --lines