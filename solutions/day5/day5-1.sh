#!/bin/sh

# Looks like binary to me
# R=1 L=0
# F=0 B=1

FILE=input.txt

MAX_ID=0

while read -r LINE; do
  ROW=$((2#$(echo $LINE | cut -c1-7 | tr 'F' '0' | tr 'B' '1')))
  COL=$((2#$(echo $LINE | cut -c8-10| tr 'L' '0' | tr 'R' '1')))
  ID=$(($ROW * 8 + $COL))
  if [ $MAX_ID -lt $ID ]; then MAX_ID=$ID; fi
done < $FILE

echo $MAX_ID
