#!/bin/bash
if [ "$1" == "-h" ] ; then
    echo "Usage: `basename $0` reading_filename  writing_filename"
    exit 0
fi
while IFS= read -r line
do
  echo ${line// /_} >> "$2"
done < "$1"
