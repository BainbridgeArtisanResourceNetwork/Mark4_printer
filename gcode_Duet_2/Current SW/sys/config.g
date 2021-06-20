; Prototype Large 3D Printer Config File
; drawing inspiration from the Jubilee config file
;!<summary>connfig.g is the file that the Duet2 fw calls after power up to learn the HW configuration of the printer and get things started. This file has loads of stuff in it. It is where we defines motors, fans, heaters, etc with a numbers and map each one to the output connector on the board where we will plug in it's cable. It defines which motors are X, Y, Z, Extruder, or Utility and defines how a single step of the motor translates into the specific motion of the nozzle, filament, or whatever the motor is hooked to.  We use it to tell teh Duet2FW that we are a core-XY style printer, the size of the bed, where our homing switches are located, how many different tools we will have, etc. Just about everything that the controller fw needs to know so it can make parts is in this file.  Loads of good stuff that we need to get right. 
;!
</summary>

;! Name the printer so it can identify itself. 
M550 P"ETA Large 3D Printer"                         ; Machine name and Netbios name
;!
;! Set up  Networking
M552 S1                    		; Enable Network
M586 P0 S1                       	; Enable HTTP
M586 P1 S0	                        ; Netmask
M586 P2 S0                              ; Disable Telnet
;!
;! Set up  Debugging and define a log file location
M111 S0                                 ; Debug off
;M929 P"eventlog.txt" S1                ; Start logging to file eventlog.txt

;!
;! Set General Preferences. dimensions in mm, which fw to emulate, etc.
M555 P2                                 ; Set RepRapFirmware style output
G21                                     ; Set dimensions to millimetres
G90                                     ; Send absolute coordinates...
M83                                     ; ...but relative extruder moves

;!
;! Set up motors. Start be assigning Duet 2 motor drivers to specific axes. May be a good idea to map every driver in case we change where a cable is plugged in (the fw will remember old mapping if it is not overwritten)
M584 X0 Y1 Z6:7:8 E3:4:5 U2   ; Map Z to drives 6, 7, 8. Map extruders to 3 and 4. Create Toolchanger Lock axis.

M569 P0 S1                  ; Drive 0 direction | X stepper
M569 P1 S1                  ; Drive 1 direction | Y Stepper

M569 P6 S0                  ; Drive 6 direction | Front Left Z
M569 P7 S0                  ; Drive 7 direction | Front Right Z
M569 P8 S0                  ; Drive 8 direction | Back Z

M569 P2 S1                  ; Drive 2 direction | Toolchanger Actuator

M569 P3 S1 D2               ; Drive 3 direction | Extruder 0 in SpreadCycle Mode
M569 P4 S1 D2               ; Drive 4 direction | Extruder 1 in SpreadCycle Mode

