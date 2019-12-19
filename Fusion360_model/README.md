### The Mark4 Fusion 360 model

**2019-12-16 Current state of the model**

Assembly V28:
![Assembly, Mark4 printer v23](https://github.com/BainbridgeArtisanResourceNetwork/Mark4_printer/blob/master/Fusion360_model/images/assembly_v45.jpg)

- Frame made from 4080 vertical rails is now in place, along with the base plate. 
- The X-rail in the model has been changed to a 12mm rail (from 15mm)
- Holes in the top plate have been added to allow us to use either NEMA 17 or NEMA 23 X and Y motors.
- A linear slide rail has been added for the the Z-axis. This is the rail Doug found on Ebay and contains the ball-screw, NEMA23 motor, slide rail, shaft coupling, and block, all built into a 2040 rail. I used this rather than the Mark3 design because I don;t have the details of the Mark3 and this is nearly the same. If we keep this, we'll need to change the mounting holes in the top and bottom plates.  



**Next steps with the model:**

- Add the build plate support and build plate. 

This will complete the "basic" design, then there are several things for us to look at before locking things in:

- A different mounting scheme for the bridge that would shorten all of the standoffs in the design. Might not be worth the effort, but something I want to look at.
- Assessing a three-rail (and motor) Z-axis vs a single rail, cantilevered design. 
- Alternate extruders, the Jubilee toolchanger, and alternate tools. We want to be sure we've got enough room to implement a toolchanger (maybe now, maybe later) in the design.
- Checking out how much we can extend the X, Y, and Z part dimensions. With the rails we have, we have some room to grow. It seems a waste to cut our rails shorter rather than be able to make bigger parts. 
- After these are done, we can  add both the main enclosure and the top enclosure.





**About the stuff in this directory (unchanged since 2019-12-11):**

This directory of the repo contains the "master" versions of the parts we are assembling into the BARN Mark4 printer. It also contains a Fusion 360 assembly of many (most, probably not all) of these parts.

We are trying to accommodate Fusion360 users with Personal licenses, which means that we cannot have a shared project in Fusion360. As a result we are using the following process to create the assembly file here. You can create your own assembly file using this process or upload ours into your own Fusion 360 project.

Our Fusion 360 process (updated 12/11/2019):

1. Individual part designs (or subassemblies, in some cases) are added to the Mark 4 project in one members (Mike's at present) Fusion account.  
2. Parts in the project are added to the Mark4 master assembly.
3. The resulting assembly file is Exported and put into this directory.

It's (still) a bit of a clumsy process, but anyone can upload the assembly into a project in their own Fusion account and the latest version of all the parts are added to the project too.  



A note from the assembler (currently Mike) : I am building the assembly "outward" from the print head. This means starting with the Xrail and adding a print head on it. , then restricting the motion of this to our target 350mm (plus some space for an offset second extruder). This is then added to the Y rails and similarly motion restricted (adding space for a future tool changer). After this we can add the CoreXY belts, pullies, motors, etc. and also a frame subassembly.
