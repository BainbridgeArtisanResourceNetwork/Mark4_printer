; resume.g
;!<summary> called before a print from SD card is resumed. Need to review this and decide if it's what we want on a resume. </summary>
;
; generated by RepRapFirmware Configuration Tool v3.1.4 on Sun Oct 11 2020 12:47:10 GMT-0700 (Pacific Daylight Time)
G1 R1 X0 Y0 Z5 F6000 ; go to 5mm above position of the last print move
G1 R1 X0 Y0          ; go back to the last print move
M83                  ; relative extruder moves
G1 E10 F3600         ; extrude 10mm of filament

