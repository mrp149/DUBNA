#! /bin/sh
# Staging Lib21 sources in Dispak for the bootstrap  
# Copyright 2017, by Mikhail Popov
# staging Lib21 source code
set -x
# besm6/besm6.github.io/sources/dubna/besml21
REPO=`pwd`/../besml21/libra21[123].l21

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

# numbering the source and place it on tape 1221
# then do the default compilation with a listing 
touch $HOME/.besm6/1221

cat > $TEMP << EOF
шифр 419999 зс5^
лен 50(1999-ЗП)^
лен 66(1221-ЗП)^
лен 41(2048)^
eeв1а3
*name STL-2017
*      no list
*edit
*r:50100
*w:66100
*ee
*
*     The default compilation
*
*call putflag*
5
*madlen(l=fbgr)
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
dispak -l $TEMP > lib21-base-src.list

if [ $? -ne "0" ]; then
   rm -f -- "$TEMP"
   trap - EXIT
   exit 1
fi 

rm -f -- "$TEMP"
trap - EXIT
exit 0
