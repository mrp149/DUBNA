#! /bin/sh
# Staging Lib23 sources in Dispak for the bootstrap  
# Copyright 2017, by Mikhail Popov
# staging Lib23 source code
set -x
# besm6/besm6.github.io/sources/dubna/besml23
REPO=`pwd`/../besml23/[ld]*.l23

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

# the source to be placed on tape 1223
# then do the default compilation with a listing 
rm -f $HOME/.besm6/1223
touch $HOME/.besm6/1223

cat > $TEMP << EOF
шифр 419999 зс5^
лен 50(1999-ЗП)^
лен 66(1223-ЗП)^
лен 41(2048)^
eeв1а3
*name LIB23-STAGE
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
*madlen(L=FBGR)
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
dispak -l $TEMP > lib23-base-src.list

if [ $? -ne "0" ]; then
   rm -f -- "$TEMP"
   trap - EXIT
   exit 1
fi 

rm -f -- "$TEMP"
trap - EXIT
exit 0
