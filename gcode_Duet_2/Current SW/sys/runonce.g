; run-once.g
;!<summary> called after config.g. When it has been executed, it is automatically deleted! Not really sure what the point of the steps in this file are.</summary>
;
; generated by RepRapFirmware Configuration Tool v3.1.4 on Wed Sep 30 2020 12:24:04 GMT-0700 (Pacific Daylight Time)
M552 S0                                ; disable network
G4 P500                                ; wait half a second
M552 S1                                ; enable network
G4 P1000                               ; wait a second
M587 S"Barn_Secure_Guest" P"Community" ; configure WiFi
M552 S1                                ; enable network

