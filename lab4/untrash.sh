#!/bin/bash

trashdir=~/.trash
trashlog=~/.trash.log

file="$*"

grep -- "$file " "$trashlog" | while read -r line; do
    echo $line;

    current_file=$(echo "$line" | awk '{$NF=""} 1')
    thrash_file=$(echo "$line" | awk '{ print $NF }')

    echo -n "Restore file ?(Y/N)"
    read ans < /dev/tty

    if [[ "$ans" == "Y" ]]; then
        pathout=$(echo "$current_file" | grep -Eo '.*\/')

        if [ ! -d "$pathout" ]; then
            echo "Original directory doesn't exist, restored into $HOME"
            pathout="$HOME"
        fi;

        while [ -e "$pathout/$file" ]; do
            echo "A file with the name '$file' already exists in the restore location."
            echo -n "Please enter a new name for the file: "
            read new_name < /dev/tty
            file="$new_name"
        done

        pathout="$pathout/$file"
        thrash_file="$trashdir/$thrash_file"
        sed -i "\|${line//\\/\\\\}|d" "$trashlog"
        ln "$thrash_file" "$pathout"
        rm "$thrash_file"
    fi
done