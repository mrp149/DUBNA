  FOREWORD:,NAME,
C***********************************
C*    Памяти А.П. Сапожнилкова,    *
C*    cт.научного сотрудника,      *
C*    Отдела Вычислительной        *
C*    Математики, ЛВТА, ОИЯИ.      *
C*    За его неоценимый вклад      *
C*    в развитие мониторной и      *
C*    операционной системы Дубна   *
C*    и в разработку МКБ-8601Б.    *
C*              ****               *
С*    От коллег и товарищей.       *
C*                    2023-02-07   *
С***********************************
C***********  ИЮHЬ 1980. CAПOЖHИKOB.
C*
C*   И H И Ц И A T O P Ы   M O H И T O P A
C*   A TAKЖE MAШИHKA ДЛЯ ПEPEЗAГPYЗKИ OБOИX
C*   PEЗИДEHTOB.
C*
C*   ПPИ CБOPKE CИCTEMЫ  COLLECT  ПEPEПИШET
C*   HAC HA CBOE PAБOЧEE MECTO И ПEPEДACT
C*   YПPABЛEHИE HA  NEWMON.
C*   MЫ ПPИГOTOBИM HA MБ 07036 HOBЫЙ
C*   ИHИЦИATOP MOHИTOPA, HA 07037 -
C*   -HYЛEBOЙ ЛИCT PAБOTAЮЩEЙ CИCTEMЫ,
C*   И ЗAHOBO ПEPEГPYЗИM COLLECT.
C*
C*******************************************
C*
  MONCARD*:LC,BLOCK,MC*(25)
  MONCARD/:LC,BLOCK,MC/(14)
  KCOUNT*:LC,BLOCK,KC
  MAIN*:,LC,1
  RM*:,LC,1
C
C-----  ПAPAMETPЫ HACTPOЙKИ MOHИTOPA
C
   P0 :,EQU,423B.HAЧAЛO
  MAG*:,EQU,53401B.MAГAЗИH
  SYSP:,EQU,76000B.OБM.ЛИCT
C
  M1:,P/P,(MAG*)256
  M2:,P/P,(M1  )4
  M3:,P*P,(M2)60
  NS:,P/P,(SYSP)16
  P0*64:,P*P,(P0-1)64
  M/512:,P/P,(MAG*)512
C
  IR/MON:,EQU,377B.ФИKCИPOBAHO
  LENFW:,EQU,Z/COD-NIL
  K    :,EQU,P0-LENFW
C
C-----  Параметры настройки FORWORD
C
 Disp:,ifsne,D,DD**
C We are NOT on OS Dubna
 FBASE:,EQU,70000B
 ,else,
C We are on OS Dubna
 FBASE:,EQU,0
 Disp:,endif,
C
C.....  TPAДИЦИOHHЫЙ ИHИЦИATOP MOHИTOPA
C       COДEPЖИMOE ЯЧEEK  000-120 :
C
  NIL:,BSS,16B.
  *16:,Z00,P0*64
  2,Z00,MAG*-2
  *17:,,
  ,Z00,P0
  *20:,SJ,
     :,BSS,22B
  *43:,,
  ,Z00,SYSP
  *44:,Z00,M/512
  8,,P0
  *45:,010,NS.BOCCT.
  ,020,4.OБM.ЛИCTA
  *46:,,NS.CПACEHИE
  ,020,4.OБM.ЛИCTA
  *47:,010,NS
  ,021,.KAT.TEMPO
  *50:,,NS
  ,021,
  *51:,UJ,2120B.BXOД HД-70
  *52:,OCT,7727 0707.
  *53:,OCT,7727 0707.
  *54:,LOG,2104000.KOHEЦ TEMPO
  ,BSS,3
  *60:,014,NS
  ,021,7.KAT.PERM.
  *61:,014,NS.MECTO
  ,021,7.ЗAГPYЗЧИKA
  ,BSS,8
  *72:,OCT,7727 0707
  *73:,LOG,.LIBRARY
  *74:,LOG,0014 0100 0021 0006
  *75:,OCT,7727 0707.
  *76:,*67,106B+fbase
  *77:,SJ,
  *100:,*70,60B.HAЧAЛЬHЫЙ
       ,*70,50B.KATAЛOГ
       ,*70,107B.BPEMEHHOЙ
       ,*70,110B.БИБЛ.
  *104:15,VTM,MAG*
  ,*70,61B.
  *105:12,VTM,2."INITSYS"
  ,UJ,76B.
  *106:,Z00,112B.
  9,Z00,MAG*-1
  *107:,014,NS
  ,021,10B
  *110:,,NS
  ,021,1
  *111:,TEXT,8HMONITOR*
  *112:,XTS,111B
  ,UJ,SYSP
C...   B ДИCПAKE CЛИЗЫBAEM CEБЯ C 1 ЛИCTA
  *113:15,XTA,2112B.
  15,CTX,112B.
  15,VLM,2113B.
  ,XTA,7.N ЧИTAЛKИ
  ,ATX,75B.
  ,UJ,100B.
  :,BSS,2
  *120:15,VTM,-110B.DISPAC
  ,UJ,2113B.ENTRY
C
C============  KOHEЦ ===============
C
C
C
C.....   ИHИЦИATOP ИMEHИ Б.Б.CAXAPOBA:
C
  1,REL,RAPID
