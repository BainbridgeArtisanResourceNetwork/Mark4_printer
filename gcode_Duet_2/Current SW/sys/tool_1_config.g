;TOOL 1 ********************************************
			;!### Tool 1 - Printhead 1
				;!This secion defines the parts of the tool (Extruders, fans, heaters, temperature sensors, etc) before declaring their collection a tool.
					
				;!#### Extruder 1
     			;!Extruder drive (marked as "E1stp" on the Duet 2 board)	assigned in COMMON SOMMANDS section.
M569 P4 S1 D2   ;!Set the direction of the driver4 stepper and define it as spread cycle (Need to look at this to see if our 
				;!motor is the type that can handle this. 
				;!https://duet3d.dozuki.com/Wiki/Gcode?revisionid=HEAD#Section_M569_Set_motor_driver_direction_enable_polarity_and_step_pulse_timing
	
		

				
				;!#### Filament Heater (H2)
m308 S2 P"e1temp" Y"thermistor" T100000 B3950  A"Tool1 Hot end Temp"		;!Create a sensor(S) with ID 2, that uses a thermistor (Y) that is 100K ohms at at 25C(T)
																					;!and coefficient of 3950 (B)
M950 H2 C"e1heat" T2    ;!Define a Heater (H) with ID 2, map output to pin (C) named "e1heat", and associate with the temperature sensor we earlier named "S2"	     
						;!Heater  H2 defined in the heater definition section before tool definitions.
;M307 H2 R3.005 K0.423:0.000 D9.36 E1.35 S0.50 B0 V24.2  ;!Set the heater control parameters. These were found using the M303 command.
M307 H2 R2.883 K0.466:0.000 D9.41 E1.35 S0.50 B0 V24.1  ;!Set the heater control parameters. These were found using the M303 command for tool 1 on 8/30/22.
M570 H2 S30     		;! Print will be terminated if a heater fault is not reset within 30 minutes.
M143 H2 S260    		;! Set Maximum H2 (Extruder) heater temperature


				;!#### Fans
				;! Set up the extruder fan and the part cooling fan.
M950 F3 C"duex.fan3" 	;! Define that Fan 3 is connected to pin named "duex.fan3". This is the hot end fan.
M106 P3 T45 S1.0 H2	;! Turn on Fan 3 (P3 - the Hot End fan) to 100% (S1.0) when the heater H2 gets above 45 degs.  This command migght belong in the tpre0.g file so it gets initialted when the tool is selected.
M950 F4 C"duex.fan4"		;! Define that Fan 4 is connected to pin named "duex.fan4". this is the part cooling fan.
M106 P4 T45 S1.0 H2	;! Turn on Fan 2 (P4 - the part cooling fan) to 100% (S1.0) when the heater H2 gets above 45 degs.  This command might belong in the tpre0.g file so it gets initialted when the tool is selected.

				;!#### Define the tool
				;!Now that all the pieces are defined, pull them together into a tool.	
M563 P1 S"Extruder 1" D1 H2 F3:4   ;! Define tool #1 (P1) with name "Extruder 1", using motor driver 3 (D1) (second drive defined after the axes), and Fans 3 and 4
;M568 P1 R180 S210 A0 	;! Set tool 1 standby temp to 180, active temperature to 210, but turn the heater off (A0)


				;!#### Extruder offsets
				;!These offsets are used to create a translation so the nozzle will go to the correct X,Y,Z location 
   ;! Set tool 1 offset from machine coordinates. These values are subtracted from machine coordinates to get tool coordinate to move to.
G10 P1 X0 Y0 ;Z3.25   ; Increasing the offset moves the nozzle closer to the bed.   changed 4/12- was 2.75
m98 P"0:/sys/tool1_Z_offset.g"                   ; call the file that sets the Z offset for tool0  More negative numbers lower the bed (increases the spacing)



;TOOL 1 -  ******************************************



