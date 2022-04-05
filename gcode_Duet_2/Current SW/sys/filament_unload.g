; Generic macro for unloading filament from a directly conencted Mosquito hot end.
; Required input parameters
; T - the temperature (in C) the extruder must reach before the filament can be unloaded.

;Checks

if !exists(param.T)  ; see if a parameter "T" was provided with the macro
  M291 P"Must provide extruder temperature parameter - T" R"Unloading Filament"  S1  T10
  M99

if {state.currentTool < 0}  
  M291 P"No tool selected, must select a tool first" R"Unloading Filament"  S1  T10
  M99

; OK, we have a temperature target and a tool selected, let's get going.


;Prep for removal
M568  S{param.T}  ;set hotend temperature
M291 P"Heating... " R"Unloading Filament"  S0 
M116 P{state.currentTool} S2	;wait for hot end (P) to heat up to within 2 degrees (S2) of the load temperature.
M291 P"Heating complete. Get ready to pull out filament and press OK." R"Unloading Filament"  S3  T-1



;Move the filament
M83  ;set extruder to relative mode
G1 E-25 F{10*60}                       ; retract the filament from hot break chamber
G1 E-90 F{25*60}                       ;move the filament quickly out of the extruder
G4 S0

M291 P"Remove Filament." R"Unloading Filament"  S2  T10

M99
