#/bin/bash

function get_updated_filename {
    file="$1/$2.$3"
    if [ ! -f "$file" ]; then
        echo "$file"
    else
        i=1
        
        while [[ -f "${file}_v$i" ]]; do
            let "i = $i + 1"
        done

        echo "${file}_v$i"
    fi
}

data="$(date '+%Y-%m-%d')"
dirname="/home/user/Backup-$data"

for dir in `find /home/user/ -maxdepth 1 -type d -name "Backup-*"`; do
    i="$(expr index "$dir" "-")"
    dirdata="${dir:$i}"
    diff="$((dirdata-data))"

    if [[ "$diff" -lt 7 ]]; then
        dirname="$dir"
    fi
done

echo "Directory name: $dirname"
if [ ! -d "$dirname"/ ]; then
    echo "Not found; created"
    mkdir "$dirname"

    created="Copied"

    for file in /home/user/source/*; do
        name="${file:18}"
        cp "$file" "$dirname/$name"
        created="$created; $name"
    done

    echo "$created" >> /home/user/backup-report
else
    edited="edit($data) $dirname"
    new="new: "
    upd="updated: "

    for file in /home/user/source/*; do
        name="${file:18}"
        if [ ! -f "$dirname/$name" ]; then
            cp "$file" "$dirname/$name"
            new="$new $file"
        else
            size_prev=$(wc -c "$dirname/$name" | awk '{print $1}')
            size=$(wc -c "$file" | awk '{print $1}')

            if [[ "$size" != "$size_prev" ]]; then
                updname=$(get_updated_filename "$dirname" "$name" "$data")
                mv "$dirname/$name" "$updname"
                let "dirlen=${#dirname}+1"
                cp "$file" "$dirname/$name"
                upd="$upd $name $updname"
            fi
        fi
    done

    echo "$edited" >> /home/user/backup-report
    echo "$new" >> /home/user/backup-report
    echo "$upd" >> /home/user/backup-report
fi