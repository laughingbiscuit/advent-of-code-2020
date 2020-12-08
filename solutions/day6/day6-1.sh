#!/bin/sh

INPUT=$(cat input.txt | tr '\n' '\r' | sed 's/\r\([^\r]\)/\1 /g' | tr '\r' '\n')
printf "%s\n" "$INPUT" > _formatted-input.txt

SUM=0
while read -r GROUP ; do
  QUESTIONS=$(echo $GROUP | sed 's/\(.\)/\1 /g' | tr ' ' '\n' | sort -i | uniq)
  for Q in $QUESTIONS; do
    SUM=$((SUM + 1))
  done
done < _formatted-input.txt
echo $SUM
