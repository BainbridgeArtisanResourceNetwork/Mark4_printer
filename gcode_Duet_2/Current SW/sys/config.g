; Prototype Large 3D Printer Config File
; drawing inspiration from the Jubilee config file
;!<summary>connfig.g is the file that the Duet2 fw calls after power up to learn the HW configuration of the printer and get things started. This file has loads of stuff in it. It is where we defines motors, fans, heaters, etc with a numbers and map each one to the output connector on the board where we will plug in it's cable. It defines which motors are X, Y, Z, Extruder, or Utility and defines how a single step of the motor translates into the specific motion of the nozzle, filament, or whatever the motor is hooked to.  We use it to tell teh Duet2FW that we are a core-XY style printer, the size of the bed, where our homing switches are located, how many different tools we will have, etc. Just about everything that the controller fw needs to know so it can make parts is in this file.  Loads of good stuff that we need to get right. 
;!
</summary>

;###############################################
;START OF CONTROLLER ID, DEBUG SETUP, GENERAL PREFERENCES

		;!## Set printer name
		;!Name the printer so it can identify itself. 
M550 P"ETA Large 3D Printer"                         ;! Machine name and Netbios name


		;!## Set up  Debugging and define a log file location
M111 S0        ;! Debug off
M929 P"eventlog.txt" S1                ; Start logging to file eventlog.txt

		;!## Set General Preferences
		;!Dimensions in mm, which fw to emulate, etc.
M555 P2   ;! Set to RepRapFirmware style gcode
G21       ;! Set dimensions to millimeters
G90       ;! Use absolute coordinates...
M83       ;! ...but relative extruder moves
M575  P1 S1 B57600  ;! ENable panel Due. Comment out if we aren't using it. 

;END OF CONTROLLER ID, DEBUG SETUP, GENERALPREFERENCES
;###############################################



;###############################################
;START OF NETWORKING SETUP
		;!## Networking
		;! Set up networking parameters.
M552 S1        ;! Enable Network
M586 P0 S1     ;! Enable HTTP
M586 P1 S0	   ;! Netmask
M586 P2 S0     ;! Disable Telnet

;END OF NETWORKING SETUP
;###############################################



;###############################################
;START OF GLOBAL VARIABLE DEFINITION
		;!## Define global variables
global all_loaded = "No"    ;! Set a global variable that we can use to verify the whole config.g file was loaded. Use M117 {global.all_loaded} to check
;global Z_Probe_Type = "prox" ;! Create a clobal variable to set the type of z-probe being used. Valid valeus are "prox" and "touch" 
;global Z_Probe_Type = "touch" ;! Create a clobal variable to set the type of z-probe being used. Valid valeus are "prox" and "touch"
M98 P"0:/sys/z_probetype_query.g"

		;!### Z PROBE  GLOBAL VARIABLES  - X,Y offsets. 
			;! set Z-probe global variable based on probe type
if global.Z_Probe_Type = "prox" 
  M291 P"Z-probe PROXIMITY sensor being used" S1 T20
  ;!Create two variables, global.Z_probe_Xoffset and global.ZZ_probe_Yoffset. These values can be ADDED to any the X and Y coordinates to move the probe to that position. the expression must be inside curly brackets {}.  This is useful because is lets us set the offset one time and use it lots of places.  Example: G0 x{100 + global.Z-probe-Xoffset}  Y{200 + global.Z-probe-Yoffset} moves the printhead so that the probe is over the machine point 100,200.
  global Z_probe_Xoffset =  -49;!- Create variable  global.Z_probe_Xoffset and set it's value.
  global Z_probe_Yoffset =  -26;!- Create variable  global.Z_probe_Yoffset and set it's value.
 
