### The Mark4 Fusion 360 model

**2019-12-30 Current state of the model**

New Assembly V15:
![Assembly, Mark4 printer v23](https://github.com/BainbridgeArtisanResourceNetwork/Mark4_printer/blob/master/Fusion360_model/images/New_Assembly_V15.jpg)

- Added the Jubilee tool changer as a "volume placeholder" so that we can assess the impact/value of toolchangers with a better model than I could find for the E3D changer.  
  		
  * The Jubilee has a single nozzle extruder (not mosquito) and a Bondtech extruder. 
  * Both the old extruder and the Jubilee are in the model. If you turn them both on, you'll be really confused!
  * There is a part floating in the front of the frame. This houses the Jubilee's tool-changing motor, which uses a cable to latch and unlatch the tools during a tool-change.  
  * I put in the Jubilee as-is, but we'd need to make changes if we want to pursue it. The jubilee X-rail is mounted to the bottom of the bridge, and the tool docks as-imported and placed interfere with the belts at the back of the frame. 
  
   



**Next steps with the model:**

- Make some decisions about a tool changer - do we have one, and if so, which one? I'm personally leaning towards having one, even if we only change tools by hand. It's a handy way to easily swap tools. 
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
