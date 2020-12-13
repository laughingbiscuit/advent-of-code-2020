#!/bin/sh
set -e

FILE=$(cat input.txt)

getParentBags () 
{
  if [ -n "$1" ]; then
    echo "$FILE" | grep "$1" | sed 's/^\(.*\)contain.*$/\1/' | grep -v "$1" | sed 's/bag[s+]//' | \
      while read BAG ; do 
	echo $BAG
        getParentBags "$BAG"
      done
  fi
}

getParentBags "shiny gold" | sort | uniq | wc -l
