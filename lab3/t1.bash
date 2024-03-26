#!/bin/bash

date=$(date '+%F_%T')

mkdir ~/test && {
    echo "catalog test was created successfully" > ~/report
    touch ~/test/$date
}

ping www.net_nikogo.ru || echo $date" - not available" >> ~/report