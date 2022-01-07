#!/bin/bash

fileType() {
    echo $(find $1 -type f -name "$2")
}

videoRename() {
    for file in $(fileType "." "*.mp4"); do
        if [ -f ./$file ]; then
            newName=$(echo $file | awk -F/ '{print $2}' | awk -F. '{print $1" "$2" "$3"."$NF}')
            echo $newName
            mv $file "./$newName"
        fi
    done
}

srtRename() {
    for file in $(fileType "./*/*/" "*_English.srt"); do
        if [ -f ./$file ]; then
            newName=$(echo $file | awk -F/ '{print $3}' | awk -F. '{print $1" "$2" "$3}')
            fileNo=$(echo $file | awk -F/ '{print $NF}' | awk -F_ '{print $1}')
            mv $file "./$newName-$fileNo.srt"
        fi
    done
}

videoRename
srtRename
rm *.txt
rm -r ./Subs
