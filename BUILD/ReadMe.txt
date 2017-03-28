# OS Dubna Bootstrap in Dispak
# Assumptions and requisitions 
#
# Copyright, 2017 by M.Popov 
# 
# Rev A. 2017/03/03
# Rev B. 2017/03/27
#
##### TAPE NUMBERS AND FORMATS

#
### TAPE LABELS:
# The following tape labels are fixed in OS Dubna
# these lebels can be labeldd tapes or named tape 
# models on disk.

# Allocations in DD:

 1/ROLLIB    - roll tracks
 1/D73INP    - input buffer
 3/D73OUT    - output buffer
 5/D73LIB    - STL
 6/D73STA    - system logs and statisitc
 7/M         - Multitype
 8/CATALO    - grafor out buffer
 9/MONSYS    - system objects
10/USESTA    - user logs and statistic
11/LINBUF    - screen editid buffers	
12/LIBRAR    - library objects
37/LIBRAR    - library objects

# Allocations in MS

# Library tapes:

 5/LIBRAR
21/LIBRAR
22/LIBRAR
23/LIBRAR
25/LIBRAR
37/LIBRAR

#
### THE FOLLLOWING IS CORREPONDING NUMBERS IN DISPAK:
# Please NOTE, the FIXED TAPE NUMBERS are used in the
# bootstrap sequence and scripts. All these tapes are 
# generated during the bootstrap and in used by the
# bootstrap scripts.
# 
# All generated tapes have the following format:
#-----------------------------------
#   ZONE  | CONTENT
#-----------------------------------
# 00 - 77 | perso of the compiled source
#     100 | sources in the cosy format and numbered
#----------------------------------- 
# Pre-fixed tape number ranges in the DD bootstrap
#
#    1- 999 Original tapes  
# 1000-1199 Compilers
# 1200-1399 The Monitor System (MS) & libraries
# 1400-1899 OS Dubna Dispatcher (DD)
# 1900-1999 Temp/Scratch tapes 

# original tape images (as is)
   9 - monsys-9
  12 - librar-12
  37 - librar-37

# Compilers
1000 - Мadlen-2
1100 - loader

# MS
1200 - Мониторная Система
1201 - Мониторная Система (orig)
1211 - task11  (!compilation errors in FOREX)
1221 - libra21 
1223 - libra23 (!compilation errors in FOREX)
1247 - task47
1300 - exfor

# DD
1400 - Диспетчер
1401 - Диспетчер (orig)
1500 - macro67.dd1
1600 - tasksav.dd2
1700 - nrespost.dd3
1800 - sluga.dd4
1899 - extold 

# Scratch
1900 -
1999 - the scratch tape for the source uploading
