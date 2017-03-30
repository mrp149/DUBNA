#! /bin/sh
# Staging OS Dubna sources in Dispak for the bootstrap  
# Copyright 2017, by Mikhail Popov
# FORTRAN source code
set -x
# besm6/besm6.github.io/sources/dubna/besmtask
REPO=`pwd`/../besmtask/*.vv

TEMP=$(tempfile) || exit
trap "rm -f -- '$TEMP'" EXIT

(
cd spl;
echo loading sources form $TEMP
#./load $REPO
if [ $? -ne "0" ]; then
   rm -f -- "$TEMP"
   trap - EXIT
   exit 1
fi 

)

# numbering the source and place it on tape 1301
# then do the default compilation with a listing 
touch $HOME/.besm6/1301

cat > $TEMP << EOF
шифр 419999 зс5^
лен 50(1999-ЗП)^
лен 66(1301-ЗП)^
лен 41(2048)^
eeв1а3
*name exfor-2017
*      no list
*edit
*r:50100
*w:66100
*c All main source are numbered
*n:    0001
*ee
*
*     The default compilation
*
*call putflag*
5
*MADLEN(L=FBGR,I=66100)
*tcatalog
*to perso:66000,77
*       perso:66000
*madlen.
 SCANNER:,NAME,
  13,uj,
 ,bss, 511+128
 ,END,
 GIV*PG:,NAME,
 TAK*PG:,ENTRY,
 13,UJ,
 ,END,
 FORT2017:,NAME, 
 *CONSD :LC,BLOCK,(7)
   ,CONT,B21,B20,B16(6)
   ,CONT,C3,INT1(3),B24/22
   ,CONT,(10),B48(8),B30/16
 *CONSE:LC,BLOCK,(5),B6(28),B17/16
 NONDECL*:,LC,1
 FLGEX*:,LC ,1
 NOLISFL*:,LC,1
 FULISFL*:,LC,1
 EXFOR:,SUBP,
 ,uj,EXFOR
 ,END,
*main FORT2017
*execute
        programma
        end
*end file
\`\`\`\`\`\`
еконец
EOF

cat $TEMP
sleep 1

echo compiling ...
dispak -l $TEMP > exfor-base-src.list

if [ $? -ne "0" ]; then
   rm -f -- "$TEMP"
   trap - EXIT
   exit 1
fi 

rm -f -- "$TEMP"
trap - EXIT
exit 0
