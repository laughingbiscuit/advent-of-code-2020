#!/bin/sh

# its 1am, so i just want a dirty hacky solution so i can sleep

set -e

# get the line execution order and reverse it

ORDER="$(sh day8-1.sh | grep "Visited" | sed 's/Visited//' | tr ' ' '\n' | sed '/^$/d' | tac )"

echo "$ORDER" | while read LINE; do
  echo "Trying $LINE"
  cp input.txt _input.txt
  INPUT="$(cat _input.txt)"
  CMD=$(echo "$INPUT" | tail -n +"$LINE" | head -n 1)
  if echo "$CMD" | grep -o "jmp" ; then 
    sed -i "$LINE""s/jmp/nop/" _input.txt
  elif echo "$CMD" | grep -o "nop" ; then 
    sed -i "$LINE""s/nop/jmp/" _input.txt
  else
    continue
  fi
  RESULT=$(LINE=$LINE sh day8-1.sh)
  if echo "$RESULT" | grep -o "success"; then echo "$RESULT $LINE"; break; fi
done
