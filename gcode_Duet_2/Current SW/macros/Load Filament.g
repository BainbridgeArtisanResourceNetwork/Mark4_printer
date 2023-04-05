; macro for guiding the user through selecting a filament.

M291 S3  P"Load a new filament? OK to proceed, or Cancel"


M98 p"0:/macros/tools/OK_Cancel_checker.g" S"Load PLA? OK to proceed, Cancel to move to next filament type."
if global.OK_CANCEL = "OK"
  M701 S"PLA" ; runs the load.g file in the  PLA filament folder, also sets the name of the current filament.
  M703        ; runs the config.g file in the PLA filament folder
  

else
  M98 p"0:/macros/tools/OK_Cancel_checker.g" S"Load PETG? OK to proceed, Cancel to move to next filament type."
  if global.OK_CANCEL = "OK"
    M701 S"PETG" ; runs the load.g file in the  PETG filament folder, also sets the name of the current filament.
    M703        ; runs the config.g file in the PETG filament folder
    

  else
    M98 p"0:/macros/tools/OK_Cancel_checker.g" S"Load TPU? OK to proceed, Cancel to move to next filament type."
    if global.OK_CANCEL = "OK"
      M701 S"TPU" ; runs the load.g file in the  TPU filament folder, also sets the name of the current filament.
      M703        ; runs the config.g file in the TPU filament folder
     

    else
      M291 S1 T20 P"No more filament choices. Canceling filament load." 