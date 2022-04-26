; Generic macro for loading filament from a directly connected Mosquito hot end.
; Required input parameters
; T - the temperature (in C) the extruder must reach before the filament can be unloaded.

;Checks

if !exists(param.T)  ; see if a parameter "T" was provided with the macro
  M291 P"Must provide extruder temperature parameter - T" R"Loading Filament"  S1  T10
  M99

if {state.currentTool < 0}  
  M291 P"No tool selected, must select a tool first" R"Loading Filament"  S1  T10
  M99

; OK, we have a temperature target and a tool selected, let's get going.


;Prep for loading
M568  S{param.T}  ;set hotend temperature
M291 P"Heating.... Another message will appear when it's time to insert the filament.  " R"Loading Filament"  S1 T0 
M116 P{state.currentTool} S2	;wait for hot end (P) to heat up to within 2 degrees (S2) of the load temperature.


;Load
M291 P"Insert new filament into extruder and press OK, Press CANCEL to abort the load filament process." R"Load Filamane"  S3  T-1

;grab and move the filament
M83  ;set extruder to relative mode
G1 E70 F{10*60}         ;move the filament quickly to the hot break
G1 E24 F{5*60}          ;move slowler to get the filament to the nozzle
G1 E10 F{5*60}          ;squirt some out
G4 S0

; ask if it was successful
while true
  M291 P"If new filament is not coming out, press OK to squirt more. Press Cancel to finish the loading process." R"Load Filament"  S3  T-1
  G1 E10 F{5*60}          ;squirt some out
  G4 S0


