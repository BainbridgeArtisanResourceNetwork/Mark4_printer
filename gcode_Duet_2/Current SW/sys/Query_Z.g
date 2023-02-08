if !{exists(global.Z_Probe_Type)}
	global Z_Probe_Type = "touch"
else
	set global.Z_Probe_Type = "touch"
	
M291 P"Do you want to change it to Proximity?" R"Probe defaults to BL-Touch" S3

set global.Z_Probe_Type = "prox"