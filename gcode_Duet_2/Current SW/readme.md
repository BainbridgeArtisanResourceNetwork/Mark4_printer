# BARN Mark4 Printer SW

This folder contains the latest "released" software for the BARN Mark 4 printer.  By "software", we mean the gcode files we've created/evolved from other sources, and the web software provided with the Duet2 controller board. We have not made any changes to the web software, so this means that for us, "software" means the gcode files.



gcode files are used for all interfacing to the Duet2 firmware in the BARN printer. It's used for parts that are being printed, but also for initializing the Duet2 hardware with the specific parameters of our machine, the methods for homing at startup, the methods for changing filaments, and the instructions for changing tools.  A couple of gcode references we used a **lot** are the [Duet3d wiki](https://duet3d.dozuki.com/Wiki/Gcode?revisionid=HEAD) and [RepRap gcode wiki](https://reprap.org/wiki/G-code)



This directory organization and the file names within are mostly as provided by Duet3d (the company that makes the Duet2 controller board). We will strive to put lots of comments into the files as we modify  and/or create them, so reading the files is a way to learn what we are doing. We are also using a short phython script to extract certain comments from the gcode files into MD files as a way to provide the new reader an overview of what the gcode in the file is doing.  So, for every .gcode file, there is a companion .md file.



## Use of this sw

To put this software on the BARN printer, the whole contents of the directory and all it's sub-directories are copied onto a microSD card and the card inserted into the SD slot on the Duet2 controller board on the printer. At power up, the controller looks on the SD, finds the files it needs, and gets going.



## Directories

The following directories are part of the  software. Their use is briefly described here. Additional info can be found on the Duet2 wiki [HERE](https://duet3d.dozuki.com/Wiki/Firmware_Overview).  Each of these directories should contain a readme.md that describes it's files and their use.


### filaments

This file has folders for different filament types and those directories have gcode that is executed when a filament load or unload command is given. They have stuff like heating the nozzle before extracting the filament, running the extruder in reverse to pull the filament out of the nozzle, etc.  This folder does not appear to have been created by Duet2, but is inherited from Jubilee (a theory). We'll need to dig into it's use.

### gcodes

Folder **/gcodes** is used to hold g-code files for  printing. You can use subfolders of /gcodes to organize these files.  G-code files can also be located on an external SD card if one is  connected.  Files in this directory can be executed from the Duet2 web interface or touchscreen,

### macros

Folder **/macros** is used to hold used-defined macro  files. "Macros" are really just gcode files that are usually called macros if they are used by another gcode file.  The names of these files appear as menu entries in DuetWebControl and on PanelDue.  You can use subfolders of /macros to organize these  files.  Macros created by BARN members are named starting with "BARN_". Files in this directory can be executed from the Duet2 web interface or touchscreen.

### sys

This directory contains the gcode files used for initializing the Duet2 board. It's the place to start if you're looking for something. 

### www

This directory contains some html, css, and other files that the Duet 2 uses for things we don't yet understand. Maybe it's the web interface for the Duet2, or maybe something else. The Duet controller apparently also copies the contents of the filaments, gcodes, macros, and sys folders  into this directory.







