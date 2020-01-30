### The Mark4 Fusion 360 model

**2020-01-30 Current state of the model**

New Assembly  (file: Mark4 Assembly v90.f3d)
![Assembly, Mark4 printer v23](https://github.com/BainbridgeArtisanResourceNetwork/Mark4_printer/blob/master/Fusion360_model_NEW/images/New_assembly_2020_01_30.jpg)

 Lots of Changes from last version (Mark4 Assembly v38.f3d):

- Changed parameter (length) for X rail to 400mm (from 500), to reflect team decision to drive to 350mm part (the 500mm rail was delivering a 450mm max part X dimension.). This change rippled small changes thought lots of parts.
- Changed X-Rail from MGN12H to MGN12C (changes block size from large to small) to match the Jubilee tool carriage hole pattern. 
- Rebuilt the Z-axis components to integrate them into the Frame (when these will be assembled), rather than where they were (hanging on the end of the timeline).
  -   Completely redesigned the brackets that span from the side Z-axis guide rail blocks, to the bottom of the heated bed kinematic supports. Minimized the "blade length" where the brackets that cut through the enclosure sides. Now only 15mm has no flange for rigidity.
  - Angled the bottom edge of the blades to eliminate a pinch point between the bottom of the blade and the enclosure bottom. 
  - Designed a better kinematic ball support at the rear post with a shorter cantilevered reach. 
- Top plate
  -   Added an enclosing bar across the front of the top plate. This is now a "ring" instead of a "U". The idea is to make the top plate stiffer overall.
  - Moved pulley "B" closer to front of plate to give more wrap around drive pulley (Pulley "C") and give more space for a belt tensioner. Moved pulley D slightly closer to rear of plate.
  - Added a belt tensioning feature between Pulley B and C. This is an additional idler pulley mounted on a pivoting bar and a fixed block mounted to the top plate. A screw through the fixed block pushes on the pivoting bar, driving it into the belt to increase tension. We may want to tweak the way the arm pivots, but this is good for now.   This is shown in the insert at the top of this readme, the parts are a mustard yellow.
  - Added optional gusset plates in both X and Y directions on all three posts. Some of these currently interfere with the top edge of the bottom enclosure. If we decide to add these gussets, we'll need to add slots to the bottom enclosure for them.
  - Added holes at rear corners for additional corner posts in case we decide we need them.
- Bottom enclosure
  - Still a placeholder component, but moved the slots to line up with the Z-axis sliders that pass through them.
- Built a first-pass top enclosure using 2020 aluminum. This part hinges at the rear in the current model, but no hinge mechanism has been designed yet. I expect this is something we'll prototype by hand once the wood model is built.



With these changes, our build volume is

-  X - 365mm  
- Y  - 365mm (with tool changer), 440mm without the tool changer.
- Z  - 440mm  



**Next steps with the model:**

- Design review and change list for the wood model.
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
