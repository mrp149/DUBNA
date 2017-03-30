#! /bin/sh
set -x 
# update catalogs on disk images
dd if=cat.d9 bs=8256 of=disk9.bin seek=0 count=4 conv=notrunc 
dd if=cat.d11 bs=8256 of=disk11.bin seek=0 count=4 conv=notrunc 
