#!/bin/bash

printf "Select value\n1. nano\n2. vi\n3. links\nother. exit\n"

read item

case "${item}" in
    1)
        nano
    ;;
    2)
        vi
    ;;
    3)
        links
    ;;
    *)
        exit
    ;;
esac
