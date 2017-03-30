Cs
Cs Global System Settings      03/03/2017
Cs  
 *DRUMBAS:,NAME,
C      PP 12-7 YKAЗATEЛЬ MБ
C      PP 6-1 HAЧAЛЬHЫЙ N TPAKTA
C         ДЛЯ ЗAПИCИ ДИCПETЧEPA
C
C      BAPИAHT ДЛЯ ЗAГPYЗKИ HA ЛEHTY:
C      ,LOG, S DD00 TTZZZ
C      ЗДECЬ TTZZZ - YKAЗATEЛЬ MЛ
C            DD - БAЗOBЫЙ БAPAБAH
C            S=1 - BMECTE C CИCTEMOЙ
C            S=0 - TOЛЬKO ДИCПETЧEP
C
Cs ,LOG,2500
 ,LOG,12000 67000
 ,END,
 EXCHNRS:,NAME,
C     PP 13-18 YKAЗATEЛЬ MБ
C     PP 1-5 HAЧAЛЬHЫЙ N TPAKTA
C     ДЛЯ HEPEЗИДEHTA MYЛЬTИTAЙПA
C        ,014,100B
C        ,025,37B
C     B CЛYЧAE ЗAГPYЗKИ HA ЛEHTY
C     39-Й PAЗPЯД = 0,  1-24 HE CYЩECTBEHHЫ
C
  ,010,100B
  ,,
 ,END,
 *ПДИCK:,NAME,.
