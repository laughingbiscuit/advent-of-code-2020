#!/bin/sh

set -e 
INPUT=$(cat input.txt | tr '\n' '\r' | sed 's/\r\([^\r]\)/ \1/g' | tr '\r' '\n' | sed 's/^ //')
printf "%s\n" "$INPUT" > _formatted-input.txt

SUM=0
while read -r GROUP ; do
  SIZE=$(echo $GROUP | wc -w)
  ANSWERED=$(echo $GROUP | \
    grep -o '.' | \
    sort | \
    tr -d '\n' | \
    sed "s/\([a-z]\)$(seq $((SIZE -1)) | xargs -I{} echo -n "\1")/#/g" | \
    grep -o '#' | \
    wc -l )

  SUM=$((SUM + ANSWERED))
done < _formatted-input.txt
echo "Sum of counts: $SUM"
