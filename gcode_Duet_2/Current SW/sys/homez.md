*this is an auto-generated md file for the **sys\homez.g**  *gcode file. All comments in the original file with a '!' immediately following the ';' are collected here.*
<summary>Called to home the Z axis.  This file is a macro to set z via the z-probe sensing the metal plate or aluminum bed </summary>
 Ask the user if the build plate is present or there is a metal piece on the buildplate, and nothing else on the buildplate. If no, don't do anything.
If X has not been homed, home x
 If Y has not been homed, home Y  
 Move the probe to the center of the bed
 Probe the bed and set the probe trigger point to Z=0
Set the Min:Max Z axis soft limits. Max position is value set when Y endstop is triggered. Not needed because its in the config.g file.
 Move to the selected z-probe offset.  This is the command where we define how far above plate we want z to bed
 After moving to the selected point, set this location to become Z=0
 Done
