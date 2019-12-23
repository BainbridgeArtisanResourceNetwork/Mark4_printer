### The Mark4 Fusion 360 model

**2019-12-23 Current state of the model**

New Assembly V10:
![Assembly, Mark4 printer v23](https://github.com/BainbridgeArtisanResourceNetwork/Mark4_printer/blob/master/Fusion360_model/images/New_Assembly_V10.jpg)

- Completely refactored the model
  		* Assembly is now built from linked subassemblies, and parts in those are not subassemblies are NOT linked. This makes for a simpler project file in Fusion and much much easier manipulation of the design. The downside (but a good tradeoff in your Fusion assembler's opinion) is that the subassemblies have a <u>lot</u> of user parameters. 
  		* Many more user parameters are now in place, and with the subassemblies, everything is not breaking when I change a design parameter. This will be important in our next big project step - locking in the dimensions.
  		* I've tried to arrange the design flow to produce a more logical timeline. AND I've tried to name everything (I probably missed a few things) to make it easier to find what you may be looking for.
- When I refactored the design, I also built around full-length X and Y rails. In the previous model, the purchased rails were longer than needed, so we would need to cut them down, or have length that was never traveled. In this model, I made the main XY plate and the bridge longer to fully utilize the purchased size of the rails.  With the working user parameters, we can make the printer bigger or smaller in real-time.
- I eliminated the 10mm spacer I had between the bridge and the blocks on the Y-Rails. This moves the belts closer to the XY plate - shorter standoffs for the pulleys and the motors. 
- I put in mounting holes for both NEMA 23 and 17 motors for X and Y. I also put moth motors in the design. You might want to turn one or the other off when you look at it to eliminate any confusion.  



**Next steps with the model:**

- Alternate extruders, the Jubilee tool changer, and alternate tools. We want to be sure we've got enough room to implement a tool changer (maybe now, maybe later) in the design. This is probably the biggest unknown right now and has the most impact on part size. The current design does not have the frame-side of the tool changer in place and we can't go much further on bog decision until there is something there that we feel is representative of an actual tool changer.
- Add the build plate support and build plate.

This will complete the "basic" design, then there are several things for us to look at before locking things in:

- Assessing a three-rail (and motor) Z-axis vs a single rail, cantilevered design. 
- After these are done, we can  add both the main enclosure and the top enclosure, electronics, etc..





**About the stuff in this directory (unchanged since 2019-12-11):**

This directory of the repo contains the "master" versions of the parts we are assembling into the BARN Mark4 printer. It also contains a Fusion 360 assembly of many (most, probably not all) of these parts.

We are trying to accommodate Fusion360 users with Personal licenses, which means that we cannot have a shared project in Fusion360. As a result we are using the following process to create the assembly file here. You can create your own assembly file using this process or upload ours into your own Fusion 360 project.

Our Fusion 360 process (updated 12/11/2019):

1. Individual part designs (or subassemblies, in some cases) are added to the Mark 4 project in one members (Mike's at present) Fusion account.  
2. Parts in the project are added to the Mark4 master assembly.
3. The resulting assembly file is Exported and put into this directory.

It's (still) a bit of a clumsy process, but anyone can upload the assembly into a project in their own Fusion account and the latest version of all the parts are added to the project too.  



A note from the assembler (currently Mike) : I am building the assembly "outward" from the print head. This means starting with the Xrail and adding a print head on it. , then restricting the motion of this to our target 350mm (plus some space for an offset second extruder). This is then added to the Y rails and similarly motion restricted (adding space for a future tool changer). After this we can add the CoreXY belts, pullies, motors, etc. and also a frame subassembly.
