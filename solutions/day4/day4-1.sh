#!/bin/sh

INPUT=$(cat input.txt | tr '\n' '\r'  | sed 's/\r\([^\r]\)/ \1/g' | tr '\r' '\n')
printf " $INPUT\n" > _formatted-input.txt
C_VALID=0

while read LINE; do
  BYR=$(echo $LINE | grep -o "byr:\S*")
  IYR=$(echo $LINE | grep -o "iyr:\S*")
  EYR=$(echo $LINE | grep -o "eyr:\S*")
  HGT=$(echo $LINE | grep -o "hgt:\S*")
  HCL=$(echo $LINE | grep -o "hcl:\S*")
  ECL=$(echo $LINE | grep -o "ecl:\S*")
  PID=$(echo $LINE | grep -o "pid:\S*")
  
  test ! -z $BYR && \
    test ! -z $IYR && \
    test ! -z $EYR && \
    test ! -z $HGT && \
    test ! -z $HCL && \
    test ! -z $ECL && \
    test ! -z $PID && \
    C_VALID=$(($C_VALID + 1))

done < _formatted-input.txt

echo $C_VALID
