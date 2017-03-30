#! /bin/sh
set -x

cat cat.d11 libr12.d11 libr37.d11 tail.d11 tail.d11 | dd bs=8256 count=1024 of=disk11.bin
ls -al disk11.bin
