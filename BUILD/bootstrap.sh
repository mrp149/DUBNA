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


echo compile DD
rm -f $HOME/.besm6/1999
./mk-dd-src.sh

#echo Build MS
#rm -f $HOME/.besm6/1999
#./mk-ms-src.sh

echo compile STL
rm -f $HOME/.besm6/1999
./mk-stl-src.sh

echo compile LD
rm -f $HOME/.besm6/1999
./mk-ld-src.sh

echo "Making disk images for SIMH"
( cd data; ./mkdisk9.sh; ./mkdisk11.sh; ./mkbridges.sh)

echo "Making the patch deck"
touch $HOME/.besm6/1999

( cd deck-b1; ./mk-deck-b1.sh) > deck-b1.b6 

echo "Run DEBMULT"
touch $HOME/.besm6/1999
dispak -l debmult.b6 | tee /dev/tty > debmult.list

echo "Compiling the PATCH DECK ... and linking DD...."
dispak -l deck-b1.b6 | tee /dev/tty > deck-b1.list

echo "Making drum images for SIMH"
( cd data; ./mkdrumdd.sh)

echo "Copy libraries to build DD and STL in SIMH"
dispak -l tra-libs.b6 | tee /dev/tty > tra-libs.list

echo "All done and ready for the first boot!"
sleep 3

#besm6 -i first-dd-boot.ini
# first boot 
$SIMH/besm6 -i expect1.ini
# second boot
$SIMH/besm6 -i expect2.ini
cat ReadMeBoot.txt
