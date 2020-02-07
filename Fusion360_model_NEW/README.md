### The Mark4 Fusion 360 model

**2020-01-30 Current state of the model**

New Assembly  (file: Mark4 Assembly v121.f3d)
![Assembly, Mark4 printer v23](https://github.com/BainbridgeArtisanResourceNetwork/Mark4_printer/blob/master/Fusion360_model_NEW/images/New_Assembly_2020_02_07.jpg)

 Changes from last version (Mark4 Assembly v90.f3d):

- Added materials to all of the fabricated parts, and used proper coloring. Exception is that the bottom enclosure is still shown as wood.
- Switched the X-Axis block back to MGN12C from 12H. Last model moved to be compatible with Jubilee tool changer parts, but on further exam of them, we can easily change to accommodate the 12H block. This also means an easier sourcing process for the rail (I was not able to find a rail with a 12C block in my quick amazon search.)
- Shortened bottom plate at front to be close to the vertical posts.
- Top plate:
  - Radiused corners
  - Switched post holes from M12 to M8 to accommodate heli-coil inserts in the leg extrusions
  - Switched leg fasteners from flathead screws to cap screws. Eliminates need to countersink the holes, and will reduce friction during fastening. Also allows some small amount of adjustment during assembly.
- Heated bed
  - Switched to 3/8" thick material (from 1/4) to reflect our plan to cut this from the "donut hole" left when we cut the top plate. We are giving up 3mm of Z part size and will need slightly longer to heat the bed.
  - Added pocket holes in the bottom to accommodate magnets.

- Added CNC tools for both the wood CNC and the metal CNC. Also started a manufacturing tool path for the top plate.  There is also a new component called "Manufacturing" where component that need to be recreated for manufacturing are being kept. Currently, there is a top plate in there which I created to make it easier to do the milling setup due to the need for a two-step milling process. Our plate is bigger than the metal studio CNC mill can complete in one operation.






**Next steps with the model:**

- Complete tool paths for the wood-CNC version of the top plate and heated bed.
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
