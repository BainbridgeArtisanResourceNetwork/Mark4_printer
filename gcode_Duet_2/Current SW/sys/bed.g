; bed.g
;!<summary> bed.g is called directly by the G32 gcode. It ultimately uses the G30 command that collects Z-probe heights at specifed locations, then calls the option (S3) for the FW to adjust the three z-motors so that the z-probe height at the three locations will be equal, and we the bed should be co-planar with the plane described by the XY movement reach of the nozzle. This process is described in this Duet2 web page. [DUET 3-motor bed leveling](https://duet3d.dozuki.com/Wiki/Bed_levelling_using_multiple_independent_Z_motors)
;! 
;!</summary>
; generated by RepRapFirmware Configuration Tool v3.1.4 on Sun Oct 11 2020 12:47:10 GMT-0700 (Pacific Daylight Time)
M561 ;! clear any existing bed transform.
;!
G29  ;! G29 with no parameters runs the file mesh.g  Do we really want to do this before leveling the bed?
;!
;! probe three points on the bed to gather z-probe heights and on the last probe, add the S3 command that tells the Duet2 FW to perform  3 z-motor leveling. This also relies on an M671 code in the config.g file that defines the locations of the kinematic balls. Maybe that command belongs in this file. I don;t think there are other files that make independent z-motor moves and which would need it.

G30 P0 X120 Y380 Z-99999 		; Probe near back lead screw
G30 P1 X00 Y95 Z-99999			; Probe near front left lead screw
G30 P2 X280 Y95 Z-99999 S3		; Probe near front right lead screw and calibrate 3 motors
;!
G1 X0 Y0 F10000				;! Home X and Y. Do we want to home to 0,0, or the center of the bed?


