#! /bin/sh
# Staging OS Dubna sources in Dispak for the bootstrap  
# Copyright 2017, by Mikhail Popov
# staging MS Dubna source code
set -x
# besm6/besm6.github.io/sources/dubna/besmmons
REPO=`pwd`/../besmmons/system*.txt

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

# the source to be placeed  on tape 1200
# then do the default compilation with a listing 
rm -f $HOME/.besm6/1200
touch $HOME/.besm6/1200

cat > $TEMP << EOF
шифр 419999 зс5^
лен 50(1999-ЗП)^
лен 66(1200-ЗП)^
лен 41(2048)^
eeв1а3
*name MS-2017
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
*      Have to use *FTN in Dispak
*ftn
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
dispak -l $TEMP > ms-base-src.list

if [ $? -ne "0" ]; then
   rm -f -- "$TEMP"
   trap - EXIT
   exit 1
fi 

rm -f -- "$TEMP"
trap - EXIT
exit 0
