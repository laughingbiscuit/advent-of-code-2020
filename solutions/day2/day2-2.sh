#!/bin/sh

# Parse line

i=0 # valid password count

while read LINE; do
  PATT="/\(\d*\)-\(\d*\) \(.\): \(.*\)/"
  POS1=$(echo $LINE | sed "s$PATT\1/")
  POS2=$(echo $LINE | sed "s$PATT\2/")
  CHAR=$(echo $LINE | sed "s$PATT\3/")
  PASS=$(echo $LINE | sed "s$PATT\4/")

  #XOR
  ATT1=$(echo $PASS | cut -c$POS1 | grep -q "$CHAR" && echo Y)
  ATT2=$(echo $PASS | cut -c$POS2 | grep -q "$CHAR" && echo Y)
  test "$ATT1" != "$ATT2" && i=$((i+1))

done <input.txt

echo $i
