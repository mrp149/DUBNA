#! /bin/sh
# Poluplate disk images in Dispak for the bootstrap  
# Copyright 2017, by Mikhail Popov
#
#  ReadMeTapes.txt file  contains more inforrmation
#
set -x

mkdir $HOME/.besm6

# 9
touch $HOME/.besm6/9
besmtool write 9 --from-file=../monsys/monsys.9

# 12
touch $HOME/.besm6/12
besmtool write 12 --from-file=../lib12/librar.12 

# 37
touch $HOME/.besm6/37
besmtool write 37 --from-file=../lib37/librar.37 

# 1990
touch $HOME/.besm6/1990

# 1999
touch $HOME/.besm6/1999

# 3000
touch $HOME/.besm6/3000

ls -al  $HOME/.besm6/
