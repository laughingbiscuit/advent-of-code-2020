#!/bin/sh

# Note - this is SUPER inefficient, but at least it works

INPUT=$(cat input.txt | tr '\n' '\r' | sed 's/\r\([^\r]\)/ \1/g' | tr '\r' '\n')
printf "%s\n" "$INPUT" > _formatted-input.txt

SUM=0
ALPHABET="a b c d e f g h i j k l m n o p q r s t u v w x y z"
while read -r GROUP ; do
  CHARS_SEEN_IN_GROUP=
  CHARS_MISSED_BY_SOMEONE_IN_GROUP=
  for PERSON in $GROUP; do
    for CHAR in $(echo $PERSON | sed 's/\(.\)/\1 /g'); do
      if ! echo $CHARS_SEEN_IN_GROUP | grep -q "$CHAR"; then 
        CHARS_SEEN_IN_GROUP="$CHAR $CHARS_SEEN_IN_GROUP"
      fi
    done
    for ALPHA in $ALPHABET; do
      if ! echo "$PERSON" | grep -q "$ALPHA"; then
        if ! echo "$CHARS_MISSED_BY_SOMEONE_IN_GROUP" | grep -q "$ALPHA"; then
          CHARS_MISSED_BY_SOMEONE_IN_GROUP="$ALPHA $CHARS_MISSED_BY_SOMEONE_IN_GROUP"
        fi
      fi
    done
  done
  ALL_QS=
  for CHAR in $CHARS_SEEN_IN_GROUP; do
    if ! echo "$CHARS_MISSED_BY_SOMEONE_IN_GROUP" | grep -q "$CHAR"; then
      ALL_QS="$CHAR $ALL_QS"
      SUM=$((SUM +1 ))
    fi
  done
done < _formatted-input.txt
echo "Sum of counts: $SUM"
