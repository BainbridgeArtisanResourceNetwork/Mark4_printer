*this is an auto-generated md file for the **sys\config.g**  *gcode file. All comments in the original file with a '!' immediately following the ';' are collected here.*
<summary>connfig.g is the file that the Duet2 fw calls after power up to learn the HW configuration of the printer and get things started. This file has loads of stuff in it. It is where we defines motors, fans, heaters, etc with a numbers and map each one to the output connector on the board where we will plug in it's cable. It defines which motors are X, Y, Z, Extruder, or Utility and defines how a single step of the motor translates into the specific motion of the nozzle, filament, or whatever the motor is hooked to.  We use it to tell teh Duet2FW that we are a core-XY style printer, the size of the bed, where our homing switches are located, how many different tools we will have, etc. Just about everything that the controller fw needs to know so it can make parts is in this file.  Loads of good stuff that we need to get right. 

 Name the printer so it can identify itself. 

 Set up  Networking

 Set up  Debugging and define a log file location

 Set General Preferences. dimensions in mm, which fw to emulate, etc.

 Set up motors. Start be assigning Duet 2 motor drivers to specific axes. May be a good idea to map every driver in case we change where a cable is plugged in (the fw will remember old mapping if it is not overwritten)

 Kinematics. Define us as a CoreXY type printer. We should look at the M669 command info and decide if we need to add a matrix here to address an assumed 3:1 ratio in the Z motor. seeM669 in [Duet2 wiki](https://duet3d.dozuki.com/Wiki/Gcode?revisionid=HEAD#Section_M669_Set_kinematics_type_and_kinematics_parameters)

 Define posiotions of the Z leadscrews or bed-leveling screws. Since we are using kinematic ball joints, these are the correct positions for us to use. Need to change the X and Y values based on the homed values of X=0 and Y=0. We probably need to create a 0,0 target mark on the heated bed. 
 Axis and Motor Configuration. Set the transformation values for motor set to linear movement based on our motors, pulleys, etc.
 
 Define Thermistors

 PT100 Hotend Temperature Sensors. These require an external Breakout Board. For other configs, see the wiki:
 https://jubilee3d.com/index.php?title=Bondtech_Direct_Drive_Extruder 

Define Heaters


Mesh Bed Leveling Settings. Define points to probe for leveling compensation. Not in bed.g because bed leveling (G29) could be called directly.

 Z probing settings

 Reduce resonances at 33Hz based on XY vibration pattern on prints. This value could use a second opinion.
