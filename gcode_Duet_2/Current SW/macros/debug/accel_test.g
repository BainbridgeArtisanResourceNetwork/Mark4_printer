; Accelerometer setup and use.

G91   ; switch to relative positioning
; configure accelerometer
M955 P0  C"spi.cs3+spi.cs2"  I25

M956 P0 S2000 A1
; A0 is start recording immediately
; A1 means start recording when the next move starts
; A2 means start recording when decelleration pahase of next move starts


G1 x00 y50 f12000 ; make the move we're measuring


G4 S2    ;wait 2 seconds
G1 x-0 y-50 F12000 ;move back
M400  




g90   ; switch back to absolute positioning