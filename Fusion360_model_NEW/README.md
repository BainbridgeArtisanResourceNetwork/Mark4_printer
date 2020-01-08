### The Mark4 Fusion 360 model

**2020-01-07 Current state of the model**

New Assembly V24:
![Assembly, Mark4 printer v23](https://github.com/BainbridgeArtisanResourceNetwork/Mark4_printer/blob/master/Fusion360_model_NEW/images/New_Assembly_V24.jpg)

Another major update of the model structure, without much change to the model itself. In this iteration of design improvement, there are no linked subassemblies, and time has been taken to clean up the timeline so the modeling process isn't "jumbled".  Thanks to Clayton for all his feedback on the lack of usability of the old model.  



**Next steps with the model:**

- Put the part volume back into the model. 
- Make some decisions about a tool changer - do we have one, and if so, which one? I'm personally leaning towards having one, even if we only change tools by hand. It's a handy way to easily swap tools. 
- Add the build plate support and build plate.

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
