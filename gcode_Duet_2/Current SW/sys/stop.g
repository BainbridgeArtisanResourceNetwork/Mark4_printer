; stop.g
;!<summary> called when M0 (Stop) is run (e.g. when a print from SD card is cancelled) Currently no commands are in this file. We need to decide what the steps we want performed on this trigger and add them to this file.</summary>


; DATA LOGGING
;	Now that the print gcode is done, the Duet's Object model contains details about the print that we can log to track usage. 
;	Here are some useful object model definitions, hte full set is at https://github.com/Duet3D/RepRapFirmware/wiki/Object-Model-Documentation#overview



	; get this print job's finish time.
set global.this_print_end_time = state.time
  
; Before we upgrade to RRF fw v3.4, echo job info to the console. 
echo global.this_print_start_time, ",", global.this_print_end_time, ",", global.this_print_filename, ",", global.printer_config
  
; After upgrade to fw 3.4 we can echo to a file, and convert the time to a unix seconds since the epoch and calculate the actual print time.  
;var print_duration = +global.this_print_end_time - +global.this_print_start_time
;echo >>"0:/sys/print_log.csv" global.this_print_start_time, ",", var.print_duration, "sec,", global.this_print_filename, ",", global.printer_config





G91    ;  Switch G0/G1 to "relative movements"
G1 E-1 F300  ;retract the filament a bit before lifting the nozzle, to release some of the pressure
G1 Z+0.5 E-5 F9000 ;move Z up a bit and retract filament even more
G1 Z+10  ; now lift the nozzle off the part (drop the bed)
G90  : switch back to absolute move mode
g0 X175 Y300 ; Move the nozzle to the center of the platform

M84     ; disable motors
M104 S0 ; turn off temperature
M140 S0 ;  turn off heated bed




