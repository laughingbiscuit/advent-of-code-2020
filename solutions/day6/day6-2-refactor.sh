#!/bin/sh

# change the algorithm to avoid parsing the alphabet

INPUT=$(cat input.txt | tr '\n' '\r' | sed 's/\r\([^\r]\)/ \1/g' | tr '\r' '\n' | sed 's/^ //')
printf "%s\n" "$INPUT" > _formatted-input.txt

SUM=0
while read -r GROUP ; do
  FIRST=$(echo $GROUP | head -n 1 | sed 's/\(\S*\)\s.*/\1 /g')
  ALL_SELECTED=$(echo $FIRST | sed 's/\(.\)/\1=1 /g')
  GROUP_SIZE=$(echo $GROUP | wc -w)

  for PERSON in $(echo $GROUP | sed 's/$/ /' | sed 's/\s*[^ ]* //') ; do
    for CHAR in $(echo "$PERSON" | sed 's/\(.\)/\1 /g'); do
      if $(echo "$ALL_SELECTED" | grep -q "$CHAR" ); then
        CUR_COUNT=$(echo $ALL_SELECTED | grep -o "$CHAR=\S*" | sed "s/$CHAR=\(\d*\)/\1/")
        ALL_SELECTED=$(echo $ALL_SELECTED | sed "s/$CHAR=\S*/$CHAR=$((CUR_COUNT + 1))/")
      fi
    done
  done

  NUM=$(echo -n "$ALL_SELECTED" | grep -o ".=$GROUP_SIZE" | wc -l)
  SUM=$((SUM + NUM))
done < _formatted-input.txt
echo "Sum of counts: $SUM"