C
C---  B 1-4 БAЙTAX ЭTOГO CЛOBA
C     ( CЧИTAЯ CЛEBA HAПPABO )
C   8-Й БИT COOTBETCTBYET 1-MY HAПPABЛ.
C   7-Й       --""--      2-MY  --""--
C     . . . . . . . . . . . . .
C   3-Й БИT   --""--      6-MY HAПPABЛ.
C
C---  HAЗHAЧEHИE БAЙTOB :
C   1 - ШKAЛA HAПPABЛEHИЙ KBY MЛ
C   2 - ШKAЛA HAПPABЛEHИЙ ДИCKOB
C   3 - ДИCKИ 29 MEГAБAЙT
C   4 - ДYБHEHCKИЙ KMД-29
C   5 - ПYCTOЙ БAЙT (OБЯЗATEЛЬHO)
C   6 - KOЛИЧECTBO ЭKCTEHTOB ДЛЯ
C       MOДEЛИPOBAHИЯ MБ.
C
C   ECЛИ 3-E HAПPABЛEHИE MД = OБЩEE,
C   ДOБABЬTE 34 БИT;
C   ECЛИ 4-E HAПPABЛEHИE MД = OБШEE,
C   TO ДOБABЬTE 33 БИT.
C
  ,ISO,6H'054''060''020''020''''37'
C
C... B ДYБHE HET 4 HAПP.KBY MЛ
C    A ДИCKИ B 3 И 4 HAПPABЛ.
 ,END,.
 *DISCS:,NAME,.
  DNAM:,BSS,16.ИMEHA ДП
  :,BSS,16.PEЗEPB
  ШMOД:,OCT,7777 74.ШK.BOЗM.MOДEЛEЙ MЛ
  ШФЛД:,OCT,.    ШK.PEAЛЬHЫX MOДEЛEЙ
 ,END,.
  TYPE MT:,NAME,
C*
C***  ПOДKЛЮЧEHИE MAГHИTOФOHOB
C*
C*  1. 4 CЛOBA COOTBETCTBEHHO ЧETЫPEM
C*    KBY-HAПPABЛEHИЯM MЛ  ( 4 ГPYППЫ
C*    KOMAHД ДBИЖEHИЯ ) :
C*     1-6  : AДPECA CЛYЖ.CЛOB OБMEHA
C*      44  : ЗHAЧEHИE 11 PAЗPЯДA KYC-A
C*    47-48 : TИП MAГHИTOФOHOB :
C*        0 : HMЛ БЭCM-6
C*        1 : EC5012 C ДYБHEHCKИM KMЛ
C*        2 : EC5017 C ДYБHEHCKИM KMЛ
C*        3 : EC5017 C ЗABOДCKИM  KMЛ
C*
  KBY:,LOG,00000 00000 000040.3-5012
     :,LOG,60.4-CDC405,608
     :,LOG,00000 00000 000050.5-5012
     :,LOG,60.6-БЭCM
C*
C*  2. ПPИЗHAK HAЛИЧИЯ (БИT2) ИЛИ OTCYTCTBИЯ
C*     (0) CDC-405.  ФAKTИЧECKИ - ПPИЗHAK
C*     POДHOЙ ДYБHEHCKOЙ ФИPMЫ :
C*
   FL405:,LOG,0. !ECTЬ
C*
C*  3. ПPИЗHAK ФИKCИPOBAHHOЙ (БИT48)
C*     ПЛOTHOCTИ ПPИ PAБOTE C MЛ EC
C*     И EE ЗHAЧEHИE (11-10 БИTЫ) :
C*
   FIXDENS:,LOG,.HE ФИKCИPOBAHO
C*
C*  4. AДPEC B KOMAHДE OПPOCA БAYC-5 (1-15)
C*     И ЧИCЛO CДBИГOB BПPABO (48-42)  :
C*
   БAYC:,OCT,4600 0000 0000 4011.CД=12
C       ДЛЯ ЗABOДCKOГO KBY EC :
C      ,OCT,4000 0000 0000 4012.5017
C*
C*  5. ШKAЛA БЛOKИPOBOK OПOЗHABAHИЯ ЛEHT
C*     48:16  - MФ 30:67
C*
  NORECTP:,LOG,
  ,END,
 *TYPELP:,NAME,
C
C*****   P.40 - ЭKOHOMИЯ БYMAГИ (AЦПY 0)
C*****   P.39 - ЭKOHOMИЯ БYMAГИ (AЦПY 1)
C*****   P.16 - HET ЭKOHOMИИ БYMAГИ CИCTEMOЙ
C*****   P.04 - BOЗMOЖHA EC ПEЧATЬ(KAHAЛ 0)
C*****   P.03 - BOЗMOЖHA EC ПEЧATЬ(KAHAЛ 1)
C*****   P.01 - БЛOKИPOBKA KOHTPOЛЯ ЛИMИTA БYMAГИ
 ,LOG,14
C
C*****   CTAHДAPT.KOЛ-BO ПPOTЯЖEK + 1
C*****   (ПPИ ЭKOHOMИИ БYMAГИ)
 ,LOG,5
C
C*****   БЫCTPЫЙ/ЧECTHЫЙ ПPOГOH БYMAГИ
C*****   (B KOMMEHTAPИЯX - БЫCTPЫЙ)
 ,LOG,0
 ,LOG,10.CTD = 10
C***** CTAHД.ЛИMИT БYMAГИ
  ,LOG,1 0000 0000
 ,END,
 *KOHCTPA:,NAME,
C     BИT ЧTEHИЯ И HOMEP KOHTPOЛЬHOЙ
C     CTPAHИЦЫ B ФOPME KYCA, ECЛИ HY-
C     ЖEH KOHTPOЛЬ ЗAПИCИ HA MБ.
 ,LOG,4040 0000.0-Я CTP. 2-ГO MOЗY
 ,END,
 *LINKPAR:,NAME,
C ---   ШKAЛA ЛИHИЙ CBЯЗИ
 ,LOG,377.SC/NL
C ---   ШKAЛA ЛИHИЙ CBЯЗИ TASK70
 ,LOG,200.SC/CONC
C ---   BPEMEHA OTBETOB
C ---   24-13 -> ПYCП. 12-1 -> BЗBП
 ,LOG,0140 0300.EC1010 ЛBTA
 ,LOG,2000 2000.
 ,LOG,60 0060.MИKPOПPOЦ.
 ,LOG,1000 1000.M6000 ЛBTA
 ,LOG,2000 2000.
 ,LOG,2000 2000.
 ,LOG,2000 2000.
 ,LOG,2000 2000.
 ,END,
     TYP/PL:,NAME,
C
C  TИПЫ ЛEHTOЧHЫX ПEPФOPATOPOB
C  ИX M.Б. TOЛЬKO ДBA: 0-1
C
C  48-47  '1' - ПЛ-80, '0' - ПЛ-20
C  42-41  '1' - ДYБH.CПOCOБ ПOДKЛЮЧ.ПЛ-80
C         '0' -   ФPЯЗИHCKИЙ
C
  ,OCT,602.2 ПЛ-80
C   PAЗPЯДЬ  2-1  -TИП ПЛ-BBOДA 0-1:
C  '1' OЗHAЧAET BHИЭM,'0' - FSM-1500.
 COPY7:,BSS,
C.....   ПPOГPAMMHAЯ KOПИЯ TP7
C      32 P.- БЛOKИPOBKA ЗAПИCИ DAYFILE
C   26/25 P.- ПPИЗHAK HAЛИЧИЯ YBBK 0/1
C       1 P.- BBOД ПO ГOTOBHOCTИ YCTPOЙCTBA
  ,LOG,3 0000 0000.YBBK
  ,END,
