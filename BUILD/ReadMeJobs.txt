# OS Dubna Job intructions
#
# Copyright, 2019 by Mikhail Popov 
# 
# Rev A. 2019/02/01
#

Tapes with numbers in the range of 2200-2299 are logically distributed as
bridge between DISPAK and SIMH.  The idea is to use DISPAK environment to
prepare the work components and then run the job with these componnents in
SIMH.  Components, it can be sources, libraries or any other data that
require placement on tapes or disks of the system before starting your job
in SIMH, it includes the job file in batch format.  At the moment, only the
MULTITYPE interface is available to start, stop jobs and intercept output.

Here it is the list of the main steps of preparation and submittion of job.

1. Prepare the batch file for your job and all othe compomments
2. White this fiile on one of the bridge tape using DISPAK
3. Do the same for all other commoments in you job
4. In the running MULTITYPE system, select the same tape as the work buffer.
5. Run the task from the zone where you placed the task file.

The output listing will be printed after activation of the line printer spooler
or the output can be intercepted by MULTITYPE on the session screen.


A printout of the output will be printed in output.txt file after activating
the line printer spooler or the output can be intercepted by MULTITYPE on
the screen in the session.

