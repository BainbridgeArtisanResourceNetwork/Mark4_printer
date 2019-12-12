### The Mark 4 Fusion 360 model

**2019-12-11 Current state of the model**

![Assembly, Mark4 printer v23](https://github.com/BainbridgeArtisanResourceNetwork/Mark4_printer/blob/master/Fusion360_model/images/2019_12_11_assembly.jpg)

- XY plate design updated from Mark 3 to fit our build volume.
- X and Y rails in place. Current issue - The X-rail in the model and the BOM is 15mm wide. Mark designed the bridge for a narrower rail. we'll need to fix this model.
- Dual bondtech clone extruder plus mosquito  hot ends modeled (roughly) along with the E3D tool changer (also roughly). This is for being sure we have space for the tool changer. More work will be needed in this area to get a more exact model of the tool changer and the extruder's mounting to it before we are sure we have the space correct.
- The model moves in the X and Y directions, with limits currently set to our 350mm x 350mm part size (plus the nozzle separation in the dual extruder).  The main plate is "grounded" in the model, so you can play with it in Fusion by grabbing the extruder with your mouse and moving it around (what fun!).
- Motors, pulleys, and belts are in roughly their correct positions. We need to verify belt thickness and look closely at the parts around the motors to be sure we like the belt paths there. I added parts to the BOM for building the standoffs under the pulleys and the motor. 

**Next steps with the model:**

- Add most belt segments (I'll skip the ones that get longer and shorter as the bridge moves).
- Add 4080 posts  and base plate.
- I also plan to look at a different mounting scheme for the bridge that would shorten all of the standoffs in the design. Might not be worth the effort, but something I want to look at.





**About the stuff in this directory:**

This directory of the repo contains the "master" versions of the parts we are assembling into the BARN Mark4 printer. It also contains a Fusion 360 assembly of many (most, probably not all) of these parts.

We are trying to accommodate Fusion360 users with Personal licenses, which means that we cannot have a shared project in Fusion360. As a result we are using the following process to create the assembly file here. You can create your own assembly file using this process or upload ours into your own Fusion 360 project.

Our Fusion 360 process (updated 12/11/2019):

1. Individual part designs (or subassemblies, in some cases) are added to the Mark 4 project in one members (Mike's at present) Fusion account.  
2. Parts in the project are added to the Mark4 master assembly.
3. The resulting assembly file is Exported and put into this directory.

It's (still) a bit of a clumsy process, but anyone can upload the assembly into a project in their own Fusion account and the latest version of all the parts are added to the project too.  



A note from the assembler (currently Mike) : I am building the assembly "outward" from the print head. This means starting with the Xrail and adding a print head on it. , then restricting the motion of this to our target 350mm (plus some space for an offset second extruder). This is then added to the Y rails and similarly motion restricted (adding space for a future tool changer). After this we can add the CoreXY belts, pullies, motors, etc. and also a frame subassembly.
