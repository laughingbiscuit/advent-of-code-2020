#!/bin/sh

set -e

# Find three entries that sum to 2020 and multiple them together - small dataset so brute force

INPUT=$(cat input.txt)

for NUM1 in $INPUT; do
  for NUM2 in $INPUT; do
    for NUM3 in $INPUT; do
      test $(($NUM1 + $NUM2 + $NUM3)) -eq 2020 && echo "Result: $(echo "$NUM1 * $NUM2 * $NUM3" | bc)" && exit 0
    done
  done
done
