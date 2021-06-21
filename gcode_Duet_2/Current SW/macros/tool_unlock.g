;!<summary> Disengage the toolchanger lock.  This macro performs the steps needed to twist the tool changer latch to the unlocked position.</summary>

G91                 ; Set relative movements
G1 U-4 F9000 S2     ; Back off the limit switch with a small move
G1 U-360 F9000 S1   ; Perform up to one rotation looking for the home limit switch
G90                 ; Restore absolute movements
