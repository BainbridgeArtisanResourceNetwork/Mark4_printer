*this is an auto-generated md file for the **sys\config.g**  *gcode file. All comments in the original file with a '!' immediately following the ';' are collected here.*
<summary>connfig.g is the file that the Duet2 fw calls after power up to learn the HW configuration of the printer and get things started. This file has loads of stuff in it. It is where we defines motors, fans, heaters, etc with a numbers and map each one to the output connector on the board where we will plug in it's cable. It defines which motors are X, Y, Z, Extruder, or Utility and defines how a single step of the motor translates into the specific motion of the nozzle, filament, or whatever the motor is hooked to.  We use it to tell teh Duet2FW that we are a core-XY style printer, the size of the bed, where our homing switches are located, how many different tools we will have, etc. Just about everything that the controller fw needs to know so it can make parts is in this file.  Loads of good stuff that we need to get right. 

## Set printer name
Name the printer so it can identify itself. 
 Machine name and Netbios name
## Set up  Debugging and define a log file location
 Debug off
## Set General Preferences
Dimensions in mm, which fw to emulate, etc.
 Set to RepRapFirmware style gcode
 Set dimensions to millimeters
 Use absolute coordinates...
 ...but relative extruder moves
## Networking
 Set up networking parameters.
 Enable Network
 Enable HTTP
 Netmask
 Disable Telnet
## Define global variables
### Z PROBE X,Y offsets. 
Create two variables, global.Z_probe_Xoffset and global.ZZ_probe_Yoffset. These values can be ADDED to any the X and Y coordinates to move the probe to that position. the expression must be inside curly brackets {}.  This is useful because is lets us set the offset one time and use it lots of places.  Example: G0 x{100 + global.Z-probe-Xoffset}  Y{200 + global.Z-probe-Yoffset} moves the printhead so that the probe is over the machine point 100,200.
- Create variable  global.Z_probe_Xoffset and set it's value.
- Create variable  global.Z_probe_Yoffset and set it's value.

## Set up print head motion
This includes the motors, how they map to the the X,Y and Z axes, plus how motor steps translate to physical motion 
Before we start, clear all axis assignments so that we don't get unexpected motion.
### X-axis
Assign the X-axis motor to use driver0 (marked as "X" on the Duet 2 board)
Set the direction of the  driver0 (X) stepper.
Set Steps/mm for X motor...Modified/corrected Jubilee-defined from 200 to 160 on 10/29/2020
Set max X speed (mm/min) conservative. 18000+ possible on XY. Depends on tool.
Set max X acceleration (in mm/sec^2) for print moves.
Set Maximum instantaneous speed change in (mm/minute). Too low and curves are super slow, too fast and there may be ringing
Define an active high (S1) limit switch at the minX end (X1) connected to the xstop pin on the Duet2 board
Set the Min:Max X axis soft limits. Min position is value set when X endstop is triggered.
### Y-axis
Assign the Y-axis motor to use driver1 (marked as "Y" on the Duet 2 board)
Set the direction of the  driver1 (Y) stepper.
Set Steps/mm for Y motor...Modified/corrected Jubilee-defined from 200 to 160 on 10/29/2020
Set max Y speed (mm/min) conservative. 18000+ possible on XY. Depends on tool.
Set max Y acceleration (in mm/sec^2) for print moves.
Set Maximum instantaneous speed change in (mm/minute). Too low and curves are super slow, too fast and there may be ringing
Define an active high (S1) limit switch at the minY end (Y1) connected to the ystop pin on the Duet2 board
Set the Min:Max Y axis soft limits. Min position is value set when Y endstop is triggered.
### Z-axis
Assign the Z-axis motor to use drivers 6,7,8 (marked as "E3", "E4", "E5" on the Duex Expander board)
 Set the direction of the  driver6 (Front-Left Z) stepper
 Set the direction of the  driver7 (Front-Right Z) stepper 
 Set the direction of the  driver8 (Rear Z) stepper
 Set Steps/mm for Z for a T8x2 leadscrew and 0.9mm stepper. Calculation:  (16 * 400)/2
 Set max Z speed (mm/min) conservative. 
 Set max Z acceleration (in mm/sec^2) for print moves.
 SetMaximum instantaneous speed change in (mm/minute). Too low and movement may be jerky if mesh bed compensation is used (we do use it).
 Define an active high (S1) limit switch at the MaxZ end (Z1) connected to the zstop pin on the Duet2 board
