; homex.g
;!<summary>Called to home the X axis. Lowers the print bed (to clear anything on it), move to the end stop quickly to get rought positioning, then again slowly to be more precise. After finding the end move off a bit. If we mark a 0,0 on the aluminum bed and measure the offset fmo the endstop trigger, we can change that step to "move to x=0.  </summary>

;################;! If Y has not been homed, home Y  
if !move.axes[1].homed
  M291 P"Y axis not yet homed. Homing now." R"Z-home using probe" S0 T5   ; S0 means no buttons, t5 means wait 5 seconds and move on.
  
  M98 P"0:/sys/homey.g"  ; run the homey gcode file in the sys directory.  Note line leading spaces needed to define IF Block 0:/sys/homey.g is the way to write an absolute path

G91               ; relative positioning

if !global.homeall_running       ;if we did not get here from homeall, drop the bed before homing. If doing a homeall, the bed is already down.
  m564 H0 S0        ; allow moves without homing
  G0 Z5    ; drop the bed 5mm
  m564 H1 S1        ; don't alllow movements without homing

; added 9/12/22 to enable the switch to be an endstop after homing. 

M581 X T0 P-1       ;! Discontinue using trigger 0

G1 H1 X-365 F3000 ; move quickly to X axis endstop and stop there (first pass)
G1 X5 F6000       ; go back a few mm
G1 H1 X-365 F360  ; move slowly to X axis endstop once more (second pass)
G0 X5             ; move 5mm off the switch

; x homing complete, tinme to turn the xstop into a trigger for emergency stopping 
M581 T0 X S1  R0    ;  Assign trigger 0 (T0 - Emergency stop) to use the Xstop switch. trigger when switch goes from inactive to active (S1), trigger at any time (R0)

if !global.homeall_running    ; If we are doing a homeall, skip this part where the bed moves back up
  m564 H0 S0        ; allow moves without homing
  G0 Z-5            ; raise the bed back up
  m564 H1 S1        ; don't alllow movements without homing

G90               ; back to absolute positioning
