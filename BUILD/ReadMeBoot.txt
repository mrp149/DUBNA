1. deck-b1/deck.notes:
*
*      NOTES on BOOTSTRAP DECK #1
*      03/03/2017: 
*        1. DISPAK=>SIMH Jump Supports only 128K memmory @SIMH
*        2. ROLL-TRACK initialization, boot once with drums only!
*        3. STATBUF is disabled. 
*        4. No real VOL names for DISK
*        5. Only 2 terminals (consuls) can be used (tty25,tty26)
*        6. The Clock Frequency is 300 Hz
*        7. All I/O checks for CW are suppressed
*        8. DEBMULT will run as a separate job, due to Dispak
*        9. E50 0076 error is expected at the end of the link job
*       10. NO STL!
*       11. Date settings accepts only year of 1989!
*       12. Line Printer works 
*

2. After the first boot use d@dubna.ini in SIMH calls 

 besm6 -i d@dubna.ini

3. The second consul port is 4199, can be used for Mutitype

This conludes the phase #1 of the bootstrap (30-Mar-2017)

4. The system will be automatically rebuilt by starting ./exce.ex 
execept srcipt in a separate window, when it is requested. The 
script rebuilds DD and STL and puts it on DRUM 25

   160/  - reports running tasks

This conludes the phase #2 of the bootstrap (06-Apr-2017)
