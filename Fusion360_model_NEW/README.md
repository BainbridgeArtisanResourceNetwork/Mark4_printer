### The Mark4 Fusion 360 model

**2020-01-30 Current state of the model**

New Assembly  (file: Mark4 Assembly v231.f3d)
![Assembly, Mark4 printer v231](https://github.com/BainbridgeArtisanResourceNetwork/Mark4_printer/blob/master/Fusion360_model_NEW/images/New_Assembly_2020_08_08.jpg)

 Changes from last version (Mark4 Assembly v134.f3d):

- Moved pulleys on bridge by 0.2mm to align with Jubilee carriage backplate V 05. Part of github issue #24.
- Changed X-Rail block to MGN12C from MGN 12H. 
- Replaced older versions of Jubilee carriage parts with latest versions.
- Implemented changes to some bugs reported in github
  - #21 - changed heated bed dimensions to match 350mm x350mm goal of project.
  - #20 - X-axis motor mount screw holes too big.
  - #18 - Mounting holes for kinematic bed attach do not line up with posts on the supports
- Removed prototype belt tensioners that didn't work in the wood proto.
- Added electronics and proto board for supporting same.




**Next steps with the model:**

- Detail the bottom and top enclosures.
- Add details driven by the electronics (locations for the Power supply, boards, user interface, limit switch mounting, etc.)
- Tweak the Jubilee tool changer dock so it mounts to our printer.
- Play with the cable/filament  bundles to see how they should impact the design of the top cover.



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
