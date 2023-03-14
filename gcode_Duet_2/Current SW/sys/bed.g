; bed.g
;!<summary> bed.g is called directly by the G32 gcode. It ultimately uses the G30 command that collects Z-probe heights at specifed locations, then calls the option (S3) for the FW to adjust the three z-motors so that the z-probe height at the three locations will be equal, and we the bed should be co-planar with the plane described by the XY movement reach of the nozzle. This process is described in this Duet2 web page. [DUET 3-motor bed leveling](https://duet3d.dozuki.com/Wiki/Bed_levelling_using_multiple_independent_Z_motors)

;!</summary>

M561 ;! clear any existing bed transform.

; HEAT THE BED
if true    ; needed to keep Cancel from cancelling the whole macro
  M291  S3 T10 R"Running bed.g file" P"Heating bed to 65C Press cancel to skip"
  M140 S65       ; set bed temp to 65
  M190           ; wait for bed to reach temperature

; HOME ALL AXES
if true    ; needed to keep Cancel from cancelling the whole macro
  M291  S3 T10 R"Running bed.g file" P"Homing all axes.  Press cancel to skip"
  homeall.g
  
; LEVEL THE BED
if true    ; needed to keep Cancel from cancelling the whole macro
  M291  S3 T10 R"Running bed.g file" P"Leveling the bed.  Press cancel to skip"

   probe three points on the bed to gather z-probe heights and on the last probe, add the S3 command that tells the Duet2 FW to perform  3 z-motor leveling. This also relies on an M671 code in the config.g file that defines the locations of the kinematic balls. Maybe that command belongs in this file. I don;t think there are other files that make independent z-motor moves and which would need it.

  G30 P0 X40    Y284 Z-99999 		    ; Probe near back left corner
  G30 P1 X340    Y284 Z-99999 		; Probe near back right corner
  G30 P2 X40     Y10  Z-99999	        ; Probe near front left lead screw. global variables set in config.g file
  G30 P3 X340    Y10  Z-99999 S3		; Probe near front right lead screw and calibrate 3 motors. global variables set in config.g file

  M98 P"homez.g" ;Rehome the Z because leveling the bed surely moved the vertical location of the center of the bed. 
  
  set global.bed_leveled = true
  
  
; CREATE  AND ENABLE BED MESH
if true    ; needed to keep Cancel from cancelling the whole macro
  M291  S3 T10 R"Running bed.g file" P"Creating bed compensation mesh.  Press cancel to skip"
  G29  S0  
  set global.mesh_created = true
  
;G1 g0 X165  Y300 F10000				;! move to center rear of the bed

  