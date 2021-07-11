; homex.g
;!<summary>Called to home the X axis. Lowers the print bed (to clear anything on it), move to the end stop quickly to get rought positioning, then again slowly to be more precise. After finding the end move off a bit. If we mark a 0,0 on the aluminum bed and measure the offset fmo the endstop trigger, we can change that step to "move to x=0.  </summary>

;
; generated by RepRapFirmware Configuration Tool v3.1.4 on Sun Oct 11 2020 12:47:10 GMT-0700 (Pacific Daylight Time)
G91               ; relative positioning
G1 H2 Z5 F6000   ; lower Z relative to current position
G1 H1 X-365 F1800 ; move quickly to X axis endstop and stop there (first pass)
G1 X5 F6000       ; go back a few mm
G1 H1 X-365 F360  ; move slowly to X axis endstop once more (second pass)
G1 H2 Z-5 F6000   ; raise Z again
G90               ; absolute positioning

