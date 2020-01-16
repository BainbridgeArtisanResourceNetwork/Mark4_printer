### The Mark4 Fusion 360 model

**2020-01-17 Current state of the model**

New Assembly  (file : 2020_01_16_Mark4 Assembly- three legs v26.f3d)
![Assembly, Mark4 printer v23](https://github.com/BainbridgeArtisanResourceNetwork/Mark4_printer/blob/master/Fusion360_model_NEW/images/New_assembly_2020_01_16.jpg)

 Lots of Changes from Last version (Mark4 Assembly v38.f3d):

* COLORS! I made a lot of parts different colors so that they will stand out more clearly, as you'll see in the image above.
* Deleted the two rear corner posts in the frame and instead have a single post in the center -rear. This gives the top plate a 3-point support which will make it much more difficult for the frame to flex the top plate. 
* Made adjustments to many parts to support the Jubilee tool carriage design. The major ones are:
  * The X guide rail is now mounted to the bottom of the bridge, not the top. This is where the Jubilee folks put theirs and we need to match is we don't want to redesign the tool-carriage.
  * The red belt (called BeltA in the fusion file) has been moved above the bridge. This matches the Jubilee position, but also has a benefit of allowing the two Y-Rails to be moved closer together, making the span of the bridge shorter - good for minimizing flex. The span is now ~571mm.
  * The pulleys on the bridge were moved so the belts are on top of each other, to match the Jubilee design. It also eliminates twisting toques when the motors pull the carriage.
* We'll likely approach the Jubilee tool changer isn two steps. Step 1 is to use the carriage on the bridge, then manually attach or remove tools using the E3D/Jubilee kinematic coupling. At this stage, multiple prints would need to be made with a dual-extruder tool, which eats up some X-axis part capacity.  The advantage is that without the need for parking space for tools, the Y-axis part capacity grows. Step 2 would be adding the automation for changing tools. Then we could to go with multiple single extruder tools. We'll make the maximum size heated bed so we will have options.
* I've added a design for motors, guide rails, and lead screws for the two front corners of the build-plate. The single rear ball screw and cantilevered bed support is still in the model but not shown. You can easily turn it on.  The build plate kinematic mount points are not changed from the cantilevered version. This is not a committed change, but something may of us want to understand better.  Switching from the ball-screw assembly for the Z axis also gives us 50mm more z-size for our parts. 
* Added a sample thermal enclosure. I made it out of cherry wood in the model, but we'll use something more sensible when we build it. This enclosure would be fastened to the baseplate and the insides of the vertical frame posts, and come up to "just below" the top plate.  We'll avoid fastening to the bottom of the top-plate so that we don't accidentally add bending stresses to it. The z-motors all stay outside the heated enclosure, with some nifty vertical blades runninng through slots in the enclosure walls.  I didn't put doors on the front yet, but they should be easy to do in a future model.  A top enclosure is also not yet in the model, but I've left space for a 2020 extrusion outboard of the belts, and at the front. In the rear, we should be able to make the back of the top enclosure so that the X and Y motors are outside. 

With these changes, our build volume is UP - to 450mm X (400mm if we use a dual-extruder),  360mm Y (~435mm if we don't park tools) , and 440mm Z (~390mm with the ball-screw currently in the design).  And the overall size of this beast is  676mm (30.2") wide,  688mm (27") deep, and 644mm (25.35) tall. 



**Next steps with the model:**

- Do a costing analysis of these new ideas, to see where we stand relative to the budget.
- Need to add a rear  Z-Axis NEMA motor and mount. 
- Make some decisions about the tool changer - do we have one, and if so, which one? I'm personally leaning towards having one, even if we only change tools by hand. It's a handy way to easily swap tools.





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
