#!/bin/sh

X=${X:-3}
Y=${Y:-1}
ROW=1
COL=1
FILE=input.txt
WIDTH=$(cat $FILE | tail -n 1 | wc -m)
COUNT=0

while [ $ROW -lt $(cat $FILE | wc -l )  ]; do
  ROW=$(($ROW + $Y))  
  COL=$(($COL + $X))
  if [ $COL -ge $WIDTH ]; then
    COL=$(($COL % $WIDTH ))
    COL=$(($COL + 1 ))
  fi
  CHAR=$(cat $FILE | sed "$ROW q;d" | cut -c "$COL")
  test "$CHAR" = "#" && COUNT=$((COUNT + 1))
done
echo $COUNT