;!
;! Kinematics. Define us as a CoreXY type printer. We should look at the M669 command info and decide if we need to add a matrix here to address an assumed 3:1 ratio in the Z motor. seeM669 in [Duet2 wiki](https://duet3d.dozuki.com/Wiki/Gcode?revisionid=HEAD#Section_M669_Set_kinematics_type_and_kinematics_parameters)
M669 K1                                 ; CoreXY mode
;!
;! Define posiotions of the Z leadscrews or bed-leveling screws. Since we are using kinematic ball joints, these are the correct positions for us to use. Need to change the X and Y values based on the homed values of X=0 and Y=0. We probably need to create a 0,0 target mark on the heated bed. 
; Kinematic bed ball locations. Locations are extracted from CAD model assuming:
;   350x350mm build region offset from the 370x450mm plate.
;   front left corner of build region is (0, 0).
M671 X-18:376:175 Y64:64:415 S10 ; Front Left: (-18, 64) | Front Right: (376, 64) | Back: (175, 415)


;! Axis and Motor Configuration. Set the transformation values for motor set to linear movement based on our motors, pulleys, etc.
M350 X16 Y16 Z16 E16:16 U4 I1           ; Set 16x microstepping for xyz axes & extruders, 4x for toolchanger lock. Use interpolation.
M574 X1 Y1 Z1 S1                        ; Set homing switch configuration x low-end, y low-end, z low-end, all active-high (NC)
M574 U1 S1                              ; Set homing switch configuration for toolchange lock. Both switches should be wired NC and in series.

M906 X2263 Y2263                        ; LDO XY motor currents (mA). 2263mA is 80% of 2828mA Peak Current. (2828mA Peak is 2000mA RMS)
                                        ; Do not exceed 90% of full XY motor current rating without heatsinking the XY motor drivers.

M906 Z1600                              ; LDO ZZZ Motor currents (mA). Conservative.


M906 E1250                              ; Motor currents E (mA)

M906 U670 I60                           ; LDO Toolchanger Elastic Lock motor current (mA) and idle motor percentage.

                                        ; Note: Idle current setting is common across all motors (XYZZZU).

M201 X1000 Y1000                        ; XY Acceleration. Conservative. 1500+ possible.
M201 Z100                               ; LDO ZZZ Acceleration

M201 E1300:1300                         ; E Acceleration
M201 U800                               ; LDO U Accelerations (mm/s^2) conservative

M203 X13000 Y13000 Z800 E8000:8000 U9000 ; Maximum speeds (mm/min) conservative. 18000+ possible on XY. Depends on tool.
M566 X1000 Y1000 Z500 E3000 U50          ; Maximum jerk speeds mm/minute

M92 X160 Y160                           ; Steps/mm for X,Y...Modified/corrected Jubilee-defined from 200 to 160 on 10/29/2020

M92 U30.578                             ; Steps/deg for U from (200 * 4 * 13.76)/360
M92 Z3200                               ; Steps/mm for Z for a T8x2 leadscrew and 0.9mm stepper. (16 * 400)/2

;M92 E830:830                            ; Extruder - 0.9 deg/step!! This is double..commented out this step and added below M92 
M92 E420:420				 ; Extruder: This works for our L3D Dual Drive Extruder with 17HS4023 Usongshine Stepper Motor

; Set axis software limits and min/max switch-triggering positions.
; Adjusted such that (0,0) lies at the lower left corner of a 350x350mm square on the 370mmx470mm build plate.
M208 X0 Y0 Z0 S1
M208 X350 Y435 Z415.1 S0                   ; MIKE 6/16/21 changed Y from 400 to 435
M208 U0:200                                 ; Set Elastic Lock (U axis) max rotation angle

;! 
;! Define Thermistors
;M305 P0 S"Bed" T10000 B3435 H0               ; BOM-specified Adjusted Terminal Lug Thermistor values. (Not for L3D)
;M305 P0 S"Bed" T10000 B3984 H0 L160          ; BOM-specified Terminal Lug Thermistor values. (Not for L3D)
M305 P0 S"Bed" T100000 B3950		      ; Built-in HT100K Bed Thermistor for H0 Bed Heater.

;!
;! PT100 Hotend Temperature Sensors. These require an external Breakout Board. For other configs, see the wiki:
;! https://jubilee3d.com/index.php?title=Bondtech_Direct_Drive_Extruder 
;M305 P1 X200                                ; Map Extruder 0 sensor to PT100 Channel 0 No, not for L3D Commented out
;M305 P2 X201                                ; Map Extruder 1 sensor to PT100 Channel 1 No, not for L3D Commented out
M305 P1 S"E0 Temp" T100000 B3950	     ;HT-NTC100K Thermistor Sensor for E0 Heater on L3D
;M305 P2 S"E1 Temp" T100000 B3950	     ;HT-NTC100K Thermistor Sensor for E1 Heater on L3D

;!
;!Define Heaters
M950 H0 C"Bed" T0			    ;Create Bed heater and map to sensor 0....added for L3D
M950 H1 F0 C"E0 Heat" T1		    ;Create E0 heater and map Sensor 1 For L3D
;M950 H2 F1 C"E1 Heat" T2		    ;Create E1 heater and map Sensor 2 For L3D Don't have E1 right now   
M570 S30                                    ; Print will be terminated if a heater fault is not reset within 30 minutes.
M140 H0					    ;Map Heated bed to Heater H0...added for L3D
M143 H0 S100                                ; Maximum H0 (Bed) heater temperature
M143 H1 S260                                ; Maximum H1 (Extruder) heater temperature
;M143 H2 S260			            ; Maximum H2 (Extruder) heater temperature Uncomment after second extruder (H2) install
; Default heater model
;M307 H0 A270.7 C90.4 D6.7 B0 S1.0           ; Default Bed Heater Parameters, before tuning / if config-override.g is missing
M304 P25 I0.400 D66.3			    ;TEST
;M307 H0 A552.2 C281.5 D5.6 B0 S1.0          ;Testing bed heater for L3D

;!
; Tool definitions
M563 P0 S"Extruder 0" D0 H1 F0          ; Define tool 0
;G10 P0 X-48 Y37,5 Z-2.51                 ; Set tool 0 offset from the bed (Update for bed plate thickness at 0.76 mm to 1.65 mm) Old value was Z=-0.9, which included 0.1mm foil
G10 P0 X-56 Y32 Z-0.61			; Set tool 0 offset from Z probe with tactical bed plate installed on prototype MDF bed
G10 P0 S190 R170                        ; Set tool 0 operating and standby temperatures(-273 = "off")
M572 D0 S0.1				; Set pressure advance on Extruder Drive 0

M563 P1 S"Extruder 1" D1 H2 F2          ; Define tool 1
G10 P1 X-4.23 Y45.60 Z-2.51             ; Set tool 1 offset from the bed with tool-0 as a reference.
G10 P1 S190 R170                        ; Set tool 1 operating and standby temperatures(-273 = "off")
M572 D1 S0.1                            ; Set pressure advance on Extruder Drive 1

:!
;Define Fans
M106 P0 T45 S1.0 H1			; Turn on P0 H1 (E0) HotEnd fan to 100% at 45 degs... Added for L3D
M106 P2 T45 S1.0 H1			; Turn on P2 H1 (E0) Part fan to 100% at 45 degs,,, Added for L3D
;M106 P1 T45 S1.0 H2			; Turn on P1 H2 (E1) HotEnd fan to 100% at 45 degs,,, Added for L3D, commented out until tool E1 is installed
;M106 P0 S1                               ; Turn off fan 0 Commented out and replaced by above
;M106 P1 S0                               ; Turn off fan 1 Commented out and replaced by above

;!
;!Mesh Bed Leveling Settings. Define points to probe for leveling compensation. Not in bed.g because bed leveling (G29) could be called directly.
M557 X20:280 Y50:350 S40		;Temporary for prototype Z probe mech Limit switch install on tool carrier.  Update when nozzle is installed

;!
;! Z probing settings
M558 P5 H3 A1 T10000 S0.02
;M558 P0
; P5 --> probe type: switch
; C2 --> endstop number
; H3 --> dive height
; A1 --> max number of times to probe
; T100000 --> travel speed between probe points
; S0.02 --> tolerance when probing multiple times

;!
M593 F33.33  ;! Reduce resonances at 33Hz based on XY vibration pattern on prints. This value could use a second opinion.

M98 P"config-user.g"                    ; Load custom user config

M501                                    ; Load saved parameters from non-volatile memory