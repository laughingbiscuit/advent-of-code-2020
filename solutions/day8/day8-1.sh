#!/bin/sh
set -e

INPUT="$(cat _input.txt)"
ACC=0
LINE=${LINE:-1}
VISITED=

while [ true ]; do
  if echo "$VISITED" | grep -q " $LINE "; then echo "repeating $LINE"; break; fi
  if [ $LINE -gt $(echo "$INPUT" | wc -l) ]; then echo "success"; break; fi
  VISITED="$VISITED $LINE "

  CMD=$(echo "$INPUT" | tail -n +"$LINE" | head -n 1)
  INS=$(echo "$CMD" | cut -d ' ' -f 1)
  VAL=$(echo "$CMD" | cut -d ' ' -f 2-)
  if [ "$INS" = "acc" ]; then  ACC=$((ACC + VAL)); fi
  if [ "$INS" = "jmp" ]; then
    LINE=$((LINE + VAL))
  else
    LINE=$((LINE + 1))
  fi
done
echo "Visited $VISITED"
echo "ACC $ACC"
