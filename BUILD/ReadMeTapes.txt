# OS Dubna Bootstrap in Dispak
# Assumptions and requisitions 
#
# Copyright, 2017 by Mikhail Popov 
# 
# Rev A. 2017/03/03
# Rev B. 2017/03/27
#
##### TAPE NUMBERS AND FORMATS
#
### TAPE LABELS:
# The following tape labels are fixed in OS Dubna
# these lebels are for labeled (named) tapes models 
# on system disks

# Allocations in DD:

 1/ROLLIB    - roll tracks
 1/D73INP    - input buffer
 3/D73OUT    - output buffer
 5/D73LIB    - STL
 6/D73STA    - system logs and statisitc
 7/M         - Multitype
 8/CATALO    - grafor buffer
 9/MONSYS    - system objects
10/USESTA    - user logs and statistic
11/LINBUF    - screen editid buffers	
12/LIBRAR    - library objects
37/LIBRAR    - library objects

# Allocations in MS (library tapes)
 8/CATALO
 9/MONSYS
12/LIBRAR
37/LIBRAR

#
### THE FOLLLOWING IS CORREPONDING TO TAPE NUMBERS:
# Please NOTE, the FIXED TAPE NUMBERS are used in
# the bootstrap sequence and scripts. All tapes are 
# generated during the bootstrap and in used by the
# bootstrap scripts.
# 
# All tapes have the following format:
#-----------------------------------
#   ZONE  | CONTENT
#-----------------------------------
# 00 - 77 | perso of the compiled source
#     100 | sources in the cosy format
#----------------------------------- 
# Pre-fixed tape number ranges in DD bootstrap
#
#    1- 999 Original tapes  
# 1000-1199 Compilers
# 1200-1399 Monitor System (MS) & libraries
# 1400-1899 OS Dubna Dispatcher (DD)
# 1900-1999 Temp/Scratch tapes 
# 2200-2299 Bridge tapes DISPAK/SIMH

## original tape images (as is)
#
   9 - monsys-9
  12 - librar-12
  37 - librar-37

## 1000-1199 Compilers
#
1000 - Мadlen
1100 - loader

## 1200-1399 Monitor System (MS) & libraries
#
1200 - Мониторная Система
1211 - task11+task47 (compilation in FOREX-3)
1221 - libra21 
1223 - libra23 (compilation in FOREX-3)
1247 - task47	
1300 - exfor - not used (partial source code)

## 1400-1899 OS Dubna Dispatcher (DD)
#
1400 - Диспетчер
1500 - macro67.dd1   - not used
1600 - tasksav.dd2   - not used
1700 - nrespost.dd3  - not used
1800 - sluga.dd4     - not used
1899 - extold        - not used

## 1900-1999 Temp/Scratch tapes
1900 -
1990 -
1999 - the scratch tape for the source uploading

## 2200-2299 Bridge tapes
#
2209  - disk9    - 7Mb system disk
2211  - disk11   - 7Mb library disk
2224  - disk24   - 7Mb source code DD,MS,STL disk
