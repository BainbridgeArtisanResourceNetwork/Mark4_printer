*this is an auto-generated md file for the **sys\tpost1.g**  *gcode file. All comments in the original file with a '!' immediately following the ';' are collected here.*
<summary> called after tool 1 has been selected Based on the fact that there is a "warm up heaters command" already in this file, I assume this is called after the new tool has been attached to the tool carrier. The next steps would be:

1. Heat the nozzle (maybe do this earlier?)
2. Swith to the coordinate system for this tool (this adjusts the X, and Y offsets for this tool and also loads its new Z-offset)
3. When the nozzle is heated, execute the wiping macro (if we make one).
4. Move back to the remembered location 