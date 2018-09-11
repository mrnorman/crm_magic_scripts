#!/bin/bash

echo "Finding all occurences (not already re-dimensioned / indexed) of: $1"

for f in `crmfiles.sh` ; do
  #Find all occurences of unique variable name & exclude lines that are entirely comments
  grep -irnGH "[^a-zA-Z0-9_%]$1[^a-zA-Z0-9_%]" $f | grep -vG "$f\:[0-9]*\:[ \t]*!" | grep -vGi "$1[ \t]*(icrm," | grep -vGi "$1[ \t]*([^)]*icrm[ \t]*)"
  #Also include case where variable name starts on the first column in a line
  grep -irnGH "^$1[^a-zA-Z0-9_%]" $f | grep -vGi "$1[ \t]*(icrm," | grep -vGi "$1[ \t]*([^)]*icrm[ \t]*)"
  #Also include case where variable name ends the line
  grep -irnGH "[^a-zA-Z0-9_%]$1$" $f
done


