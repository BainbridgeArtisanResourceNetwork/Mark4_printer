; homez.g
;!<summary>Called to home the Z axis.  This file is a macro to set z via the z-probe sensing the metal plate or aluminum bed </summary>
G91               ; Set relative positioning
G1 H2 Z10 F1000    ; lower Z relative to current position in case the bed is in a position wehre the probe is currently triggered.
G90				  ; Return to absolute positioning.

		;! Ask the user if the build plate is present or there is a metal piece on the buildplate, and nothing else on the buildplate. If no, don't do anything.
if !{global.Z_Probe_Type = "touch"} 
  M291 P" Using hall effect z-probe. Be sure there is a metal build plate or metal heated bed below the center of the bed before saying OK." R"Z-home using probe" S3

;################ ;!If X has not been homed, home x
if !move.axes[0].homed
  M291 P"X axis not yet homed. Homing now." R"Z-home using probe" S0 T5   ; S0 means no buttons, t5 means wait 5 seconds and move on.
  
  M98 P"0:/sys/homex.g"  ; run the homex gcode file in the sys directory.  Note line leading spaces needed to define IF Block 0:/sys/homex.g is the way to write an absolute path
  
;else 
  ;M291 p"X already homed, moving on." s0   
  
  
  
  
;################;! If Y has not been homed, home Y  
  
if !move.axes[1].homed
  M291 P"Y axis not yet homed. Homing now." R"Z-home using probe" S0 T5   ; S0 means no buttons, t5 means wait 5 seconds and move on.
  
  M98 P"0:/sys/homey.g"  ; run the homey gcode file in the sys directory.  Note line leading spaces needed to define IF Block 0:/sys/homey.g is the way to write an absolute path
  
;else 
  ;M291 p"Y already homed, moving on." s0 



;################;! Move the probe to the center of the bed quickly.
G1 X{175 + global.Z_probe_Xoffset} Y{175+global.Z_probe_Yoffset} F6000


;################;! Probe the bed and set the probe trigger point to Z=0
G30





