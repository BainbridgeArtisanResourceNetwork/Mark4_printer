; homez.g
; called to home the Z axis
;
; generated by RepRapFirmware Configuration Tool v3.1.4 on Sun Oct 11 2020 12:47:10 GMT-0700 (Pacific Daylight Time)
G91              ; relative positioning
G1 H1 Z430 F1800 ; move Z down until the endstop is triggered
G1 H2 Z-5 F6000  ; raise Z relative to current position
G92 Z415.1       ; set Z position to axis maximum (you may want to adjust this)

; Uncomment the following lines to lift Z after probing
;G91             ; relative positioning
;G1 Z5 F100      ; lift Z relative to current position
;G90             ; absolute positioning

