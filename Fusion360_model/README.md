### The Mark 4 Fusion 360 model

This directory of the repo contains the "master" versions of the parts we are assembling into the BARN Mark4 printer. It also contains a Fusion 360 assembly of many (most, probably not all) of these parts.

We are trying to accommodate Fusion360 users with Personal licenses, which means that we cannot have a shared project in Fusion360. As a result we are using the following process to create the assembly file here. You can create your own assembly file using this process or upload ours into your own Fusion 360 project.

Our Fusion 360 process:

1. Individual part designs (or subassemblies, in some cases) are stored in this directory. Changes made to the design of these parts is done to these files.
2. The part files are uploaded to a Fusion 360 project on one member's computer and assembled using Fusion 360 joints. 
3. The resulting assembly file is Exported and put into this directory. 
4. We are trying really, really hard to NOT do part design work in the assembly file. The exception  may be adding join origins to parts that are imported. 

It's a bit of a clumsy process, particularly when updating parts with new versions. If someone has a better idea, please share it.  



A note from the assembler (currently Mike) : I am building the assembly "outward" from the print head. This means starting with the Xrail and adding a print head on it. , then restricting the motion of this to our target 350mm (plus some space for an offset second extruder). This is then added to the Y rails and similarly motion restricted (adding space for a future tool changer). After this we can add the CoreXY belts, pullies, motors, etc. and also a frame subassembly.