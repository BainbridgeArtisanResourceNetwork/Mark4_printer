; stop.g
;!<summary> called when M0 (Stop) is run (e.g. when a print from SD card is cancelled) Currently no commands are in this file. We need to decide what the steps we want performed on this trigger and add them to this file.</summary>
M118 S"The macro stop.g has started." L1



G91    ;  Switch G0/G1 to "relative movements"
G1 E-1 F300  ;retract the filament a bit before lifting the nozzle, to release some of the pressure
G1 Z+0.5 E-5 F9000 ;move Z up a bit and retract filament even more
G1 Z+10  ; now lift the nozzle off the part (drop the bed)
G90  : switch back to absolute move mode
g0 X300 Y175 ; Move the nozzle to the resr center of the platform

M84     ; disable motors
M104 S0 ; turn off temperature
M140 S0 ;  turn off heated bed

; Process the data variables we gathered at the beginning of the print

; DATA LOGGING
;	Now that the print gcode is done, the Duet's Object model contains details about the print that we can log to track usage. 
;	Here are some useful object model definitions, hte full set is at https://github.com/Duet3D/RepRapFirmware/wiki/Object-Model-Documentation#overview
;	current machine time   state.time
;   file name              job.file.fileName
;	estimated print time   job.file.printTime
;	actual time (sec)      job.lastDuration 
;   filament used (mm)     job.file.filament[]   returns an array


Create csv line for the printerlog (date/time of print start, print time,  filament used)

; Needs to be added here. 


