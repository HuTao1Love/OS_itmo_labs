#!/bin/bash

if [[ $HOME = $PWD ]]
then
    exit 0
else
    echo "NOT FROM HOME DIRECTORY"
    exit 1
fi