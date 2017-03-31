#! /bin/sh
# Poluplate disk images in Dispak for the bootstrap  
# Copyright 2017, by Mikhail Popov
set -x

mkdir $HOME/.besm6

# 9/monsys
touch $HOME/.besm6/9
besmtool write 9 --from-file=../monsys/monsys.9

# 12/librar
touch $HOME/.besm6/12
besmtool write 12 --from-file=../lib12/librar.12 

# 37/librar
touch $HOME/.besm6/37
besmtool write 37 --from-file=../lib37/librar.37 

# 3000

ls -al  $HOME/.besm6/
