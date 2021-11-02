; homez.g
;!<summary>Called to home the Z axis.  This file is a macro to set z via the z-probe sensing the metal plate or aluminum bed </summary>


;! Ask the user if the build plate is present or there is a metal piece on the buildplate, and nothing else on the buildplate. If no, don't do anything.
M291 P"Be sure there is a metal build plate or metal heated bed below the center of the bed before saying OK." R"Z-home using probe" S3

;! If X has not been homed, home x
if !move.axes[0].homed 
  M291 P"X axis not yet homed. Homing now." R"Z-home using probe" s0 T5   ; S0 means no buttons, Tn means wait n seconds and move on.
  
  M98 P"0:/sys/homex.g"  ; run the homex gcode file in the sys directory.  Note line leading spaces needed to define IF Block 0:/sys/homex.g is the way to write an absolute path
  g0 x175              ; move to the center of the bed
  
else 
  M291 p"X already homed, moving on." s0 t5

;! If Y has not been homed, home Y

;! Move the probe to the center of the bed

;! Probe the bed and set the probe trigger point to Z=0
G30

;! Move to the selected z-probe offset.  This is the command where we define how far above plate we want z to bed

;! After moving to the selected point, set this location to become Z=0

;! Done




;
; generated by RepRapFirmware Configuration Tool v3.1.4 on Sun Oct 11 2020 12:47:10 GMT-0700 (Pacific Daylight Time)
;G91              ; relative positioning
;G1 H1 Z430 F1800 ; move Z down until the endstop is triggered
;G1 H2 Z-5 F6000  ; raise Z relative to current position
;G92 Z415.1       ; set Z position to axis maximum (you may want to adjust this)

; Uncomment the following lines to lift Z after probing
;G91             ; relative positioning
;G1 Z5 F100      ; lift Z relative to current position
;G90             ; absolute positioning

