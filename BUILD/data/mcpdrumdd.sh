#! /bin/sh
set -x 
# it copies only DD image on drum 20 and prereserves all other traks
dd if=$HOME/.besm6/1999 bs=8256 skip=4 of=./dubdrum2.bin seek=0 count=32 conv=notrunc 
ls -al dubdrum[12].bin
