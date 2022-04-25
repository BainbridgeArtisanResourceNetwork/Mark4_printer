;var outfile = "0:/macros/data/"^+state.time^".csv"   ; This is the current time in seconds since the datum, a good filename

;echo >>{var.outfile} "Z-probe repeatability data set"
;echo >>{var.outfile} "Number of points", 100
;echo >>{var.outfile} " "
;echo >>{var.outfile} "start_X, start_Y, start_Z, probed Z"

;TIME
echo "current time ", state.time    ; in readable format
echo "current time ", +state.time, " in seconds since the datum"  ; in seconds since the datum

echo "Uptime ", state.upTime, "seconds"
echo "millisecond fraction of up time, in msec =  ", state.msUpTime
echo "Uptime to the msec ",  mod(+state.upTime,10000) + state.msUpTime/1000 , "sec"
echo "Uptime to the msec ",  state.upTime + state.msUpTime/1000 , "sec"



;To time an event less than 2/77 hours (9999sec) long:
var start_time = mod(+state.upTime,10000) + state.msUpTime/1000
; start event here
G4 P125  ; pause for 125 msec
var end_time = mod(+state.upTime,10000) + state.msUpTime/1000

var delta_t = var.end_time - var.start_time
if var.delta_t < 0   ; this IF /ELSE is needed because of the mod function use in capturing the time. 
  set var.delta_t = 10000+var.delta_t
echo "elapsed time = ", var.delta_t, "sec"



; movement and location
; X axis is 0, Y axis is 1, Z axis is 2

echo "current position ", move.axes[0].machinePosition, "mm"
echo "max speed ", move.axes[0].speed, "mm/min"
echo "max acceleration ", move.axes[0].acceleration, "mm/sec^2"
echo "max jerk ", move.axes[0].jerk,   " mm/min" 
echo "max motor current ", move.axes[0].current, " motor current"


 