elif global.Z_Probe_Type = "touch"
  M291 P"Z-probe TOUCH sensor being used" S1 T20
  ;!Create two variables, global.Z_probe_Xoffset and global.ZZ_probe_Yoffset. These values can be ADDED to any the X and Y coordinates to move the probe to that position. the expression must be inside curly brackets {}.  This is useful because is lets us set the offset one time and use it lots of places.  Example: G0 x{100 + global.Z-probe-Xoffset}  Y{200 + global.Z-probe-Yoffset} moves the printhead so that the probe is over the machine point 100,200.
  global Z_probe_Xoffset =  -2;!- Create variable  global.Z_probe_Xoffset and set it's value.
  global Z_probe_Yoffset =  -40;!- Create variable  global.Z_probe_Yoffset and set it's value.
  
else 
;  M291 P"config.g file does not have a valid Z-probe assigned. Check ~line 49" S0 T0


;END  GLOBAL VARIABLE DEFINITION
;###############################################




;###############################################
;START OF X-Y-Z MOTION CONFIGURATION SECTION

			;!
			;!## Set up print head motion
			;!This includes the motors, how they map to the the X,Y and Z axes, plus how motor steps translate to physical motion 
			;!Before we start, clear all axis assignments so that we don't get unexpected motion.
M18 A Y Z A B C D U V W                 ; clear all axes assignments 

				;!### X-axis Motor assignment and configuration
M584 X0				;!Assign the X-axis motor to use driver0 (marked as "X" on the Duet 2 board)
M569 P0 S1      	;!Set the direction of the  driver0 (X) stepper.
M92 X160            ;!Set Steps/mm for X motor...Modified/corrected Jubilee-defined from 200 to 160 on 10/29/2020
M203 X13000			;!Set max X speed (mm/min) conservative. 18000+ possible on XY. Depends on tool.
M201 X1000      	;!Set max X acceleration (in mm/sec^2) for print moves.
M566 X1000			;!Set Maximum instantaneous speed change in (mm/minute). Too low and curves are super slow, too fast and there may be ringing
M574 X1 P"xstop" S1 ;!Define an active high (S1) limit switch at the minX end (X1) connected to the xstop pin on the Duet2 board


				;!### Y-axis Motor assignment and configuration
M584 Y1				;!Assign the Y-axis motor to use driver1 (marked as "Y" on the Duet 2 board)
M569 P1 S1      	;!Set the direction of the  driver1 (Y) stepper.
M92 Y160            ;!Set Steps/mm for Y motor...Modified/corrected Jubilee-defined from 200 to 160 on 10/29/2020
M203 Y13000			;!Set max Y speed (mm/min) conservative. 18000+ possible on XY. Depends on tool.
M201 Y1000      	;!Set max Y acceleration (in mm/sec^2) for print moves.
M566 Y10000         ;!Set Maximum instantaneous speed change in (mm/minute). Too low and curves are super slow, too fast and there may be ringing
M574 Y1 P"ystop" S1 ;!Define an active high (S1) limit switch at the minY end (Y1) connected to the ystop pin on the Duet2 board


				;!### Z-axis Motor assignment and configuration
M584 Z6:7:8			;!Assign the Z-axis motor to use drivers 6,7,8 (marked as "E3", "E4", "E5" on the Duex Expander board)
M569 P6 S0      	;! Set the direction of the  driver6 (Front-Left Z) stepper
M569 P7 S0      	;! Set the direction of the  driver7 (Front-Right Z) stepper 
M569 P8 S0      	;! Set the direction of the  driver8 (Rear Z) stepper
M92 Z3200           ;! Set Steps/mm for Z for a T8x2 leadscrew and 0.9mm stepper. Calculation:  (16 * 400)/2
M203 Z800			;! Set max Z speed (mm/min) conservative. 
M201 X100       	;! Set max Z acceleration (in mm/sec^2) for print moves.
M566 Z500           ;! SetMaximum instantaneous speed change in (mm/minute). Too low and movement may be jerky if mesh bed compensation is used (we do use it).
M574 Z1 P"zstop" S1 ;! Define an active high (S1) limit switch at the MaxZ end (Z1) connected to the zstop pin on the Duet2 board

;END OF X-Y-Z MOTION CONFIGURATION SECTION
;###############################################



