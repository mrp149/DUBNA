#! /bin/sh
set -x 
# retrieve catalog form the image
dd if=$HOME/.besm6/3000 bs=8256 skip=996 count=4 | od -c 
