*this is an auto-generated md file for the **filaments\PLA\load.g**  *gcode file. All comments in the original file with a '!' immediately following the ';' are collected here.*
<summary>This file contains the steps that the machine will take when there is a load request for PLA filament.  It includes messages to be displayed to the user ("Wait for the nozzle to heat before inserting the filament", etc.). If the extruder is a bowden style, this is where the commands for shooting the filament through the tube to the hot end will be. We probably need to figure out how to make a file that is both filament and tool specific. Differnet tools may have different load/unload requirements. And this maccro does not care if the tool is docked ot undocked.
 Display a message for the user to wait for nozzle heating
Heat the nozzle - we should replace G10 with M658. G10 is being deprecated.
Wait for the temperature to reach it's set point. We need to add a P to to this M116 to make it tool specific.
The extruder is hot, execute a sequence of commands to load the filament. 
 looks like this file was created for a bowden tube.
 Feed 10mm of filament at 600mm/min.  Initial grab of the filament by the extruder
 Feed 470mm of filament at 3000mm/min. Quickly Feed filament all the way to the hot end.
 Feed 20mm of filament at 300mm/min. Slowly feed filament into the hot end
 Retract 10mm of filament at 1800mm/min to releieve pressure in the hot end and forestall oozing.
 Turn off the heater again. Filament is loaded.