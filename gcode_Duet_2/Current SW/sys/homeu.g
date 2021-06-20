; Home U Axis
;!<summary>Home the U axis. In our implementation, the U axis is the motor that locks tools onto the moving tool-plate. </summary>

G91                     ; Set relative mode
G1 U-360 F9000 S1       ; Big negative move to search for home endstop
G1 U6 F600              ; Back off the endstop
G1 U-10 F600 S1         ; Find endstop again slowly
G90                     ; Set absolute mode
