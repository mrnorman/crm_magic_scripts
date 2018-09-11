#!/bin/bash

echo "Re-dimensioning all single-line indexed occurences of: $1"

for f in `crmfiles.sh` ; do
  sed -i "s/\([^a-zA-Z0-9_%]$1[ \t]*([^)]*\))/\1,icrm)/gi" $f
  sed -i              "s/\(^$1[ \t]*([^)]*\))/\1,icrm)/gi" $f
  #sed -i "s/icrm,icrm,/icrm,/gi" $f
  #sed -i "s/icrm,ncrms,/ncrms,/gi" $f
done

