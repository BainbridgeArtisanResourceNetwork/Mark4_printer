; File for unloading a loaded filament

if state.currentTool != -1    ; means there is a tooll selected at present
  M291 P{"Current Tool Number: "^state.currentTool^"      Current filament: "^move.extruders[state.currentTool].filament} S1  T10
  m98 P{"0:/filaments/"^{move.extruders[state.currentTool].filament}^"/preheat.g"}

else 
  M291 P"No tool selected. Select tool first." S1 T0
 