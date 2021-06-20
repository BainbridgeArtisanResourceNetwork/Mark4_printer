*this is an auto-generated md file for the **sys\tfree1.g**  *gcode file. All comments in the original file with a '!' immediately following the ';' are collected here.*
<summary> called when tool 1 is freed. I assume this means the steps to take when the tool is no longer needed. I think those steps are:

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