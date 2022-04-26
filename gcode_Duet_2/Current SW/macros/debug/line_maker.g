; Macro for making short, repeated print head excursions on a line

; Typical usage    M98  P"0:/macros/line_maker.g"  A45 L30 S25 N2


; CHECK INPUTS

var angle = null ;angle of line, 0-360 degrees
if exists(param.A)  ; see if a parameter "A" was provided
  set var.angle = param.A  
else
  M291 P"Angle of line (param A) not provided. Cancelling macro."  S0 T5   ; S0 means no buttons, t5 means wait 5 seconds and move on.
  M99


var len = null                  ;length of line, in mm
if exists(param.L)              ; see if a parameter "L" was provided
   set var.len = param.L        ;length of line, in mm
else
  M291 P"Length of line (param L) not provided. Cancelling macro."  S0 T5   ; S0 means no buttons, t5 means wait 5 seconds and move on.
  M99  


var speed = null             ;max speed of travel, in mm/sec
if exists(param.S)           ; see if a parameter "S" was provided
  set var.speed = 60 * param.S  
else
  M291 P"travel speed (param S) not provided. Cancelling macro."  S0 T5   ; S0 means no buttons, t5 means wait 5 seconds and move on.
  M99


var loops = 1
if exists(param.N)  ; see if a parameter "N" was provided
  set var.loops = param.N  ;max speed of travel, in mm/sec
else
  M291 P"Number of roundtrips (param N) not provided. Useing default of 1."  S0 T5   ; S0 means no buttons, t5 means wait 5 seconds and move on.


; Gather current position (endpoint 0)
var X_0 = move.axes[0].machinePosition
var Y_0 = move.axes[1].machinePosition

;Calculate other endpoint (endpoint 1)
var X_1 = {var.X_0 + var.len * cos(pi * var.angle / 180)}
var Y_1 = {var.Y_0 + var.len * sin(pi *  var.angle / 180)}



; collect the start time
var start_time = mod(state.upTime,10000) + state.msUpTime/1000


;Loop while drawing the line
while iterations < {var.loops}
  G0 X{var.X_1} Y{var.Y_1} F{var.speed}
  G0 X{var.X_0} Y{var.Y_0} F{var.speed}

G4 P0
;Collect the end time
var end_time = mod(state.upTime,10000) + state.msUpTime/1000


;calculate elapsed time
var delta_t = var.end_time - var.start_time
if var.delta_t < 0                             ; this IF /ELSE is needed because of the mod function use in capturing the time. 
  set var.delta_t = 10000+var.delta_t


;Calculate average time per line
var avg_travel_time = var.delta_t/(2*var.loops)
echo "average travel time = ", var.avg_travel_time, " seconds"
echo "average travel speed = ", var.len/var.avg_travel_time, "mm/sec"



