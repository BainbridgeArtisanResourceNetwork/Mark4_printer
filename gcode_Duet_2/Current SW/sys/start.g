;! the Start.g file is run before each print file is started. It should contain gcode that we want to run before each print. 

; SET VARIABLES
	; Set printer config name to none. This creates the variable so custom gcode in the printer config can set it. 
	; This will be used by daemon.g to ensure that a valid slicer config was used.

	; set the variable for the slicer's printer config file name. Need to reset to null in so we don;t get an onld name.
	;We'll collect from the custom gcode in the print file.
set global.printer_config = null

	; Capture the the start time of this print
set global.this_print_start_time = state.time
  
  ; Capture the file name of this print so we can put it in the log (in stop.g)
set global.this_print_filename = job.file.fileName
 


;HOMING AND BED LEVEING
;G28 ; home all axes
;G32 ; run bed.g macro, which levels the bed (unless we add more to it)
;G29 S0; execute bed mesh measurement 


;READY TO PRINT
G1 Z15 F5000 ; lift the nozzle (move the bed down) 15mm so the move to the first printing point will be above the bed.
