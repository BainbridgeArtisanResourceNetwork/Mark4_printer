; File for unloading a loaded filament

if state.currentTool != -1
  M291 P{"Current Tool Number: "^state.currentTool^"      Current filament: "^move.extruders[state.currentTool].filament} S1  T10

M702 ; calls the unload.g file for the filament in the current tool 