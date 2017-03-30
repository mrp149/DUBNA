Cs
Cs  Params for Terminal lines  03/03/2017
Cs
 *TLSIZE:,NAME,
C
C*****   HACTPOЙKA ПO TEPMИHAЛAM
C           (PAЗMEPЫ БYФEPOB)
C
C-----   ДЛИHA KAPTЫ HAПPЯЖEHИЙ
  ,LOG,74
C-----   KOЛИЧECTBO ФИЗ.KAHAЛOB
  ,LOG,31
C-----   MAKCИMAЛЬHOE KOЛ-BO KOHCOЛEЙ
 ,LOG,2
C-----   KOЛ-BO TEPMИHAЛЬHЫX ПOДCИCTEM
 ,LOG,4
 ,END,
 *TLSYS:,NAME,
C
C*****   HACTPOЙKA ПO TEPMИHAЛAM
C         (OПИCAHИЯ ПOДCИCTEM)
C
C-----   COCTOЯHИE
C  PP.48/43 - Д H З  ПOДCИCTEMЫ
C  PP.42/19 - ШKAЛA ПPИBЯЗ. ФИЗ.KAHAЛOB
C  PP.18/17 - P E З E P B
C  PP.   16 - ИДET ЗAПYCK П/C
C  PP.15/01 - AДPEC CTPOЧHИKA П/C
C             ( 0 - CTAHДAPT )
 ,BSS,4
C-----   ПPИBЯЗKA
C  PP.48/37 - ШKAЛA ДOПYCTИMЫX ЛOГ.KAHAЛOB
C  PP.36/25 - ШKAЛA ПPИBЯЗ. ЛOГ.KAHAЛOB
C  PP.24/01 - ШKAЛA CTYЧAЩ. ФИЗ.KAHAЛOB
 ,OCT,6000.*=* CONS
 ,OCT,1774.*=* MULTI
 ,OCT,7774.*=* SCREEN
 ,OCT,7774.*=* MONITO
C-----   METKA BPEMEHИ + OTBЯЗKA
C  PP.48/25 - METKA BPEMEHИ ПO ФИЗ.KAHAЛAM
C  PP.24/01 - ШKAЛA OTBЯЗKИ ФИЗ.KAHAЛOB
 ,BSS,4
 ,END,
  *TLCONN:,NAME,
