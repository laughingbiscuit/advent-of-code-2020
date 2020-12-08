#!/bin/sh

FILE=input.txt
IDS=
while read -r LINE; do
  ROW=$((2#$(echo "$LINE" | cut -c1-7 | tr 'F' '0' | tr 'B' '1')))
  COL=$((2#$(echo "$LINE" | cut -c8-10| tr 'L' '0' | tr 'R' '1')))
  ID=$((ROW * 8 + COL))
  IDS=$(printf "%s\n%s" "$ID" "$IDS")
done < $FILE

SORTED_IDS=$(echo "$IDS" | sort -g)
INDEX=1
MAX=$(echo "$SORTED_IDS" | wc -w)
while [ "$INDEX" -lt "$MAX" ]; do
  CUR_SEAT=$(echo "$SORTED_IDS" | tail -n+$INDEX | head -n1) 
  NEXT_INDEX=$((INDEX + 1))
  NEXT_SEAT=$(echo "$SORTED_IDS" | tail -n+$NEXT_INDEX | head -n1) 
  EXP_NEXT_SEAT=$((CUR_SEAT + 1))
  if [ "$NEXT_SEAT" -ne "$EXP_NEXT_SEAT" ]; then echo $EXP_NEXT_SEAT; break; fi
  INDEX=$((INDEX + 1))
done
