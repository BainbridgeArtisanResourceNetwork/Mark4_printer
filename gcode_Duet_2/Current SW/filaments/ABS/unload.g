;!<summary>This file contains the steps that the machine will take when there is an unload request for PLA filament.  It includes messages to be displayed to the user ("Wait for the nozzle to heat", etc.). If the extruder is a bowden style, this is where the commands for pulling the filament back through the tube to the extruder will be. We probably need to figure out how to make a file that is both filament and tool specific. Differnet tools may have different load/unload requirements. And this maccro does not care if the tool is docked ot undocked.

;! Display a message for the user to wait for nozzle heating
M291 P"Please wait while the nozzle is being heated up" R"Unloading ABS" T5 ; Display message P, R is the title in the message window, Cancel message after T seconds

;!Heat the nozzle - we should replace G10 with M658. G10 is being deprecated.
G10 S180 ; Heat up the current tool to 180C ; 180C is probably too low for ABS.

;!Wait for the temperature to reach it's set point. We need to add a P to to this M116 to make it tool specific.
M116 ; Wait for the temperatures to be reached

;!The extruder is hot, execute a sequence of commands to load the filament.
M291 P"Retracting filament..." R"Unloading PLA" T5 ; Display another message
G1 E-20 F300 ;! Retract 20mm of filament at 300mm/min. slowly pull the filament out of the hot end.
G1 E-480 F3000 ;! Retract 480mm of filament at 3000mm/min Quickly pull the filament out of the bowden tube
M400 ; Wait for the moves to finish
M292 ; Hide the message again
M84 E0:1 ; Turn off extruder drives 1 and 2




