#!/bin/sh

# Parse line

i=0 # valid password count

while read LINE; do
  PATT="/\(\d*\)-\(\d*\) \(.\): \(.*\)/"
  MIN=$(echo $LINE | sed "s$PATT\1/")
  MAX=$(echo $LINE | sed "s$PATT\2/")
  CHAR=$(echo $LINE | sed "s$PATT\3/")
  PASS=$(echo $LINE | sed "s$PATT\4/")

  OCCURANCES=$(echo -n $PASS | sed "s/[^$CHAR]//g" | wc -m)
  test $OCCURANCES -ge $MIN && test $OCCURANCES -le $MAX && i=$((i+1))
done <input.txt

echo $i
