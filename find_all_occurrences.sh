#!/bin/bash

[[ "$1" == "" ]] && exit -1

echo "Finding all occurences of: $1"

for f in `./crmfiles.sh` ; do
  #Find all occurences of unique variable name & exclude lines that are entirely comments
  grep -irnGH "[^a-zA-Z0-9_%]$1[^a-zA-Z0-9_%]" $f | grep -vG "$f\:[0-9]*\:[ \t]*!"
  #grep -irnGH "[^a-zA-Z0-9_]$1[^a-zA-Z0-9_]" $f | grep -vG "$f\:[0-9]*\:[ \t]*!"
  #Also include case where variable name starts on the first column in a line
  grep -irnGH "^$1[^a-zA-Z0-9_%]" $f
  #grep -irnGH "^$1[^a-zA-Z0-9_]" $f
  #Also include case where variable name ends the line
  grep -irnGH "[^a-zA-Z0-9_%]$1$" $f
  #grep -irnGH "[^a-zA-Z0-9_]$1$" $f
  #Also include case where variable name is the only thing on the line
  grep -irnGH "^$1$" $f
done