C
  RAPID:,XTA,S100
  ,ATX,100B
  15,VTM,MAG*
  ,*70,WRTRP
  ,XTA,M67
  ,CTX,17B
  ,*70,RP1
  ,*70,RP2
  ,*70,WM1
  ,*70,WM2
  ,XTA,M70
  ,CTX,777B
  12,VTM,2
  ,*50,70100B+27B.35 PEГ.
  ,ASN,64-33.БЫЛ ЛИ
  ,U1A,777B.OTЛAДЧИK
  ,UJ,17B
  M67:,*67,W67
  M70:,*70,IR/MON
  W67:,,777B
  9,Z00,MAG*-1
  RP1:,LOG,0014 0100 0021 0007
  RP2:,LOG,0014 0200 0021 0010
  WM1:,LOG,0000 0100 0021 0000
  WM2:,LOG,0000 0200 0021 0001
  WRTRP:,LOG,20 0000
  S100 :,LOG,
C
C******  BXOД ИЗ /MONTRAN ДЛЯ
C        CПACEHИЯ TPП И 0 ЛИCTA
C
  1,REL,RELOAD
C
  RELOAD:12,VTM,2
  ,*67,I/STOP
  ,*67,I/START
  I/START:,Z00,SWOP-NIL+fbase
  ,Z00,
  I/STOP:,Z00,SYS P
  ,Z00,1003B  . reset/mon
  SWOP:12,VTM,NAM1-NAM2
  ,*70,RTRP1
  ,XTA,17B
  ,ASN,64+30
  ,ATI,14
  14,UTM,-400B
  :,XTA,
  14,ATX,2400B
  14,VLM,*-1
  :13,VTM,2000B-2
  S/N:13,UTM,2
  13,XTA,
  ,U1A,*+1
  ,033,.БЯKA
  :12,AEX,NAM2
  ,U1A,S/N
  13,XTA,1
  12,ATX,NAM2
  12,VLM,S/N-1
  ,XTA,INFLOA
  ,WTC,INFLOAD*
  ,ATX,1.CTATИKA
  ,XTA,2100B
  ,ATX,S100
  ,XTA,GO
  13,VTM,RAPID-S100
  ,CTX,2100B
  FORM:13,XTA,S100
  ,UTC,S100-RAPID
  13,CTX,2340B
  13,VLM,FORM
  ,XTA,R/MON
  ,ATX,IR/MON+1024
  ,XTA,Z/COD
  14,VTM,1-K
  ROSP:14,ATX,P0-1
  14,VLM,ROSP
  12,VTM,25
  ,*70,SAVTRP
  ,WTC,RM
  ,XTA,3
  ,AOX,B48
  ,ATX,44B
  ,WTC,RM
  ,ATX,3
  ,XTA,47B
  ,XTS,60B.PEЖИM
  ,ATX,47B."PERMA"
  ,*70,SAVMON
  15,MTJ,2
  15,VTM,POIN+46
  ,STI,
  R*:,WTC,MC1*
  12,STX,-1
  12,UTM,-1
  12,VIM,R*
  12,VTM,14
  R/:,WTC,MC1/
  12,STX,-1
  12,UTM,-1
  12,VIM,R/
  ,WTC,NAM1
  12,VTM,
  12,STX,3
  12,STX,2
  12,STX,1
  12,STX,
  ,STX,73B
  ,STX,54B
  ,ATX,44B
  2,MTJ,15
  ,XTA,CODE
  ,WTC,MAIN
  ,STX,
  ,ATX,47B
  ,XTS,COL
  ,WTC,NAM2
  ,UJ,
  GO:1,VTM,340B
  1,UJ,
  RTRP1:,010,100B
  ,020,
  SAVTRP:,000,100B
  ,007,36B
  SAVMON:,000,
  ,007,37B
  R/MON:,014,
  ,021,36B.BPEMEHHO
  INFLOA:8,014,M1+M3
  ,021,101B
  CODE:,TEXT,8H********
  COL:,TEXT,8HCOLLECT
  NAM1:,TEXT,8HKCOUNT*
  MC1/:,TEXT,8HMONCARD/
  MC1*:,TEXT,8HMONCARD*
  RM  :,TEXT,8HRM*
  MAIN:,TEXT,8HMAIN*
  INFLOAD*:,TEXT,8HINFLOAD*
  NAM2:,TEXT,8HLOADANGO
  B48:,OCT,4
  POIN:,BSS,50.YKAЗATEЛИ
  Z/COD:,LOG,7727 0707 0000 0172
C
C******  BXOД ДЛЯ ПEPEГPYЗKИ PEЗИДEHTA
C
  NEW//MON:,ENTRY,
C
  ,REL,
C
  15,VTM,POIN
  ,XTA,44B
  ,XTS,54B
  ,XTS,73B
  14,VTM,-13
  13,VTM,-25
  ,XTS,KC
  ,XTS,KC+1
  ,XTS,MAIN*
  ,XTS,KC+3
  :14,XTS,MC/+13
   14,VLM,*
  :13,XTS,MC*+25
   13,VLM,*
  13,VTM,2
  12,VTM,NIL-Z/COD
  l1:,UTC,NIL
  13,XTA,
  13,UTM,1
  13,CTX,-1
  12,VLM,l1
 copyto:,ifsne,d,dd**
C M80: У нас нет другой возможности,
C как только копировать себя на FBASE
  13,VTM,2
  12,VTM,NIL-Z/COD
  l2:,UTC,NIL
  13,XTA,
  13,UTM,1
  ,utc,fbase
  13,CTX,-1
  12,VLM,l2
 copyto:,endif,
  ,XTA,
  ,ATX,1
 ,ifseq,d,dd**
  ,*72,=:1140370077
 ,endif,
  ,WTC,RM*+2
  15,VTM,
  1,VTM,RELOAD-NIL+fbase
  ,*70,61B
  ,XTS,111B
  1,UJ,
  ,END,
