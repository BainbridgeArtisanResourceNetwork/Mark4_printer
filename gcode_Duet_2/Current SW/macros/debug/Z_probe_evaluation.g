; This macro is used to measure the performance of the Z-probe.
; Optional Parameters
; N - the number of times to probe the point in question. Default is 100
; X - X location to probe ; if not supplied, probe the current location
; Y - Y location to probe ; if not supplied, probe the current location

;Checks, variable definitions and parse command line inputs

var num_probes = 500
if exists(param.N)  ; see if a parameter "N" was provided
  set var.num_probes = param.N

var X_loc = move.axes[0].machinePosition
if exists(param.N)  ; see if a parameter "N" was provided
  set var.X_loc = param.X_loc

var Y_loc = move.axes[1].machinePosition
if exists(param.N)  ; see if a parameter "N" was provided
  set var.Y_loc = param.Y_loc

var Z_loc = move.axes[2].machinePosition

var last_X = var.X_loc
var last_Y = var.Y_loc
var last_Z = var.Z_loc




;Create an output file
var outfile = "0:/macros/data/"^+state.time^".csv"   ; This is the current time in seconds since the datum, a good filename

;Send header info to the file
echo >>{var.outfile} "Z-probe repeatability data set"
echo >>{var.outfile} "Number of points", var.num_probes
echo >>{var.outfile} " "
echo >>{var.outfile} "start_X, start_Y, start_Z, probed Z"


var loop_count = 0
while var.loop_count < var.num_probes
  G90                                           ; absolute position
  G0 X{var.X_loc} Y{var.Y_loc}                  ; move to the target position
  G30 S-1                                       ; probe the bed here and stop when the probe triggers
  set var.Z_loc = move.axes[2].machinePosition  ; collect the current position 
  
  echo >>{var.outfile} var.last_X,  "," , var.last_Y, "," , var.last_Z, ",", var.Z_loc        ; write to the file

  G91                                           ; switch to relative positioning
  set var.last_Z = {2 + random(5)}
  G0 Z{var.last_Z}                          ; drop the bed down a bit

  set var.last_X ={(-1+ random(3))*12}
  set var.last_Y ={(-1+ random(3))*12}
  G0 x{var.last_X} y{var.last_Y}       ; move the head away from the probe point


  set var.loop_count = var.loop_count +1
  if mod(var.loop_count,10)=0
    echo {"Probes completed = "^var.loop_count^ " of "^var.num_probes}
  ;ENDIF

;END LOOP

G90  ; reset to absolute positioning 
