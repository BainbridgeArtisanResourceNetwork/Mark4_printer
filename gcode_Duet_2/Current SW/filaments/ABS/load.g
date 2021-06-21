;!<summary>This file contains the steps that the machine will take when there is a load request for ABS filament.  It includes messages to be displayed to the user ("Wait for the nozzle to heat before inserting the filament", etc.). If the extruder is a bowden style, this is where the commands for shooting the filament through the tube to the hot end will be. We probably need to figure out how to make a file that is both filament and tool specific. Differnet tools may have different load/unload requirements. And this maccro does not care if the tool is docked ot undocked.



;! Display a message for the user to wait for nozzle heating
M291 P"Please wait while the nozzle is being heated up" R"Loading ABS" T5 ; Display message P, R is the title in the message window, Cancel message after T seconds

;!Heat the nozzle - we should replace G10 with M658. G10 is being deprecated.
G10 S180 ; Set current tool temperature to 180C. Probably way too cool for ABS

;!Wait for the temperature to reach it's set point. We need to add a P to to this M116 to make it tool specific.
M116 ; Wait for the temperatures to be reached. M116 waits for all temperatures to get to their set points.

;!The extruder is hot, execute a sequence of commands to load the filament. 
M291 P"Feeding filament..." R"Loading ABS" T5 ; Display new message
M83 ; Extruder to relative mode

;! looks like this file was created for a bowden tube.

G1 E10 F600 ;! Feed 10mm of filament at 600mm/min.  Initial grab of the filament by the extruder

G1 E470 F3000 ;! Feed 470mm of filament at 3000mm/min. Quickly Feed filament all the way to the hot end.

G1 E20 F300 ;! Feed 20mm of filament at 300mm/min. Slowly feed filament into the hot end

G4 P1000 ; Wait one second
G1 E-10 F1800 ;! Retract 10mm of filament at 1800mm/min to releieve pressure in the hot end and forestall oozing.
M400 ; Wait for moves to complete
M292 ; Hide the message
G10 S0 ;! Turn off the heater again. Filament is loaded.