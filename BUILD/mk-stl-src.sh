#! /bin/sh
# Staging STL sources in Dispak for the bootstrap  
# Copyright 2017, by Mikhail Popov
# staging STL source code
set -x
# besm6/besm6.github.io/sources/dubna/besmtask
REPO=`pwd`/../besmtask/task??.ts[12]

TEMP=$(tempfile) || exit
trap "rm -f -- '$TEMP'" EXIT

(
cd spl;
echo loading sources form $TEMP
./load $REPO
if [ $? -ne "0" ]; then
   rm -f -- "$TEMP"
   trap - EXIT
   exit 1
fi 

)

# numbering the source and place it on tape 1247
# then do the default compilation with a listing 
rm -f $HOME/.besm6/1247
touch $HOME/.besm6/1247

cat > $TEMP << EOF
шифр 419999 зс5^
лен 50(1999-ЗП)^
лен 66(1247-ЗП)^
лен 41(2148)^
eeв1а3
*name STL-2017
*      no list
*edit
*r:50100
*w:66100
*d.*forex
*ee
*
*     The default compilation
*
*call putflag*
5
*      Compilation with forex3 on 2148
*ТRАNS:FОRЕХ3*,,411550
*read:66100 
*tcatalog
*to perso:66000,77
*end file
\`\`\`\`\`\`
еконец
EOF

cat $TEMP
sleep 1

echo compiling ...
dispak -l $TEMP > stl-base-src.list

if [ $? -ne "0" ]; then
   rm -f -- "$TEMP"
   trap - EXIT
   exit 1
fi 

rm -f -- "$TEMP"
trap - EXIT
exit 0
