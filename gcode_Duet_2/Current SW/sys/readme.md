# sys directory
This is the Big Kahuna directory. It is where gcode files provided with the Duet2 are stored. Most of them are "macros", meant to be called from another gcode file, or started by a specific button on the web interface (example: bed.g is executed when the web interface button that requests bed leveling is selected).  Many/most/maybe all of the files need to be modified to match the specific printer HW implementation. One of the most important files is config.g, where all the details for initializing the Duet2 controller board with our hardware configuration.

### bed.g
 bed.g is called directly by the G32 gcode. It ultimately uses the G30 command that collects Z-probe heights at specifed locations, then calls the option (S3) for the FW to adjust the three z-motors so that the z-probe height at the three locations will be equal, and we the bed should be co-planar with the plane described by the XY movement reach of the nozzle. This process is described in this Duet2 web page. [DUET 3-motor bed leveling](https://duet3d.dozuki.com/Wiki/Bed_levelling_using_multiple_independent_Z_motors)
 

### config-override.g
No summary found in the gcode comments in this file.
### config.g
connfig.g is the file that the Duet2 fw calls after power up to learn the HW configuration of the printer and get things started. This file has loads of stuff in it. It is where we defines motors, fans, heaters, etc with a numbers and map each one to the output connector on the board where we will plug in it's cable. It defines which motors are X, Y, Z, Extruder, or Utility and defines how a single step of the motor translates into the specific motion of the nozzle, filament, or whatever the motor is hooked to.  We use it to tell teh Duet2FW that we are a core-XY style printer, the size of the bed, where our homing switches are located, how many different tools we will have, etc. Just about everything that the controller fw needs to know so it can make parts is in this file.  Loads of good stuff that we need to get right. 


### homeall.g
Called to home all axes. Currently duplicates the commands in the homex.g homey.g and homez.g. We should probably call those macros frmo this file rather than duplicating the steps here.
### homedelta.g
 Example Homing file for RepRapFirmware on delta printer. We should delete this file since we are not a delta printer.
### homeu.g
Home the U axis. In our implementation, the U axis is the motor that locks tools onto the moving tool-plate. 
### homex.g
Called to home the X axis. Lowers the print bed, move to the end stop quickly to get rought positioning, then again slowly to be more precise. After finding the end move off a bit. If we mark a 0,0 on the aluminum bed and measure the offset fmo the endstop trigger, we can change that step to "move to x=0.  
### homey.g
Called to home the Y axis. Lowers the print bed, move to the end stop quickly to get rought positioning, then again slowly to be more precise. After finding the end move off a bit. If we mark a 0,0 on the aluminum bed and measure the offset fmo the endstop trigger, we can change that step to "move to Y=0.  
### homez.g
Called to home the Z axis. Currently lowers the heated bed looking for an endstop switch at the bottom of the Z travel (max Z). Then z=0 is defined by the Z travel limit set in config.g. We should look at switching to using the Z-probe as the homing point (and keep the lower z-endstop as asafety switch). The new process would be to check if X and Y were homes, and if not, home them first. Then move to a position where the Z-probe os over the center of the printable area of the bed and find the probe trigger like we did with the X and Y. This can avoid dropping the bed all the way down adn running it back up.  
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
 called when tool 0 is freed. I assume this means the steps to take when the tool is no longer needed. I think those steps are:

0. Remember the tool location. 
1. Lower the bed a bit.
2. Retract the filament a bit.
3. Call the nozzle wiping macro (if we make one).
4. Set the nozzle temperature to a standby value.
5. Move the tool in front of the tool dock.
6. move teh tool into the dock.
7. Call the macro that turns the tool latch to the unlatched position.
8. Move the tool carrier back from the tool dock.
9. perform some task that confirms the tool was really left on the dock and is not still attached to the carrier, or fell out of the dock.No idea hoe to do this yet.
10. Return to the remembered location.  

### tfree1.g
 called when tool 1 is freed. I assume this means the steps to take when the tool is no longer needed. I think those steps are:

0. Remember the tool location. 
1. Lower the bed a bit.
2. Retract the filament a bit.
3. Call the nozzle wiping macro (if we make one).
4. Set the nozzle temperature to a standby value.
5. Move the tool in front of the tool dock.
6. move teh tool into the dock.
7. Call the macro that turns the tool latch to the unlatched position.
8. Move the tool carrier back from the tool dock.
9. perform some task that confirms the tool was really left on the dock and is not still attached to the carrier, or fell out of the dock.No idea hoe to do this yet.
10. Return to the remembered location.  

### tpost0.g
 called after tool 0 has been selected Based on the fact that there is a "warm up heaters command" already in this file, I assume this is called after the new tool has been attached to the tool carrier. The next steps would be:

1. Heat the nozzle (maybe do this earlier?)
2. Swith to the coordinate system for this tool (this adjusts the X, and Y offsets for this tool and also loads its new Z-offset)
3. When the nozzle is heated, execute the wiping macro (if we make one).
4. Move back to the remembered location 

### tpost1.g
 called after tool 1 has been selected Based on the fact that there is a "warm up heaters command" already in this file, I assume this is called after the new tool has been attached to the tool carrier. The next steps would be:

1. Heat the nozzle (maybe do this earlier?)
2. Swith to the coordinate system for this tool (this adjusts the X, and Y offsets for this tool and also loads its new Z-offset)
3. When the nozzle is heated, execute the wiping macro (if we make one).
4. Move back to the remembered location 

### tpre0.g
called before tool 0 is selected. I think this means "when tool 0 is selected". No commands are in this file. I think the things to go in are:
0. remember the current location of the nozzle.
1. If another tool has been previously selected, execute the commands to park it (tpostN.g and tfreeN.g, I think).
2. Move the unloaded tool carrier in frmnt of tool dock0.
3. Move forward (Y direction) to engage tool0 in it's dock.
4. Call a macro that rotates the tool locking mechanism to the lock position.
5. Back out of the dool dock.
 I think that's it. If it is a tool change, whatever called this will call tpostN.g next

### tpre1.g
called before tool 1 is selected. I think this means "when tool 1 is selected". No commands are in this file. I think the things to go in are:
0. remember the current location of the nozzle.
1. If another tool has been previously selected, execute the commands to park it (tpostN.g and tfreeN.g, I think).
2. Move the unloaded tool carrier in frmnt of tool dock1.
3. Move forward (Y direction) to engage tool1 in it's dock.
4. Call a macro that rotates the tool locking mechanism to the lock position.
5. Back out of the dool dock.
 I think that's it. If it is a tool change, whatever called this will call tpostN.g next