Set the Min:Max Z axis soft limits. Max position is value set when Y endstop is triggered if using the endstop at the bottom of the travel.
### X-Y Kinematics. 
Define us as a CoreXY type printer. We should look at the M669 command info and decide if we need to add a matrix here to address an assumed 3:1 ratio in the Z motor. seeM669 in [Duet2 wiki](https://duet3d.dozuki.com/Wiki/Gcode?revisionid=HEAD#Section_M669_Set_kinematics_type_and_kinematics_parameters)
## Set up the Tool lock/unlock Actuator
Need to investifate if the U axis should be defined as rotational
 Assign the Tool lock actuator motor to use driver2 (marked as "Zmotor" on the Duet 2 board)		
 Set the direction of the  driver2 (tool lock/unlock actuator) stepper
 Set Steps/deg for U. Caclulation: (200 * 4 * 13.76)/360
 Set Maximum speed (mm/min) of the stepper locking and unlocking the tool lock.
 Set LDO Max Acceleration (mm/s^2) of the stepper controlling the lock/unlock 
 Set Maximum instantaneous speed change in (mm/minute).
 Define an active high (S1) limit switch at the min end (U1) connected to the ######### pin on the Duet2 board.
 *Need to select a pin for this use and uncomment this line line*
 Set Elastic Lock (U axis) Min:max soft limits on rotation angle.	Min position is set when switch is triggered.	
## Tool Definition and setup
### Heater, sensor and Fan Definitions
The components used to build tools are sequentially numbered, so their mapping is in the comments  below in this sections so that they don't get mixed up.
#### Sensors
S0 is the temperature sensor on the heated bed and is defined in the "Heated Bed" section of this file.
S1 is the temperature sensor on the extruder on Tool 0, and connected to pin "e0temp".
S2 is the temperature sensor on the extruder on Tool 0, but not defined yet.
#### Heaters
Heater H0 is the bed heater and is defined in the "Heated Bed" section of this file.
H1 is the heater for Extruder 1 and connected to the Duet 2 conenctor "E0 heater" and refered by pin name "e0heat". Heater defined in the tool 0 Filament Heater section.
H2 is the heater reserved for Extruder 2 and connected to the Duet 2 conenctor "E1 heater" and refered by pin name "e1heat". Heater defined in the tool 0 Filament Heater section.
H3 is the heater reserved for Extruder 3 and connected to the Duex 5 conenctor "E2 heater" and refered by pin name "!duex.e2heat". Heater defined in the tool 0 Filament Heater section.
H4 is the heater reserved for Extruder 4 and connected to the Duet 2 conenctor "E3 heater" and refered by pin name "!duex.e2heat".	Heater defined in the tool 0 Filament Heater section.
#### Fans
F0 is the fan for Tool 0's  Hot end fan and connected to the Duet 2 board's "Fan 0" connector and referred to by pin name "fan0". It is defined in the Tool 0 Fan section.
F1 is reserverd for a potential future enclosure cooling fan, along with the "Fan 1" connector on teh Duet 2 board. 
F2 is the fan for Tool 0's Part cooling fan and connected to the Duet 2 board's "Fan 2" connector and referred to by pin name "fan2". It is defined in the Tool 0 Fan section.
F3 is the fan reserved for Tool 1's  Hot end fan and connected to the DueX 5 board's "Fan 3" connector and referred to by pin name "duex.fan3". It is defined in the Tool 1 Fan section.
F4 is the fan reserved for Tool 1's Part cooling fan and connected to the DueX 5 board's "Fan 4" connector and referred to by pin name "duex.fan4". It is defined in the Tool 1 Fan section.
F5 is the fan reserved for Tool 2's  Hot end fan and connected to the DueX 5 board's "Fan 5" connector and referred to by pin name "duex.fan5". It is defined in the Tool 2 Fan section.
F6 is the fan reserved for Tool 2's Part cooling fan and connected to the DueX 5 board's "Fan 6" connector and referred to by pin name "duex.fan6". It is defined in the Tool 2 Fan section.
F7 is the fan reserved for Tool 3's  Hot end fan and connected to the DueX 5 board's "Fan 7" connector and referred to by pin name "duex.fan7". It is defined in the Tool 3 Fan section.
F8 is the fan reserved for Tool 3's Part cooling fan and connected to the DueX 5 board's "Fan 8" connector and referred to by pin name "duex.fan8". It is defined in the Tool 3 Fan section.
### Common commands
This section ahead of the individual tool definitions contains gcode commnds where one line must apply to all tools.
####Extruder driver assignments
Assign Duet connector "E0 motor" (driver #3) to Extruder 0, and connector "E1 Motor" (driver 4) to Extruder 1. 
Add more exrtuders here as new tools are defined.
 Set steps per mm Extruder: This works for our L3D Dual Drive Extruder with 17HS4023 Usongshine Stepper Motor. 
Set Maximum speed of the extruders (mm/min). Depends on hot end and material.			
Set Max Acceleration (in mm/sec^2) of the extruder motors. The value for each extruder is separated by a colon.
Set Max instantaneous soeep change on extruders. Not sure this matters much for extruders. 
### Tool 0 - Printhead 0
This secion defines the parts of the tool (Extruders, fans, heaters, temperature sensors, etc) before declaring their collection a tool.
#### Extruder 0
Extruder drive (marked as "E0 motor" on the Duet 2 board)	assigned in COMMON SOMMANDS section.
Set the direction of the driver3 stepper and define it as spread cycle (Need to look at this to see if our 
motor is the type that can handle this. 
https://duet3d.dozuki.com/Wiki/Gcode?revisionid=HEAD#Section_M569_Set_motor_driver_direction_enable_polarity_and_step_pulse_timing
Set pressure advance on Extruder Drive 0		
#### Filament Heater (H1)
Create a sensor(S) with ID 1, that uses a thermistor (Y) that is 100K ohms at at 25C(T)
and coefficient of 3950 (B)
Define a Heater (H) with ID 1, map output to pin (C) named "e0heat", and associate with the temperature sensor we earlier named "S0"	     
Heater  H1 defined in the heater definition section before tool definitions.
 Set the PID values for this heater (H0). Values can be found using M303 (we need a macro for this)
Set the heater control parameters. These were found using the M303 command.
Set the heater control parameters. These were found using the M303 command.
 Print will be terminated if a heater fault is not reset within 30 minutes.
 Set Maximum H1 (Extruder) heater temperature
 Set tool 0 standby temp to 180, active temperature to 210, but turn the heater off (A0)
#### Fans
 Set up the extruder fan and the part cooling fan.
 Define that Fan 0 is connected to pin named "fan0". This is the hot end fan.
 Turn on Fan 0 (P0 - the Hot End fan) to 100% (S1.0) when the heater H1 get above 45 degs.  This command migght belong in the tpre0.g file so it gets initialted when the tool is selected.
 Define that Fan 0 is connected to pin named "fan0". this is the part cooling fan.
 Turn on Fan 2 (P2 - the part cooling fan) to 100% (S1.0) when the heater H1 get above 45 degs.  This command migght belong in the tpre0.g file so it gets initialted when the tool is selected.
#### Define the tool
Now that all the pieces are defined, pull them together into a tool.	
 Define tool #0 (P0) with name "Extruder 0", using motor driver 3 (D0) (first drive defined after the axes), and Fan 0
#### Extruder offsets
These offsets are used to create a translation so the nozzle will go to the correct X,Y,Z location 
 Set tool 0 offset from machine coordinates. These values are subtracted from machine coordinates to get tool coordinate to move to.
### Tool 1 - Printhead 1
This secion defines the parts of the tool (Extruders, fans, heaters, temperature sensors, etc) before declaring their collection a tool.
Extruder drive (marked as "E1 motor" on the Duet 2 board)	assigned in COMMON SOMMANDS section.
Set the direction of the driver4 stepper and define it as spread cycle (Need to look at this to see if our 
motor is the type that can handle this. 
https://duet3d.dozuki.com/Wiki/Gcode?revisionid=HEAD#Section_M569_Set_motor_driver_direction_enable_polarity_and_step_pulse_timing
### Tool 2 - Printhead
This secion defines the parts of the tool (Extruders, fans, heaters, temperature sensors, etc) before declaring their collection a tool.
Extruder drive (marked as "????" on the Duet 2 or Duex 5 board)	assigned in COMMON SOMMANDS section.	
Set the direction of the driver5 stepper and define it as spread cycle (Need to look at this to see if our 
motor is the type that can handle this. 
https://duet3d.dozuki.com/Wiki/Gcode?revisionid=HEAD#Section_M569_Set_motor_driver_direction_enable_polarity_and_step_pulse_timing
### Stepper Interpolation
This section sets up sub-step interpolation on the drivers. These commands must be some place after the last m584 (driver definition) command to these are here and not with the sections that define the drivers (doesn't make sense does it?)
Set 16x microstepping for the X stepper driver. Use interpolation.
Set 16x microstepping for the Y stepper driver. Use interpolation.
Set 16x microstepping for the Z stepper driver. Use interpolation.
Set 4x microstepping for the tool lock/inlock stepper drive. Use interpolation.
Set 16x microstepping for each of the three Extruders. Use interpolation.
### Motor Currents
Ths section sets up the peak motor drive currents. Do not exceed 90% of full XY motor current rating without heatsinking the XY motor drivers. Another gcode that needs to come after all M584 commands		
 LDO XY motor currents (mA). 2263mA is 80% of 2828mA Peak Current. (2828mA Peak is 2000mA RMS)
 LDO ZZZ Motor currents (mA). Conservative.  *Need to look up our NEMA 17 motors and maybe adjust this* 
 Extruder Motor currents E (mA). *Need to look up our extruder 17 motors and maybe adjust this*
 LDO Toolchanger Elastic Lock motor current (mA) and idle motor percentage.
 Set idle current as a percentage of peak.   Note: Idle current setting is common across all motors (XYZZZU).Default is 30, why are we 60?
## Define the heated bed.
### Define the Bed temperature sensor
Create a sensor(S) with ID "BED", that uses a thermistor (Y) that is 100K ohms at at 25C(T)  and coefficient of 3950 (B)
### Define the bed heater and map the temp sensor to it.
Define Heater (H) with ID 0, map output to pin (C) named "bedheat",  and associate with temperature sensor we earlier named "Bed" P0 S"Bed" T10000 B3984 H0 L160          
Define Heater (H) with ID 0, map output to pin (C) named "bedheat", and associate with temperature sensor we earlier 
named "Bed" P0 S"Bed" T10000 B3984 H0 L160BOM-specified Terminal Lug Thermistor values. (Not for L3D)
Map Heated bed to Heater H0...added for L3D. Not clear is this command is really needed with RR3 fw and M308
 Set Maximum H0 (Bed) heater temperature
 Set the PID parameters for the bed heater. These are TEST values. Try M303 for heater tuning.
## z-Probe and Mesh Bed Compensation Settings. 
Define the z probe we are using and the parameters for that probe. Also define the bed unevenness compensation. 
### Define the probe type and usage
Probe definition:
- probe type is a switch (P5) 
- connected to pin "zprobe.in"
- using dive height (fast move to this z) 3mm (H3)
- on probe request, probe the location 1 time (A1)
- the a travel speed between points is 10000mm.min (T10000)
- using a dual probe speed Zmovement) 3000mm/min to get close, then 100mm/min for accuracy
- with a tolerance of 0.02mm for multiple probes (probes out of tolerance will be repeated).	
### Mesh bed compensation parameters
Define probe area for mesh bed compensation. Used when G29 is called. This is where the mesh area is defined, the numbber of points to be probed are defined and the number of times each point is probed. Not in bed.g because bed leveling (G29) could be called without going through bed.g.
- Define bed compensation probing grid. Min and max X and Y box edges for probing, P5 defines 5 points in each direction (a 5 x 5 probe matrix). Chnged from S40 (40mm probe point spacing). 
### X/Y positions of kinematic balls
Define positions of the Z leadscrews or bed-leveling screws. Since we are using kinematic ball joints, these are the correct positions for us to use. Need to change the X and Y values after we settle on a physical position for machine X=0 and Y=0. We probably need to create a 0,0 target mark on the heated bed. 
 Locations are extracted from CAD model assuming:
## Other stuff
 Reduce resonances at 33Hz based on XY vibration pattern on prints. This value could use a second opinion.
