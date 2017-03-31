#! /bin/sh
#
#  Bootstrap sequence for OS Dubna in dispak
#
#  Copyright 2017, Mikhail Popov.  
#
# 03/03/2017:  
#
#  


set -x 

echo Populating disks in $HOME/.besm6

./populate-dsk.sh

echo Making disk images for SIMH
( cd data; ./mk-disk9.sh; ./mk-disk11.sh)

echo Build DD

mk-ld-src.sh

#echo Build MS

#./mk-ms-src.sh

echo Build LD

./mk-ld-src.sh

echo Making the patch deck and link DD
./mk-deck.sh

echo Run DEBMULT
./mk-debmult.sh

./besm6 -i first-ddboot.ini

echo The system is ready 
echo use besm6 -i ddubna.ini
echo Consul port 4199
