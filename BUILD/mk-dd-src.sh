#! /bin/sh
# Staging OS Dubna sources in Dispak for the bootstrap  
# Copyright 2017, by M.Popov
#
set -x
# besm6/besm6.github.io/sources/dubna/besmdisp
REPO=`pwd`/../besmdisp/*.dd*

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

# numbering the source and place it on tape 1200
# then do the default compilation with a listing 
touch $HOME/.besm6/1201

cat > $TEMP << EOF
шифр 419999 зс5^
лен 50(1999-ЗП)^
лен 66(1201-ЗП)^
лен 41(2048)^
eeв1а3
*name DD-2017
*      no list
*edit
*r:50100
*w:66100
*c All main source are numbered
*n:  000001
*ee
*
*     The default compilation
*
*call putflag*
5
*MADLEN(L=FBG)
  FREQ300:,NAME,
  FREQ300:,STEXT,. *** ЧACTOTA = 300 ГEPЦ
COMMENTS ARE IN THE DD SOURCE CODE
  FREQ:,EQU,300
  B*START:,EQU,0
  ГMAC:,MACRO,KOП
  ,KOП,.HET ПPИOPИTETOB
  ГMAC:,ENDM,
  ,END,
*MADLEN(L=FBG,I=66100,SТЕХТ=FRЕQ300)
*tcatalog
*to perso:66000,77
*call pcatalog:66000
*end file
\`\`\`\`\`\`
еконец
EOF

cat $TEMP
sleep 1

echo compiling ...
dispak $TEMP > dd-base-src.list

if [ $? -ne "0" ]; then
rm -f -- "$TEMP"
trap - EXIT
exit 1
fi 

rm -f -- "$TEMP"
trap - EXIT
exit 0
