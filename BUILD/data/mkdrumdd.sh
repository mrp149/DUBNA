#! /bin/sh
# Make DRUM images
set -x 
# DRUMS 20, 21, 22, 23
# 20 -  DD
# 21,22 MS
# 23 DEBMULT 
dd if=$HOME/.besm6/1999 bs=8256 skip=4 of=./dubdrum00 seek=0 count=128
cat dubdrum00 dubdrum00 > dr00
ls -al dr00
cp dr00 dubdrum1.bin
cp dr00 dubdrum2.bin
ls -al dubdrum[12]*.bin
