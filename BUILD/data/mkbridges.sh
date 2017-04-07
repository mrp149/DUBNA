#! /bin/sh
# Make BRIDGE devices
set -x 
# Make bridges to
# DISK9
if [ -f disk9.bin ]; then
   rm -f $HOME/.besm6/2209
   ln -s `pwd`/disk9.bin  $HOME/.besm6/2209
fi
# DISK11
if [ -f disk11.bin ]; then
   rm -f $HOME/.besm6/2211
   ln -s `pwd`/disk11.bin  $HOME/.besm6/2211
fi
# DISK24 
if [ -f disk24.bin ]; then
   rm -f $HOME/.besm6/2224
   ln -s `pwd`/disk24.bin  $HOME/.besm6/2224
fi

ls -al $HOME/.besm6/22*
