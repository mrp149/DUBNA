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
4. In your MULTITYPE session assign the bridge tape to your working buffer.
5. Run the task from the buffer zone where you placed your task file.

The listing (printout) of the job will be saved in the output.txt file only
after the activation of line printer spooler.  As an option, the listing can
be intercepted on the screen of your MULTITYPE session.