;###############################################
;START OF X-Y-Z SOFT LIMITS SETUP
		;!## Soft Limits
		;!gcode commands in this section define the soft limits of movement in each direction. These limits define the maximum and minimum positions allowed during normal operations. This means that the board may send the carriage to any location within these parameters with crashing into anything. This section DOES NOT specify where the coordinate system exists within the physical boundaries of the printer. That positioning is done with the last "G1 H1" commands in the homex.g, homey.g and homez.z files. Those commands connect a machine X, Y or Z coordinate to the carriage position when the limit switch (or Z-probe) is triggered.  
		
M208 X-2:350		;!Set the Min:Max X axis soft limits. Min position is value set when X endstop is triggered.
M208 Y-42:350		;!Set the Min:Max Y axis soft limits. Min position is value set when Y endstop is triggered.
M208 Z-4:410		;!Set the Min:Max Z axis soft limits. Max position is value set when Y endstop is triggered if using the endstop at the bottom of the travel.

;###############################################
;END OF X-Y X-Y-Z MOVEMENT LIMITS SETUP





;###############################################
;START OF X-Y KINEMATICS SECTION
				;!### X-Y Kinematics. 
				;!Define us as a CoreXY type printer. We should look at the M669 command info and decide if we need to add a matrix here to address an assumed 3:1 ratio in the Z motor. seeM669 in [Duet2 wiki](https://duet3d.dozuki.com/Wiki/Gcode?revisionid=HEAD#Section_M669_Set_kinematics_type_and_kinematics_parameters)
M669 K1         ; CoreXY mode



;END OF X-Y KINEMATICS SECTION
;###############################################






;###############################################
;START  OF TOOL LOCK/UNLOCK ACTUATOR SECTION

		;!## Set up the Tool lock/unlock Actuator
		;!Need to investifate if the U axis should be defined as rotational
;M584 U2				;! Assign the Tool lock actuator motor to use driver2 (marked as "Zmotor" on the Duet 2 board)		
;M569 P2 S1      		;! Set the direction of the  driver2 (tool lock/unlock actuator) stepper
;M92 U30.578            ;! Set Steps/deg for U. Caclulation: (200 * 4 * 13.76)/360
;M203 U9000 			;! Set Maximum speed (mm/min) of the stepper locking and unlocking the tool lock.
;M201 U800       		;! Set LDO Max Acceleration (mm/s^2) of the stepper controlling the lock/unlock 
;M566 U50          		;! Set Maximum instantaneous speed change in (mm/minute).
;M574 U1 P"######" S1   ;! Define an active high (S1) limit switch at the min end (U1) connected to the ######### pin on the Duet2 board.
                        ;! *Need to select a pin for this use and uncomment this line line*
;M208 U0:200            ;! Set Elastic Lock (U axis) Min:max soft limits on rotation angle.	Min position is set when switch is triggered.	

;END OF TOOL LOCK/UNLOCK ACTUATOR SECTION
;###############################################






;###############################################
;START OF TOOL SETUP SECTION
		;!## Tool Definition and setup
			;!### Heater, sensor and Fan Definitions
			;!The components used to build tools are sequentially numbered, so their mapping is in the comments  below in this sections so that they don't get mixed up.
				;!#### Sensors
				;!S0 is the temperature sensor on the heated bed and is defined in the "Heated Bed" section of this file.
				;!S1 is the temperature sensor on the extruder on Tool 0, and connected to pin "e0temp".
				;!S2 is the temperature sensor on the extruder on Tool 0, but not defined yet.
				
				
				;!#### Heaters
				;!Heater H0 is the bed heater and is defined in the "Heated Bed" section of this file.
				;!H1 is the heater for Extruder 1 and connected to the Duet 2 conenctor "E0 heater" and refered by pin name "e0heat". Heater defined in the tool 0 Filament Heater section.
				;!H2 is the heater reserved for Extruder 2 and connected to the Duet 2 conenctor "E1 heater" and refered by pin name "e1heat". Heater defined in the tool 0 Filament Heater section.
				;!H3 is the heater reserved for Extruder 3 and connected to the Duex 5 conenctor "E2 heater" and refered by pin name "!duex.e2heat". Heater defined in the tool 0 Filament Heater section.
				;!H4 is the heater reserved for Extruder 4 and connected to the Duet 2 conenctor "E3 heater" and refered by pin name "!duex.e2heat".	Heater defined in the tool 0 Filament Heater section.
				
				;!#### Fans
				;!F0 is the fan for Tool 0's  Hot end fan and connected to the Duet 2 board's "Fan 0" connector and referred to by pin name "fan0". It is defined in the Tool 0 Fan section.
				;!F1 is reserverd for a potential future enclosure cooling fan, along with the "Fan 1" connector on teh Duet 2 board. 
				;!F2 is the fan for Tool 0's Part cooling fan and connected to the Duet 2 board's "Fan 2" connector and referred to by pin name "fan2". It is defined in the Tool 0 Fan section.
				;!F3 is the fan reserved for Tool 1's  Hot end fan and connected to the DueX 5 board's "Fan 3" connector and referred to by pin name "duex.fan3". It is defined in the Tool 1 Fan section.
				;!F4 is the fan reserved for Tool 1's Part cooling fan and connected to the DueX 5 board's "Fan 4" connector and referred to by pin name "duex.fan4". It is defined in the Tool 1 Fan section.
				;!F5 is the fan reserved for Tool 2's  Hot end fan and connected to the DueX 5 board's "Fan 5" connector and referred to by pin name "duex.fan5". It is defined in the Tool 2 Fan section.
				;!F6 is the fan reserved for Tool 2's Part cooling fan and connected to the DueX 5 board's "Fan 6" connector and referred to by pin name "duex.fan6". It is defined in the Tool 2 Fan section.
				;!F7 is the fan reserved for Tool 3's  Hot end fan and connected to the DueX 5 board's "Fan 7" connector and referred to by pin name "duex.fan7". It is defined in the Tool 3 Fan section.
				;!F8 is the fan reserved for Tool 3's Part cooling fan and connected to the DueX 5 board's "Fan 8" connector and referred to by pin name "duex.fan8". It is defined in the Tool 3 Fan section.

;COMMON COMMANDS  **********************************
			;!### Common commands
			;!This section ahead of the individual tool definitions contains gcode commnds where one line must apply to all tools.
				;!####Extruder driver assignments
M584 E3:4    			;!Assign Duet connector "E0 motor" (driver #3) to Extruder 0, and connector "E1 Motor" (driver 4) to Extruder 1. 
						;!Add more exrtuders here as new tools are defined.
M92  E420:420			;! Set steps per mm Extruder: This works for our L3D Dual Drive Extruder with 17HS4023 Usongshine Stepper Motor. 
M203 E8000:8000  	;!Set Maximum speed of the extruders (mm/min). Depends on hot end and material.			
M201 E1300:1300		;!Set Max Acceleration (in mm/sec^2) of the extruder motors. The value for each extruder is separated by a colon.
M566 E3000:3000		;!Set Max instantaneous soeep change on extruders. Not sure this matters much for extruders. 

;TOOL 0 ********************************************
			;!### Tool 0 - Printhead 0
				;!This secion defines the parts of the tool (Extruders, fans, heaters, temperature sensors, etc) before declaring their collection a tool.
					
				;!#### Extruder 0
     			;!Extruder drive (marked as "E0 motor" on the Duet 2 board)	assigned in COMMON SOMMANDS section.
M569 P3 S1 D2   ;!Set the direction of the driver3 stepper and define it as spread cycle (Need to look at this to see if our 
				;!motor is the type that can handle this. 
				;!https://duet3d.dozuki.com/Wiki/Gcode?revisionid=HEAD#Section_M569_Set_motor_driver_direction_enable_polarity_and_step_pulse_timing
M572 D0 S0.1	;!Set pressure advance on Extruder Drive 0		
		

				
				;!#### Filament Heater (H1)
m308 S1 P"e0temp" Y"thermistor" T100000 B3950  A"Tool0 Hot end Temp"		;!Create a sensor(S) with ID 1, that uses a thermistor (Y) that is 100K ohms at at 25C(T)
																					;!and coefficient of 3950 (B)
M950 H1 C"e0heat" T1    ;!Define a Heater (H) with ID 1, map output to pin (C) named "e0heat", and associate with the temperature sensor we earlier named "S0"	     
						;!Heater  H1 defined in the heater definition section before tool definitions.
;M301 H1    				;! Set the PID values for this heater (H0). Values can be found using M303 (we need a macro for this)
;M307 H1 B0 R3.807 C137.1:120.9 D14.32 S1.00 V24.1 ;!Set the heater control parameters. These were found using the M303 command.
M307 H1 B0 R3.807 C137.1:120.9 D14.32 S0.5 V24.1 ;!Set the heater control parameters. These were found using the M303 command.
M570 H1 S30     		;! Print will be terminated if a heater fault is not reset within 30 minutes.
M143 H1 S260    		;! Set Maximum H1 (Extruder) heater temperature
M568 P0 R180 S210 A0 	;! Set tool 0 standby temp to 180, active temperature to 210, but turn the heater off (A0)

				;!#### Fans
				;! Set up the extruder fan and the part cooling fan.
M950 F0 C"fan0" 	;! Define that Fan 0 is connected to pin named "fan0". This is the hot end fan.
M106 P0 T45 S1.0 H1	;! Turn on Fan 0 (P0 - the Hot End fan) to 100% (S1.0) when the heater H1 get above 45 degs.  This command migght belong in the tpre0.g file so it gets initialted when the tool is selected.
M950 F2 C"fan2"		;! Define that Fan 0 is connected to pin named "fan0". this is the part cooling fan.
M106 P2 T45 S1.0 H1	;! Turn on Fan 2 (P2 - the part cooling fan) to 100% (S1.0) when the heater H1 get above 45 degs.  This command migght belong in the tpre0.g file so it gets initialted when the tool is selected.

				;!#### Define the tool
				;!Now that all the pieces are defined, pull them together into a tool.	
M563 P0 S"Extruder 0" D0 H1 F0   ;! Define tool #0 (P0) with name "Extruder 0", using motor driver 3 (D0) (first drive defined after the axes), and Fan 0

				;!#### Extruder offsets
				;!These offsets are used to create a translation so the nozzle will go to the correct X,Y,Z location 
G10 P0 X-3.5 Y38.5 Z.45   ;! Set tool 0 offset from machine coordinates. These values are subtracted from machine coordinates to get tool coordinate to move to.


;TOOL 1 - NEEDS TO BE FINISHED ******************************************
			;!### Tool 1 - Printhead 1
				;!This secion defines the parts of the tool (Extruders, fans, heaters, temperature sensors, etc) before declaring their collection a tool.
     			;!Extruder drive (marked as "E1 motor" on the Duet 2 board)	assigned in COMMON SOMMANDS section.
M569 P4 S1 D2   ;!Set the direction of the driver4 stepper and define it as spread cycle (Need to look at this to see if our 
				;!motor is the type that can handle this. 
				;!https://duet3d.dozuki.com/Wiki/Gcode?revisionid=HEAD#Section_M569_Set_motor_driver_direction_enable_polarity_and_step_pulse_timing
				

;TOOL 2 - NEEDS TO BE FINISHED ******************************************
			;!### Tool 2 - Printhead
				;!This secion defines the parts of the tool (Extruders, fans, heaters, temperature sensors, etc) before declaring their collection a tool.
				;!Extruder drive (marked as "????" on the Duet 2 or Duex 5 board)	assigned in COMMON SOMMANDS section.	
;M569 P5 S1 D2   ;!Set the direction of the driver5 stepper and define it as spread cycle (Need to look at this to see if our 
				;!motor is the type that can handle this. 
				;!https://duet3d.dozuki.com/Wiki/Gcode?revisionid=HEAD#Section_M569_Set_motor_driver_direction_enable_polarity_and_step_pulse_timing


;TOOL 3 - NEEDS TO BE FINISHED ******************************************



;END OF TOOL SETUP SECTION
;###############################################



;###############################################
;START OF STEPPER MOTOR INTERPOLATION (MICROSTEPS) AND CURRENT CONFIG SECTION
			;!### Stepper Interpolation
			;!This section sets up sub-step interpolation on the drivers. These commands must be some place after the last m584 (driver definition) command to these are here and not with the sections that define the drivers (doesn't make sense does it?)
M350 X16 I1 		;!Set 16x microstepping for the X stepper driver. Use interpolation.
M350 Y16 I1 		;!Set 16x microstepping for the Y stepper driver. Use interpolation.
M350 Z16 I1			;!Set 16x microstepping for the Z stepper driver. Use interpolation.
M350 U4 I1 	        ;!Set 4x microstepping for the tool lock/inlock stepper drive. Use interpolation.
M350 E16:16 I1 	;!Set 16x microstepping for each of the three Extruders. Use interpolation.

			
			;!### Motor Currents
			;!Ths section sets up the peak motor drive currents. Do not exceed 90% of full XY motor current rating without heatsinking the XY motor drivers. Another gcode that needs to come after all M584 commands		
M906 X2263 Y2263    	;! LDO XY motor currents (mA). 2263mA is 80% of 2828mA Peak Current. (2828mA Peak is 2000mA RMS)
M906 Z1600          	;! LDO ZZZ Motor currents (mA). Conservative.  *Need to look up our NEMA 17 motors and maybe adjust this* 
M906 E900:900           ;! Extruder Motor currents E (mA). *Need to look up our extruder 17 motors and maybe adjust this*
M906 U670	            ;! LDO Toolchanger Elastic Lock motor current (mA) and idle motor percentage.
M906 I60				;! Set idle current as a percentage of peak.   Note: Idle current setting is common across all motors (XYZZZU).Default is 30, why are we 60?
                                        
;END OF STEPPER MOTOR INTERPOLATION (MICROSTEPS) AND CURRENT CONFIG SECTION
;###############################################




;###############################################
;START OF HEATED BED CONFIG SECTION
		;!## Define the heated bed.
			;!### Define the Bed temperature sensor
			;!Create a sensor(S) with ID "BED", that uses a thermistor (Y) that is 100K ohms at at 25C(T)  and coefficient of 3950 (B)
M308 S0 P"bedtemp"  Y"thermistor" T100000 B3950 A"Bed Temp" 

			;!### Define the bed heater and map the temp sensor to it.
			;!Define Heater (H) with ID 0, map output to pin (C) named "bedheat",  and associate with temperature sensor we earlier named "Bed" P0 S"Bed" T10000 B3984 H0 L160          
M950 H0 C"bedheat" T0   ;!Define Heater (H) with ID 0, map output to pin (C) named "bedheat", and associate with temperature sensor we earlier 
							;!named "Bed" P0 S"Bed" T10000 B3984 H0 L160BOM-specified Terminal Lug Thermistor values. (Not for L3D)
M140 H0					    ;!Map Heated bed to Heater H0...added for L3D. Not clear is this command is really needed with RR3 fw and M308
M143 H0 S100                ;! Set Maximum H0 (Bed) heater temperature
;M307 H0 A270.7 C90.4 D6.7 B0 S1.0           ; Default Bed Heater Parameters, before tuning / if config-override.g is missing
M304 P25 I0.400 D66.3	    ;! Set the PID parameters for the bed heater. These are TEST values. Try M303 for heater tuning.

;END OF HEATED BED CONFIG SECTION
;###############################################




;###############################################
;START OF Z_PROBE AND MESH BED COMPENSATION CONFIG SECTION

		;!## z-Probe and Mesh Bed Compensation Settings. 
		;!Define the z probe we are using and the parameters for that probe. Also define the bed unevenness compensation. 
		
		;!### Define the probe type and usage
if global.Z_Probe_Type = "prox" 
  ;M558 P5 C"zprobe.in" H3 A1 T10000 F600:30 S0.02  ;!Probe definition:     ; use when probe connected to z-probe connector
  M558 P5 C"e1stop" H3 A1 T10000 F600:30 S0.02  ;!Probe definition:
  ;!- probe type is a switch (P5) 
  ;!- connected to pin "zprobe.in"
  ;!- using dive height (fast move to this z) 3mm (H3)
  ;!- on probe request, probe the location 1 time (A1)
  ;!- the a travel speed between points is 10000mm.min (T10000)
   ;!- using a dual probe speed Zmovement) 3000mm/min to get close, then 100mm/min for accuracy
  ;!- with a tolerance of 0.02mm for multiple probes (probes out of tolerance will be repeated).	
elif global.Z_Probe_Type = "touch" 
  M558 P9 C"^zprobe.in" H3 A1 T10000 F600:30 S0.02  ;!Probe definition:
  ;!- P4 = probe type is a switch connected to something other than the z-endstop switch. 
  ;!- ^C4 = connected to E1 endstop connector. the "^" character enables the pullup resistor
  ;!- H3 = using dive height (fast move to this z) 3mm
  ;!- A1 = on probe request, probe the location 1 time
  ;!- T = the a travel speed between points is 10000mm.min (T10000)
  ;!- F = using a dual probe speed Zmovement) 600mm/min to get close, then 30mm/min for accuracy
  ;!- s = with a tolerance of 0.02mm for multiple probes (probes out of tolerance will be repeated).
  M950 S0 C"!duex.pwm5"                 ;! Define probe deployment pine for the BLTouch probe.
  ;! S0 = define this connector as Servo #0
  ;! C"!duex.pwm5" = create this servo 0 on pwm5 pin on DuEx board. Aliases for this pin are: exp.heater7, exp.31, !duex.e6heat, !duex.pwm5
  ;! web reference:  https://duet3d.dozuki.com/Wiki/RepRapFirmware_3_overview#Section_Pin_names_for_Duet_2_WiFi_Ethernet
  ;M280 P0 S10                            ;! Send a control signal to Servo 0  (P0) to move to position "10" - Deploy.   NOT SURE WE WANT TO DEPLOY THE PROBE AT THIS TIME.
										 


		;!### Mesh bed compensation parameters
			;!Define probe area for mesh bed compensation. Used when G29 is called. This is where the mesh area is defined, the numbber of points to be probed are defined and the number of times each point is probed. Not in bed.g because bed leveling (G29) could be called without going through bed.g.
		 
M557 X0:{335 + global.Z_probe_Xoffset} Y{27+global.Z_probe_Yoffset}:{368 + global.Z_probe_Yoffset} P5		
			;!- Define bed compensation probing grid. Min and max X and Y box edges for probing, P5 defines 5 points in each direction (a 5 x 5 probe matrix). Chnged from S40 (40mm probe point spacing). 
			

		;!### X/Y positions of kinematic balls
			;!Define positions of the Z leadscrews or bed-leveling screws. Since we are using kinematic ball joints, these are the correct positions for us to use. Need to change the X and Y values after we settle on a physical position for machine X=0 and Y=0. We probably need to create a 0,0 target mark on the heated bed. 
			;! Locations are extracted from CAD model assuming:
				;   350x350mm build region offset from the 370x450mm plate.
				;   front left corner of build region is (0, 0).
M671 X-34:368.5:164 Y74:74:400 S10 ; Front Left: (-34, 74) | Front Right: (368.5, 74) | Back: (164, 400)			


;END OF Z_PROBE AND MESH BED COMPENSATION CONFIG SECTION
;###############################################




		;!## Other stuff
M593 F33.33  ;! Reduce resonances at 33Hz based on XY vibration pattern on prints. This value could use a second opinion.

M98 P"config-user.g"                    ; Load custom user config

M501                                    ; Load saved parameters from non-volatile memory

set global.all_loaded = "Yes"