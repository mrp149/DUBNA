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


echo Build DD
rm -f $HOME/.besm6/1999
./mk-dd-src.sh

#echo Build MS
#rm -f $HOME/.besm6/1999
#./mk-ms-src.sh

echo Build LD
rm -f $HOME/.besm6/1999
./mk-ld-src.sh


echo Making disk images for SIMH
( cd data; ./mkdisk9.sh; ./mkdisk11.sh)

echo Making the patch deck
touch $HOME/.besm6/1999

( cd deck-b1; ./mk-deck-b1.sh) > deck-b1.b6 
echo compiling ... and linking ....
dispak -l deck-b1.b6 | tee /dev/tty > deck-b1.list


echo Run DEBMULT
touch $HOME/.besm6/1999
dispak -l debmult.b6 | tee /dev/tty > debmult.list

echo Making drum images for SIMH
( cd data; ./mkdrumdd.sh)

echo All done and ready for the first boot!
sleep 3

./besm6 -i first-dd-boot.ini

cat ReadMeBoot.txt
