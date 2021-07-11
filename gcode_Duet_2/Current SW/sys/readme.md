# sys directory
This is the Big Kahuna directory. It is where gcode files provided with the Duet2 are stored. Most of them are "macros", meant to be called from another gcode file, or started by a specific button on the web interface (example: bed.g is executed when the web interface button that requests bed leveling is selected).  Many/most/maybe all of the files need to be modified to match the specific printer HW implementation. One of the most important files is config.g, where all the details for initializing the Duet2 controller board with our hardware configuration.

### bed.g
 bed.g is called directly by the G32 gcode. It ultimately uses the G30 command that collects Z-probe heights at specifed locations, then calls the option (S3) for the FW to adjust the three z-motors so that the z-probe height at the three locations will be equal, and we the bed should be co-planar with the plane described by the XY movement reach of the nozzle. This process is described in this Duet2 web page. [DUET 3-motor bed leveling](https://duet3d.dozuki.com/Wiki/Bed_levelling_using_multiple_independent_Z_motors)
 

### config-override.g
config-override.g holds the configuration parameters that were saved when you last ran M500. Your config.g file should normally include command M501 near the end, to load these saved values at startup and override any similar commands earlier in config.g.
### config.g
connfig.g is the file that the Duet2 fw calls after power up to learn the HW configuration of the printer and get things started. This file has loads of stuff in it. It is where we defines motors, fans, heaters, etc with a numbers and map each one to the output connector on the board where we will plug in it's cable. It defines which motors are X, Y, Z, Extruder, or Utility and defines how a single step of the motor translates into the specific motion of the nozzle, filament, or whatever the motor is hooked to.  We use it to tell teh Duet2FW that we are a core-XY style printer, the size of the bed, where our homing switches are located, how many different tools we will have, etc. Just about everything that the controller fw needs to know so it can make parts is in this file.  Loads of good stuff that we need to get right. 


### homeall.g
Called to home all axes. Updated 7/4/2021. This file calls homex.g, homey.g and homez.g macros in succession. 
### homedelta.g
 Example Homing file for RepRapFirmware on delta printer. We should delete this file since we are not a delta printer.
### homeu.g
Home the U axis. In our implementation, the U axis is the motor that locks tools onto the moving tool-plate. 
### homex.g
Called to home the X axis. Lowers the print bed (to clear anything on it), move to the end stop quickly to get rought positioning, then again slowly to be more precise. After finding the end move off a bit. If we mark a 0,0 on the aluminum bed and measure the offset fmo the endstop trigger, we can change that step to "move to x=0.  
### homey.g
Called to home the Y axis. Lowers the print bed (to avoid hitting anything on it), move to the end stop quickly to get rought positioning, then again slowly to be more precise. After finding the end move off a bit. If we mark a 0,0 on the aluminum bed and measure the offset fmo the endstop trigger, we can change that step to "move to Y=0.  
### homez.g
Called to home the Z axis.  This file is a macro to set z via the z-probe sensing the metal plate or aluminum bed 
### homez_original.g
Called to home the Z axis. Currently lowers the heated bed looking for an endstop switch at the bottom of the Z travel (max Z). Then the z value at that loction is set based on the M574 command in the gonfig.g file. We should look at switching to using the Z-probe as the homing point (and keep the lower z-endstop as a safety switch). The new process would be to check if X and Y were homed, and if not, home them first. Then move to a position where the Z-probe os over the center of the printable area of the bed and find the probe trigger like we did with the X and Y. This can avoid dropping the bed all the way down adn running it back up.  
 called when a print from SD card is paused. We should decide if this is what we want to do. If we add a wiping brush, maybe we travel over that. Also maybe move the tool to Xmin and Ymax.
 called before a print from SD card is resumed. Need to review this and decide if it's what we want on a resume. 
 called after config.g. When it has been executed, it is automatically deleted! Not really sure what the point of the steps in this file are.
 called when M1 (Sleep) is being processed. Currently there are no commands in this file and we need to learm why M1 would be called and then add any commands we think are appropriate. Maybe shut off all heaters and fans, disable steppers?
 called when M0 (Stop) is run (e.g. when a print from SD card is cancelled) Currently no commands are in this file. We need to decide what the steps we want performed on this trigger and add them to this file.
 tfreeN.g is called when tool N has already been "selected" (is in use) and another tool is requested. Executing this command "frees" up the tool holder frm tool N. Further reading [HERE](https://duet3d.dozuki.com/Wiki/ConfiguringRepRapFirmwareCartesianPrinter#Section_Tool_change_files)]  I assume this means the steps to take when the tool is no longer needed. I think those steps are:

0. Remember the tool location. 
1. Lower the bed a bit.
2. Retract the filament a bit.
3. Call the nozzle wiping macro (if we make one).
4. Set the nozzle temperature to a standby value.
5. Move the tool in front of the tool dock.
6. move the tool into the dock.
7. Call the macro that turns the tool latch to the unlatched position.
8. Move the tool carrier back from the tool dock.
9. Perform some task that confirms the tool was really left on the dock and is not still attached to the carrier, or fell out of the dock. No idea how to do this yet.
10. Return to the remembered location.  

 tfreeN.g is called when tool N has already been "selected" (is in use) and another tool is requested. Executing this command "frees" up the tool holder frm tool N. Further reading [HERE](https://duet3d.dozuki.com/Wiki/ConfiguringRepRapFirmwareCartesianPrinter#Section_Tool_change_files)]  I assume this means the steps to take when the tool is no longer needed. I think those steps are:

0. Remember the tool location. 
1. Lower the bed a bit.
2. Retract the filament a bit.
3. Call the nozzle wiping macro (if we make one).
4. Set the nozzle temperature to a standby value.
5. Move the tool in front of the tool dock.
6. move the tool into the dock.
7. Call the macro that turns the tool latch to the unlatched position.
8. Move the tool carrier back from the tool dock.
9. Perform some task that confirms the tool was really left on the dock and is not still attached to the carrier, or fell out of the dock. No idea how to do this yet.
10. Return to the remembered location.  

tPostN. is the third macro called in transitions fm one tool to another. tpreM.g is used to dock the previous tool (M). The tpreN is used to preheat the new tool (N). Finally tpost.N (this macro) is used to get engage the tool and return to the starting position. 
Further reading [HERE](https://duet3d.dozuki.com/Wiki/ConfiguringRepRapFirmwareCartesianPrinter#Section_Tool_change_files)]  I think the things to go in are:
1. Lower the bed a bit so we don;t hit anything. 
2. Switch to the master coordinate system so we can find the tool dock.
3. Move to a position just in front of the tool dock.
4. Move the tool carrier into the docked tool position (advance Y).
5. Call the macro to lock the tool to the carriage.
6. Move backout of the dock. Hopefully we have something that verifies the tool is porperly docked. 
7. Switch to this tools coordinate system (means engage it's offsets in X, Y, and Z).
3. Execute the wiping macro (if we make one).
4. Move back to the remembered location 

tPostN. is the third macro called in transitions fm one tool to another. tpreM.g is used to dock the previous tool (M). The tpreN is used to preheat the new tool (N). Finally tpost.N (this macro) is used to get engage the tool and return to the starting position. 
Further reading [HERE](https://duet3d.dozuki.com/Wiki/ConfiguringRepRapFirmwareCartesianPrinter#Section_Tool_change_files)]  I think the things to go in are:
1. Lower the bed a bit so we don;t hit anything. 
2. Switch to the master coordinate system so we can find the tool dock.
3. Move to a position just in front of the tool dock.
4. Move the tool carrier into the docked tool position (advance Y).
5. Call the macro to lock the tool to the carriage.
6. Move backout of the dock. Hopefully we have something that verifies the tool is porperly docked. 
7. Switch to this tools coordinate system (means engage it's offsets in X, Y, and Z).
3. Execute the wiping macro (if we make one).
4. Move back to the remembered location 

preN.g starts the preheat for tool N. This macro is called when tool N is selected, and after tfreeM.g is run for any toolM that was already selected. Further reading [HERE](https://duet3d.dozuki.com/Wiki/ConfiguringRepRapFirmwareCartesianPrinter#Section_Tool_change_files)]  I think the things to go in are:
0. Heat the nozzle to it's target temperature.

preN.g starts the preheat for tool N. This macro is called when tool N is selected, and after tfreeM.g is run for any toolM that was already selected. Further reading [HERE](https://duet3d.dozuki.com/Wiki/ConfiguringRepRapFirmwareCartesianPrinter#Section_Tool_change_files)]  I think the things to go in are:
0. Heat the nozzle to it's target temperature.

### pause.g
 called when a print from SD card is paused. We should decide if this is what we want to do. If we add a wiping brush, maybe we travel over that. Also maybe move the tool to Xmin and Ymax.
### resume.g
 called before a print from SD card is resumed. Need to review this and decide if it's what we want on a resume. 
### runonce.g
 called after config.g. When it has been executed, it is automatically deleted! Not really sure what the point of the steps in this file are.
### sleep.g
 called when M1 (Sleep) is being processed. Currently there are no commands in this file and we need to learm why M1 would be called and then add any commands we think are appropriate. Maybe shut off all heaters and fans, disable steppers?
### stop.g
 called when M0 (Stop) is run (e.g. when a print from SD card is cancelled) Currently no commands are in this file. We need to decide what the steps we want performed on this trigger and add them to this file.
### tfree0.g
 tfreeN.g is called when tool N has already been "selected" (is in use) and another tool is requested. Executing this command "frees" up the tool holder frm tool N. Further reading [HERE](https://duet3d.dozuki.com/Wiki/ConfiguringRepRapFirmwareCartesianPrinter#Section_Tool_change_files)]  I assume this means the steps to take when the tool is no longer needed. I think those steps are:

0. Remember the tool location. 
1. Lower the bed a bit.
2. Retract the filament a bit.
3. Call the nozzle wiping macro (if we make one).
4. Set the nozzle temperature to a standby value.
5. Move the tool in front of the tool dock.
6. move the tool into the dock.
7. Call the macro that turns the tool latch to the unlatched position.
8. Move the tool carrier back from the tool dock.
9. Perform some task that confirms the tool was really left on the dock and is not still attached to the carrier, or fell out of the dock. No idea how to do this yet.
10. Return to the remembered location.  

### tfree1.g
 tfreeN.g is called when tool N has already been "selected" (is in use) and another tool is requested. Executing this command "frees" up the tool holder frm tool N. Further reading [HERE](https://duet3d.dozuki.com/Wiki/ConfiguringRepRapFirmwareCartesianPrinter#Section_Tool_change_files)]  I assume this means the steps to take when the tool is no longer needed. I think those steps are:

0. Remember the tool location. 
1. Lower the bed a bit.
2. Retract the filament a bit.
3. Call the nozzle wiping macro (if we make one).
4. Set the nozzle temperature to a standby value.
5. Move the tool in front of the tool dock.
6. move the tool into the dock.
7. Call the macro that turns the tool latch to the unlatched position.
8. Move the tool carrier back from the tool dock.
9. Perform some task that confirms the tool was really left on the dock and is not still attached to the carrier, or fell out of the dock. No idea how to do this yet.
10. Return to the remembered location.  

### tpost0.g
tPostN. is the third macro called in transitions fm one tool to another. tpreM.g is used to dock the previous tool (M). The tpreN is used to preheat the new tool (N). Finally tpost.N (this macro) is used to get engage the tool and return to the starting position. 
Further reading [HERE](https://duet3d.dozuki.com/Wiki/ConfiguringRepRapFirmwareCartesianPrinter#Section_Tool_change_files)]  I think the things to go in are:
1. Lower the bed a bit so we don;t hit anything. 
2. Switch to the master coordinate system so we can find the tool dock.
3. Move to a position just in front of the tool dock.
4. Move the tool carrier into the docked tool position (advance Y).
5. Call the macro to lock the tool to the carriage.
6. Move backout of the dock. Hopefully we have something that verifies the tool is porperly docked. 
7. Switch to this tools coordinate system (means engage it's offsets in X, Y, and Z).
3. Execute the wiping macro (if we make one).
4. Move back to the remembered location 

### tpost1.g
tPostN. is the third macro called in transitions fm one tool to another. tpreM.g is used to dock the previous tool (M). The tpreN is used to preheat the new tool (N). Finally tpost.N (this macro) is used to get engage the tool and return to the starting position. 
Further reading [HERE](https://duet3d.dozuki.com/Wiki/ConfiguringRepRapFirmwareCartesianPrinter#Section_Tool_change_files)]  I think the things to go in are:
1. Lower the bed a bit so we don;t hit anything. 
2. Switch to the master coordinate system so we can find the tool dock.
3. Move to a position just in front of the tool dock.
4. Move the tool carrier into the docked tool position (advance Y).
5. Call the macro to lock the tool to the carriage.
6. Move backout of the dock. Hopefully we have something that verifies the tool is porperly docked. 
7. Switch to this tools coordinate system (means engage it's offsets in X, Y, and Z).
3. Execute the wiping macro (if we make one).
4. Move back to the remembered location 

### tpre0.g
preN.g starts the preheat for tool N. This macro is called when tool N is selected, and after tfreeM.g is run for any toolM that was already selected. Further reading [HERE](https://duet3d.dozuki.com/Wiki/ConfiguringRepRapFirmwareCartesianPrinter#Section_Tool_change_files)]  I think the things to go in are:
0. Heat the nozzle to it's target temperature.

### tpre1.g
preN.g starts the preheat for tool N. This macro is called when tool N is selected, and after tfreeM.g is run for any toolM that was already selected. Further reading [HERE](https://duet3d.dozuki.com/Wiki/ConfiguringRepRapFirmwareCartesianPrinter#Section_Tool_change_files)]  I think the things to go in are:
0. Heat the nozzle to it's target temperature.

