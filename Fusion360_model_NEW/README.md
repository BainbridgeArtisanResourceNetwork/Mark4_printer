### The Mark4 Fusion 360 model

**2020-01-07 Current state of the model**

New Assembly V38:
![Assembly, Mark4 printer v23](https://github.com/BainbridgeArtisanResourceNetwork/Mark4_printer/blob/master/Fusion360_model_NEW/images/New_Assembly_V38.jpg)

Changes from V24:

* Changed X-RAIL,  Y-RAIL, and Z-RAIL sliding joint origins and limits so that the blocks move the full length of the rails. 
* Added build volume. 
* Added simple heated bed plate. Made the plate the full X-width (435mm), but extended the Y dimension to 400mm (from 340) to allow full range printing if we don;t end up implementing the toolchanger.
* Added a sheet metal bed frame with kinematic coupling to the bed. We'll need to evaluate the stiffness of this frame as part of the final Z axis analysis.



**Next steps with the model:**

- Need to move the Jubilee docked tools  ~ 25mm closer to the rear of the frame to maximize part Y-dimension. It is currently only 340mm.
- Need to move the Z-Axis rail forward to be closer to the heated bed.
- Make some decisions about a tool changer - do we have one, and if so, which one? I'm personally leaning towards having one, even if we only change tools by hand. It's a handy way to easily swap tools. 
- Add the build plate support and more detail to the build plate.

This will complete the "basic" design, then there are several things for us to look at before locking things in:

- Assessing a three-rail (and motor) Z-axis vs a single rail, cantilevered design. 
- After these are done, we can  add both the main enclosure and the top enclosure, electronics, etc..





**About the stuff in this directory (updated since 2020-01-07):**

This directory of the repo contains the "master" versions of the BARN Mark4 printer.  Ideally, you'll only find the series of model versions, this readme.md file, and a folder for images used in this readme. 

We are trying to accommodate Fusion360 users with Personal licenses, which means that we cannot have a shared project in Fusion360. As a result we are using the following process to create the assembly file here. You can create your own assembly file using this process or upload ours into your own Fusion 360 project.

Our Fusion 360 process (updated 1/7/2020):

1. The master assembly for the Mark 4 project is in one member's (Mike's at present) Fusion account.  This person is called the master librarian.

2. Parts in the project are added to the Mark4 master assembly.

3. The resulting assembly file is Exported and put into this directory.

4. Design collaboration is achieved my other users uploading the file to their Fusion 360 account and working on it there. When collaborative changes are to be added to the master we'll do one of the following:

     A. New parts - The collaborator provides a copy of their modified assembly (maybe/probably in github?). New parts will be copied (inlinked) from the collaborator design into the master, and the master updated.

     B. Edits of existing parts -  The master librarian will replicate the changes into the master mode, or replace the existing master model with the collaborators.

   Let's all agree that this is a far from perfect method for collaboration.  



A note from the master librarian (currently Mike) : I am building the assembly "outward" from the print head. This means starting with the Xrail and adding a print head on it. , then restricting the motion of this to our target 350mm (plus some space for an offset second extruder). This is then added to the Y rails and similarly motion restricted (adding space for a future tool changer). After this we can add the CoreXY belts, pullies, motors, etc. and also a frame subassembly.
