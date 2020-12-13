#!/bin/sh

## note to self - this was the day that i learnt about the local keyword in /bin/sh

INPUT=$(cat input.txt)

getChildBags ()
{
  if [ -n "$1" ]; then
	  local QTY=$(echo "$1" | cut -d ' ' -f 1)
	  local BAG=$(echo "$1" | cut -d ' ' -f 2-)
	  echo "$QTY"
	  if [ "$QTY" -ne 0 ]; then
	    echo "$INPUT" | sed 's/bags\|bag\|no other\|\.//g' | grep "$BAG\s*contain" | sed 's/.*contain\s*//' | sed 's/\s*,\s*/\n/g' | while read SMALL_BAG ; do
	      local SMALL_QTY=$(echo "$SMALL_BAG" | cut -d ' ' -f 1)
	      local SMALL_TYPE=$(echo "$SMALL_BAG" | cut -d ' ' -f 2-)
	      getChildBags "$((SMALL_QTY * QTY)) $SMALL_TYPE"
      done
    fi
  fi
}
RESULT=0
VALS=$(getChildBags "1 shiny gold")
for VAL in $(echo "$VALS" | sed 's/\n/ /g'); do
  RESULT=$((RESULT + VAL))
done
echo $((RESULT -1)) # subtract the starting bag
