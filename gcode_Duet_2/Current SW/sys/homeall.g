; homeall.g
;!<summary>Called to home all axes. Updated 7/4/2021. This file calls homex.g, homey.g and homez.g macros in succession. </summary>
;

set global.homeall_running = true   ; Set this variable so homex.g, homey.g, and homez.g can skip some of the bed drops and lifts.

;!- Call homes.g
M98 P"0:/sys/homex.g"

;!- Call homey.g
M98 P"0:/sys/homey.g"

;!- Call homez.g
M98 P"0:/sys/homez.g"

set global.homeall_running = false   ; Reset to false so homex.g, homey.g, and homez.g will not skip their bed drops and lifts.


