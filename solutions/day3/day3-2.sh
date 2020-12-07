#!/bin/sh

RESULTS=
RESULTS="$RESULTS $(X=1 Y=1 sh day3-1.sh)"
RESULTS="$RESULTS $(X=3 Y=1 sh day3-1.sh)"
RESULTS="$RESULTS $(X=5 Y=1 sh day3-1.sh)"
RESULTS="$RESULTS $(X=7 Y=1 sh day3-1.sh)"
RESULTS="$RESULTS $(X=1 Y=2 sh day3-1.sh)"

PRODUCT=1
for RES in $RESULTS; do
  PRODUCT=$(($PRODUCT * $RES))
done
echo $PRODUCT
