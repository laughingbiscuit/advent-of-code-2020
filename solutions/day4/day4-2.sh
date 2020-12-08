#!/bin/sh
set -e
INPUT=$(tr '\n' '\r' < input.txt  | sed 's/\r\([^\r]\)/ \1/g' | tr '\r' '\n')
printf " %s\n" "$INPUT" > _formatted-input.txt
C_VALID=0

while read -r LINE; do
  # extract
  BYR=$(echo "$LINE" | grep -o "byr:\S*" | sed "s/.*:\(.*\)/\1/")
  IYR=$(echo "$LINE" | grep -o "iyr:\S*" | sed "s/.*:\(.*\)/\1/")
  EYR=$(echo "$LINE" | grep -o "eyr:\S*" | sed "s/.*:\(.*\)/\1/")
  HGT=$(echo "$LINE" | grep -o "hgt:\S*" | sed "s/.*:\(.*\)/\1/")
  HCL=$(echo "$LINE" | grep -o "hcl:\S*" | sed "s/.*:\(.*\)/\1/")
  ECL=$(echo "$LINE" | grep -o "ecl:\S*" | sed "s/.*:\(.*\)/\1/")
  PID=$(echo "$LINE" | grep -o "pid:\S*" | sed "s/.*:\(.*\)/\1/")

# null checks
    if test -z "$BYR" || \
    test -z "$IYR" || \
    test -z "$EYR" || \
    test -z "$HGT" || \
    test -z "$HCL" || \
    test -z "$ECL" || \
    test -z "$PID"; then continue; fi

  
  # BYR - 4 digits between 1920 and 2002
  if echo "$BYR" | grep -oq '\d{4}'; then continue; fi
  if [ "$BYR" -lt 1920 ]; then continue; fi
  if [ "$BYR" -gt 2002 ]; then continue; fi

  # IYR - 4 digits between 2010 and 2020
  if echo "$IYR" | grep -o '\d{4}'; then continue; fi
  if [ "$IYR" -lt 2010 ]; then continue; fi
  if [ "$IYR" -gt 2020 ]; then continue; fi

  # EYR - 4 digits between 2020 and 2030
  if ! echo "$EYR" | grep -oE "^\d{4}$"; then continue; fi
  if [ "$EYR" -lt 2020 ]; then continue; fi
  if [ "$EYR" -gt 2030 ]; then continue; fi
  
  # HGT must be either cm or in
  if ! echo "$HGT" | grep -o '\d*cm\|\d*in' ; then continue; fi

  # HGT cm must be 150-193
  if echo "$HGT" | grep -o "\d*cm"; then
    VAL=$(echo "$HGT" | sed 's/\(\d*\)cm/\1/')
    if test "$VAL" -lt 150; then continue; fi
    if test "$VAL" -gt 193; then continue; fi
  fi
  
  # HGT inch must be 59-76
  if echo "$HGT" | grep -o "\d*in"; then
    VAL=$(echo "$HGT" | sed 's/\(\d*\)in/\1/')
    if test "$VAL" -lt 59; then continue; fi
    if test "$VAL" -gt 76; then continue; fi
  fi

  # HCL must be #[0-9a-f]{6}
  if ! echo "$HCL" | grep -oE "^#[0-9a-f]{6}$"; then continue; fi

  # ECL must be amb blu brn gry grn hzl oth 
  if ! echo "$ECL" | grep -o "amb\|blu\|brn\|gry\|grn\|hzl\|oth"; then continue; fi

  # PID must be a 9 digit number
  if ! echo "$PID" | grep -oE "^[0-9]{9}$"; then continue; fi

  C_VALID=$((C_VALID + 1))

done < _formatted-input.txt

echo $C_VALID
