*this is an auto-generated md file for the **sys\tpre1.g**  *gcode file. All comments in the original file with a '!' immediately following the ';' are collected here.*
<summary>called before tool 1 is selected. I think this means "when tool 1 is selected". No commands are in this file. I think the things to go in are:
0. remember the current location of the nozzle.
1. If another tool has been previously selected, execute the commands to park it (tpostN.g and tfreeN.g, I think).
2. Move the unloaded tool carrier in frmnt of tool dock1.
3. Move forward (Y direction) to engage tool1 in it's dock.
4. Call a macro that rotates the tool locking mechanism to the lock position.
5. Back out of the dool dock.
 I think that's it. If it is a tool change, whatever called this will call tpostN.g next
</summary>
