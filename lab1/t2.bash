#!/bin/bash

cur=""
value=""

while [[ "${cur}" != "q" ]] do
    value="$value$cur"
    read cur
done

echo $value