C
C*****   KOHCTAHTЫ ДЛЯ ПPИBЯЗKИ
C
C-----   KOДЫ ПPИBЯЗKИ K ПOДCИCTEMAM
C  PP.48/33 - 2 CИMBOЛA ДЛЯ ПPИBЯЗKИ,
C             B OБPATHOM ПOPЯДKE
C  PP.15/01 - HOMEP ПOДCИCTEMЫ
  ,ISO,6H '''''''''1'
  ,ISO,6H  '''''''1'
  ,ISO,6HTM'''''''1'
  ,ISO,6HPO'''''''0'
C
C
  MAIN*C:,ENTRY,
C
C*****   PAЗPEШEHИE ПPИBЯЗKИ K ПOДCИCTEMAM
C
C  PP.48/25 - ШKAЛA ФИЗ.KAHAЛOB, ДЛЯ KOTO-
C             PЫX ПPИBЯЗKA PAЗPEШEHA
C
C-----   OПEPATOPCKИE KOHCOЛИ
C  PP.15/01 - HOMEP ПEPBOЙ OПEPATOPCKOЙ
C             KOHCOЛИ ПO YMOЛЧAHИЮ
  ,OCT,70004000 000 00001
C
C-----   ДPYГИE ПOДCИCTEMЫ
C  PP.15/01 - HOMEPA ЗAДAЧ ДЛЯ STARTJOB
  ,OCT,77777777 00000005.  MT
  ,OCT,77777777 00000067.  ЭP
  ,OCT,77777777 00000002.
C
  ,END,
 *TLPRMT:,NAME,
C
C*****   HACTPOЙKA ПO TEPMИHAЛAM
C         ПAPAMETPЫ ФИЗ.KAHAЛOB
C
C        PAБOЧAЯ ЯЧEЙKA:
C
C    B MOMEHT ЗAГPYЗKИ - ЧACTOTA BPEMEHHЫX
C    ПPEPЫBAHИЙ, ДEЛEHHAЯ HA 150:
C    1 - 150 ГЦ,  2 - 300 ГЦ,  4 - 600 ГЦ,
C                10 - 1200 ГЦ.
  ,LOG,2
C    BO BPEMЯ PAБOTЫ - HOMEP KAHAЛA TИПA
C    TEKTRONIX (ФOPMИPYETCЯ П/П STARTDD).
C
C
C        MACKИ KAHAЛOB BBOДA И BЫBOДA:
C
C    48/25 P. MIN И MOT ДOЛЖHЫ COBПAДATЬ.
C    OHИ COOTBETCTBYЮT TИПAM KAHAЛOB:
C    48 P. - 1-Й KOHCYЛЬCKИЙ KAHAЛ,
C    47 P. - 2-Й KOHCYЛЬCKИЙ KAHAЛ,
C    46 - 31 P. - KAHAЛЫ MYЛЬTИПЛEKCOPA,
C    30 - 26 P. - ПOKA HE ЗAДEЙCTBOBAHЫ,
C    25 P. - KAHAЛ TИПA "TEKTRONIX".
C    "1" B 24/1 P. MIN COOTBETCTBYЮT
C    TEM PAЗPЯДAM TEЛEГPAФHOГO PEГИCTPA,
C    ПO KOTOPЫM ИДET BBOД.
C    "1" B 24/1 P. MOT COOTBETCTBYЮT
C    TEM PAЗPЯДAM TEЛEГPAФHOГO PEГИCTPA,
C    ПO KOTOPЫM ИДET BЫBOД.
C
C       MAKCИMAЛЬHOE ЧИCЛO KAHAЛOB - 24.
C
Cs  ,LOG,77770000 7777 0000. MIN
Cs  ,LOG,77770000 0000 7777. MOT
Cs Consuls and 12 serials
  ,LOG,60000000 7777 0000. MIN
  ,LOG,60000000 0000 7777. MOT
C
C     ДAЛEE  E,P,U-XAPAKTEPИCTИKИ TPEX ГPYПП
C     ПOCЛEДOBATEЛЬHO ПOДKЛЮЧEH. TEPMИHAЛOB.
C
C
C        XAPAKTEPИCTИKA E :
C        42/28 - ФAЗA OT CTAPTA KOHЦA CИMB.
C        24/1  - ШKAЛA KAHAЛOB ДAHHOГO TИПA
C                ( ПO BBOДY И BЫBOДY )
C
Cs ,LOG,777670 1700 1700
Cs ,LOG,777550 6077 6077
Cs SIMH serial  DNW!
  ,LOG,777670 7700 7700
  ,LOG,777550 0077 0077
 ,LOG,
C
C        XAPAKTEPИCTИKA P :
C        45/31 - HAЧAЛO CБOPKИ CИMBOЛA
C        30/16 - ШAГ ПO KAPTE HAПPЯЖEHИЙ
C        15/1  - KOЛИЧECTBO БИT CИMBOЛA
C
 ,LOG,77706 77705 77772
 ,LOG,77710 77706 77772
 ,LOG,
C
C        XAPAKTEPИCTИKA U :
C        45/31 - HAЧAЛO PAЗБOPKИ CИMBOЛA
C        30/16 - ШAГ ПO KAPTE HAПPЯЖEHИЙ
C        15/1  - OTHOCИT.ФAЗA KOHЦA CИMBOЛA
C
 ,LOG,77777 77777 77766
 ,LOG,77777 77776 77754
 ,LOG,
C
C     OПИCATEЛЬ MYЛЬTИПЛEKCOPA TEPMИHAЛOB
C
C      I.  0 - HET HИKAKИX MYЛЬTИПЛEKCOPOB
C
C     II.  MYЛЬTИПЛEKCOP ИBTAH.
C          ПOДKЛЮЧEHИE ПO 19 P. ПPП.
C          1-4  : MACKИ BBOДA/BЫBOДA
C          5-8  : ДOП.PEГИCTP ПPEPЫBAHИЙ
C
C    III.  MYЛЬTИПЛEKCOP  Г O И
C          ПOДKЛЮЧEHИE HA 12-11 P. ПPП.
C          HACTPAИBAETCЯ "1" B 48-47 PAЗPЯДAX.
C          (48P. COOTBETCTBYET 12 P.ПPП,
C           47P. COOTBETCTBYET 11 P.ПPП)
C          MACKA 12-11 P.ПPП OTKPЫBAETCЯ TOЛЬKO
C          ПPИ ЗAЖATOM 12-11 P. HA 6 TYMБЛ.PEГ.
C
  ,LOG,0  .!365
C
 ,END,
  *TLBUFI:,NAME,.БЫBШИЙ  C I N
C
C*****   HACTPOЙKA ПO TEPMИHAЛAM
C         OПИCAHИE ФИЗ.KAHAЛOB
C
C.....  ЯЧEЙKA 0 :
C       48:25 - ШKAЛA ФИЗ.KAHAЛOB, ДЛЯ
C         KOTOPЫX PAЗPEШEHA ПPИBЯЗKA K
C         "OPERTERM".
C       5:1   - HOMEP ГЛABHOЙ OПEPATOPCKOЙ
C         KOHCOЛИ ПPИ OTCYTCTBИИ HAБOPA
C         B 5:1 P. 2 TYMБЛEPHOГO PEГИCTPA.
C
Cs    0,LOG,60000300 000000 01
Cs  console open to all
    0,LOG,77777700 000000 01
C
C
C.....  ЯЧEЙKИ 1 - 24 : OПИCATEЛИ TEPM.KAHAЛOB
C        ( HACTPOEЧHЫE PAЗPЯДЫ  -  31:19  )
C
C PP.48/41 - BBEДEHHЫЙ CИMBOЛ
C    40/33 - ПPEДЫД.CИMBOЛ (HA CBOБ.KAHAЛE)
C    40/36 - PEЗEPB (HA ПPИBЯЗ.KAHAЛE)
C    40/37 - KOД CЛYЖ.ПOЛYБAЙTA ДЛЯ MPX
C    35/33 - HOM.ПOДCИCT.(HA ПPИBЯЗ.KAHAЛE)
C            0 = OPERTERM
C            1 = MULTITYP
C            2 = ЭKPAHHЫЙ PEДAKTOP
C            3 = MOHИTOP ПOДCИCTEM
C       32 - ECTЬ CИMBOЛ (ДЛЯ BINARY-INPUT)
C       31 - ECTЬ "ЗBOHOK"
C       30 - HYЖHA ЗAДEPЖKA ДЛЯ ROLL
C       29 - БЛOKИPOBKA PEГEHEPAЦИИ
C       28 - CИMBOЛ "LF" ДOПOЛHЯTЬ "CR"
C       27 - HET ПEPEKOДИPOBKИ BBOДA
C       26 - HET ПEPEKOДИPOBKИ BЫBOДA
C       25 - ПPИЗHAK CИHXPOHИЗAЦИИ KAHAЛA
C    24/22 - TИП TEPMИHAЛA
C            0 = VT-340
C            1 = CETEBOЙ (KOД ASCII)
C            2 = KOHCYЛ
C            3 = VDT-52130
C            4 = 15-ИЭ (ЭЛEKTPOHИKA)
C    21/19 - TИП ФИЗИЧECKOГO KAHAЛA
C            0 = ПOCЛEДOBATEЛЬHЫЙ KAHAЛ
C            1 = KOHCYЛ
C            2 = BИДEOTOH/KOHCYЛ
C            4 = KAHAЛ ПЭM-2
C       18 - PEЗEPB
C       17 - BЫB.PEГИCTP 15-ИЭ
C       16 - BB.PEГИCTP 15-ИЭ
C            БЫЛ "ESCAPE" (VDT-52130)
C     15/1 - AДPEC OПИCATEЛЯ BИPT.KAHAЛA
C
C*****   CTPYKTYPA OПИCATEЛЯ BИPTYAЛЬHOГO
C                    KAHAЛA
C
C    0 = LJOB - ЗAKAЗ HA PAБOTY
C               И COCTOЯHИE ЗAKAЗA.
C    P.48 - HAЧAЛO PAБOTЫ ПO JOB
C      47 - "LF" ПO HAЧAЛY CTPOKИ
C      46 - "CUP" ПO HAЧAЛY CTPOKИ
C      45 - "EOT" (ПEPEXOД HA BBOД)
C      44 - OБPAБOTKA INSERT CHAR.
C      43 - OБPAБOTKA DELETE CHAR.
C      42 - BBOД/BЫBOД CTPOKИ
C      41 - ЗAKAЗ HA OTBЯЗKY
C      40 - ГEHEPAЦИЯ COБЫTИЯ ПOДCИCTEME
C      39 - PEЗEPB
C      38 - CTOПOP BЫBOДA (БЫЛ CNTR/S)
C      37 - ПPИЗHAK BEДEHИЯ TAЙMEPA
C      36 - ПPИЗHAK BBOДA
C      35 - ПPИЗHAK ЗACEKPEЧИBAHИЯ "*"
C      34 - ЗAKOHЧEHA PAБOTA ПO CTPOKE
C      33 - ПPEPBAH BЫBOД,
C           ЛИБO CPAБOTAЛ TAЙMEP HA BBOДE
C      32 - ЛOПHYЛA ДЛИHA CTPOKИ
C      31 - PEЗEPB
C      30 - PEЗEPB
C      29 - БЛOKИPOBKA PEГEHEPAЦИИ ПPИ BBOДE
C      28 - ПPИЗHAK "ПPOЗPAЧHOГO" BBOДA
C      27 - PEЗEPB
C      26 - PEЗEPB
C      25 - ПPИЗHAK HEПYCTOГO BBOДA
C      24 - ПPИЗHAK ПEPEПOЛHEHИЯ CЧETЧИKA
C      23/16 - TEK.CЧETЧИK CИMBOЛOB
C      15/1  - TEK.AДPEC ПO БYФEPY BB/BЫB.
C
C    1 = MSK - MACKA ПOЗИЦИИ CИMBOЛA B TEK.
C              CЛOBE БYФEPA BBOДA/BЫBOДA
C
C    2 = XNT - CCЫЛKA HA ФИЗ. KAHAЛ
C       48/41 - TEK.TAЙMEP ПPИ BBOДE
C       40/33 - HAЧ.TAЙMEP HA BBOД CИMBOЛA
C       32/21 - PEЗEPB
C       20/16 - HOMEP ЛOГИЧECKOГO KAHAЛA
C       15/01 - HOMEP ФИЗИЧECKOГO KAHAЛA
C
C    3 = OWNER - BЛAДEЛEЦ KAHAЛA
C       48/43 - ДHЗ, ПOДABШEЙ ЭKCTPAKOД
C       10/01 - HOMEP PASS ПOЛЬЗOBATEЛЯ
C
C    4 = WSC - PAБOЧAЯ ЯЧEЙKA ДЛЯ PEAЛИЗAЦИИ
C              "IC" И "DC"
C       ПOCЛE OTPAБOTKИ ЗAKAЗA:
C       8/1 - CИMBOЛ OKOHЧAHИЯ BBOДA, ЛИБO
C             CИMBOЛ ПEPEБИBKИ BЫBOДA.
C
C    5 = ... - "-1" ЯЧEЙKA CTPOKИ
C
C    6 = STRI(14) - БYФEP BBOДA.
C        OПEPAЦИИ "IC" И "DC" PEAЛИЗYЮTCЯ
C        TOЛЬKO B ПPEДEЛAX ЭTOГO БYФEPA.
C
C        БYФEP BЫBOДA MOЖET PACПOЛAГATЬCЯ
C        B ДPYГOM MECTE.
C
C
C=====   HACTPOЙKA ПO TИПAM TEPMИHAЛOB
C
C---  KOHCYЛЫ
  1,LOG,0001 000000.VT-CONS 1
  2,LOG,0001 000000.VT-CONS 2
C---  MYЛЬTИПЛEKCOP ИBTAH
  3,LOG,0000 000000.CETЬ-0
  4,LOG,0000 000000.CETЬ-1
  5,LOG,0000 000000.CETЬ-2
  6,LOG,0000 000000.CETЬ-3
  7,LOG,0000 000000.CETЬ-4
  8,LOG,0000 000000.CETЬ-5
  9,LOG,0000 000000.CETЬ-6
 10,LOG,0000 000000.CETЬ-7
 11,LOG,0000 000000.CETЬ-8
 12,LOG,0000 000000.CETЬ-9
C---  TEЛEГPAФHЫЙ PEГИCTP
 13,LOG,0000 000000.VT-340
 14,LOG,0000 000000.VT-340
 15,LOG,0000 000000. V D T
 16,LOG,0000 000000.VT-340
 17,LOG,0000 000000.---"---
 18,LOG,0000 000000.---"---
 19,LOG,0000 000000.---"---
 20,LOG,0000 000000.---"---
 21,LOG,0000 000000.---"---
 22,LOG,0000 000000.---"---
 23,LOG,0000 000000.---"---
 24,LOG,0000 000000.---"---
 ,END,
 TERM*LOC:,NAME,
C
C*****   OПИCAHИE ЛOKAЛИЗAЦИИ TEPMИHAЛOB
C        ( ":" - 300 ГЦ.,  ";" - 150 )
C
  01,ISO,12HMAШ.ЗAЛ-1  :
  02,ISO,12HMAШ.ЗAЛ-2  :
    ,ISO,12H CETEBOЙ-0 :
    ,ISO,12H CETEBOЙ-1 :
    ,ISO,12H CETEBOЙ-2 :
    ,ISO,12H CETEBOЙ-3 :
    ,ISO,12H CETEBOЙ-4 :
    ,ISO,12H CETEBOЙ-5 :
    ,ISO,12H CETEBOЙ-6 :
    ,ISO,12H CETEBOЙ-7 :
    ,ISO,12H CETEBOЙ-8 :
    ,ISO,12H CETEBOЙ-9 :
Cs  ,BSS,2.CBOБOДHЫЙ
Cs  ,BSS,2.CBOБOДHЫЙ
  12,ISO,12H TEST1     :
  11,ISO,12H TEST2     :
  10,ISO,12HMEЖДYHOГYC :
   9,ISO,12HMOCЭHEPГO  :
   8,ISO,12H/KOMH-229/ : . МИКРО-БЭСМ, ВСЕ
   7,ISO,12HЗAЛ БЭCM-6 : . ЕМЕЛИН, КАДЫКОВ 
   6,ISO,12H   KAДPЫ   :
   5,ISO,12HA T C  OИЯИ:
   4,ISO,12HЗAЛ БЭCM-6 :
   3,ISO,12HY ПPИXOДЬKO: . КИМ
   2,ISO,12HЗAЛ BB/BЫB :
   1,ISO,12HCИTHИK(ЛBЭ):
C
C....  ECЛИ HAДO, CДEЛAЙTE ЗДECЬ
C      TAKOЙ ЖE CПИCOK ДЛЯ ЭBM-2
C      И HE ЗAБYДЬTE ПPO WHO/USER !
C
 ,END,
