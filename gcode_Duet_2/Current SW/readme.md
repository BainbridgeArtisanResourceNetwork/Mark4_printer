# BARN Mark4 Printer SW

This folder contains the latest "released" software for the BARN Mark 4 printer.  By "software", we mean the gcode files we've created/evolved from other sources, and the web software provided with the Duet2 controller board. We have not made any changes to the web software, so this means that for us, "software" means the gcode files.



gcode files are used for all interfacing to the Duet2 firmware in the BARN printer. It's used for parts that are being printed, but also for initializing the Duet2 hardware with the specific parameters of our machine, the methods for homing at startup, the methods for changing filaments, and the instructions for changing tools.  A couple of gcode references we used a **lot** are the [Duet3d wiki](https://duet3d.dozuki.com/Wiki/Gcode?revisionid=HEAD) and [RepRap gcode wiki](https://reprap.org/wiki/G-code)



This directory organization and the file names within are mostly as provided by Duet3d (the company that makes the Duet2 controller board). We will strive to put lots of comments into the files as we modify  and/or create them, so reading the files is a way to learn what we are doing. We are also using a short phython script to extract certain comments from the gcode files into MD files as a way to provide the new reader an overview of what the gcode in the file is doing.  So, for every .gcode file, there is a companion .md file.



## Use of this sw

To put this software on the BARN printer, the whole contents of the directory and all it's sub-directories are copied onto a microSD card and the card inserted into the SD slot on the Duet2 controller board on the printer. At power up, the controller looks on teh SD, finds the files it needs, and gets going.



## Directories

The following directories are part of the  software. Their use is briefly described here. Each of these directories should contain a readme.md that describes it's files and their use.



### BARN_gcode_macros

This is a folder we created for storing gcode macros that we write at BARN. We don't have much here yet, but it should grow over time. There is also a python script we use for creating md files from the gcode files. 

### filaments

This file has folders for different filament types and those directories have gcode that is executed when a filament load or unload command is given. They have stuff like heating the nozzle before extracting the filament, running the extruder in reverse to pull the filament out of the nozzle, etc. 

### gcodes

This is a location where the gcode files for creating parts are stored. We are not sure if this is a place where the Duet2 controller fw puts files downloaded to it, or if it was created by the Jubilee team (where we got the corde we started with)

### macros

This is the default location for macros. "Macros" are really just gcode files that are called by another gcode file.  When a gcode files calls a macro (using the M98 command), this is a place the Duet2 controller will look for it if an exact path is not provided. 

### sys

This directory contains the gcode files used for initializing the Duet2 board. It's the place to start if you're looking for something. 

### www

This directory contains some html, css, and other files that the Duet 2 uses for things we don't yet understand. Maybe it's the web interface for the Duet2, or maybe something else. The Duet controller apparently also copies the contents of the filaments, gcodes, macros, and sys folders  into this directory.







