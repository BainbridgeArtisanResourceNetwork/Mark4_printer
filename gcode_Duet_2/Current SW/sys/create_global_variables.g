;!<summary> This file is used as the preferred place to create global variables. The normal usage is that they are created here (in alphabetical order) and assigned a null value.  When a macor wants to assign a value to one it does not need to check for it's existence, and then either create, or just assign. Should make other macros easier to read.
;This macro is called as the first command in config.g.
; The idea of doing this is all from teh BARN team. This is not a DUET idea, so blame us if it's dumb.



global printer_config           = null ; used in start to capture the name and version of the slicer's printer config
global this_print_end_time      = null ; used in stop.g to get the end time of the print so we can calculate the elapsed print time.
global this_print_filename      = null  ; used  in start.gto hold the name of the prfile being pronted so we can log it.
global this_print_start_time    = null  ; used in start.g to collect the start time of each new print. 

global Z_probe_Xoffset          = null  ; used to capture the X offset of the z Probe. 
global Z_probe_Yoffset          = null  ; used to capture the Y offset of the z Probe. 

global homeall_running = false   ; will be set to true at the beginning of  homeall.g and used in homeX, Y, and Z to skip dropping the bed.

global bed_leveled = false
global mesh_created = false