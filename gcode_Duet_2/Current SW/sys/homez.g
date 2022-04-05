; homez.g
;!<summary>Called to home the Z axis.  This file is a macro to set z via the z-probe sensing the metal plate or aluminum bed </summary>
G91               ; Set relative positioning

if !global.homeall_running               ; If this macro was not (!) called from homeall.g, need to drop the bed. 
  m564 H0 S0        ; allow moves without homing
  G0 Z5    ; drop the bed 5mm
  m564 H1 S1        ; don't alllow movements without homing

G90				  ; Return to absolute positioning.



;################ ;!If X has not been homed, home x
if !move.axes[0].homed
  M291 P"X axis not yet homed. Homing now." R"Z-home using probe" S0 T5   ; S0 means no buttons, t5 means wait 5 seconds and move on.
  
  M98 P"0:/sys/homex.g"  ; run the homex gcode file in the sys directory.  Note line leading spaces needed to define IF Block 0:/sys/homex.g is the way to write an absolute path



;################;! If Y has not been homed, home Y  
if !move.axes[1].homed
  M291 P"Y axis not yet homed. Homing now." R"Z-home using probe" S0 T5   ; S0 means no buttons, t5 means wait 5 seconds and move on.
  
  M98 P"0:/sys/homey.g"  ; run the homey gcode file in the sys directory.  Note line leading spaces needed to define IF Block 0:/sys/homey.g is the way to write an absolute path




;################;! Move the probe to the center of the bed quickly.
G1 X{175 - global.Z_probe_Xoffset} Y{175-global.Z_probe_Yoffset} F6000


;################;! Probe the bed and set the probe trigger point to Z=0
G30 

G29 S1 P"heightmap.csv" ; Load height map file "hightmap.csv" and enable mesh bed compensation. This is so that there will be compensation at power on even if it is not run manually.




