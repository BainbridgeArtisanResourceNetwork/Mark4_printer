# filaments\PLA directory
This directory contains gcode macros (files) that are executed when ABS filament is selected to be loaded or unloaded.

The gcode files in this directory and the sumamries from their comments (if available) are listed below.

### load.g
This file contains the steps that the machine will take when there is a load request for PLA filament.  It includes messages to be displayed to the user ("Wait for the nozzle to heat before inserting the filament", etc.). If the extruder is a bowden style, this is where the commands for shooting the filament through the tube to the hot end will be. We probably need to figure out how to make a file that is both filament and tool specific. Differnet tools may have different load/unload requirements. And this maccro does not care if the tool is docked ot undocked.

### unload.g
This file contains the steps that the machine will take when there is an unload request for PLA filament.  It includes messages to be displayed to the user ("Wait for the nozzle to heat", etc.). If the extruder is a bowden style, this is where the commands for pulling the filament back through the tube to the extruder will be. We probably need to figure out how to make a file that is both filament and tool specific. Differnet tools may have different load/unload requirements. And this maccro does not care if the tool is docked ot undocked.

