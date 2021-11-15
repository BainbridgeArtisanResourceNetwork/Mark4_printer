if !{exists(global.Z_Probe_Type)}
	global Z_Probe_Type = "touch"
else
	set global.Z_Probe_Type = "touch"
	
M291 P"To to change it to Proximity?, select OK" R"To keep BL-Touch, select Cancel" S3

set global.Z_Probe_Type = "prox"