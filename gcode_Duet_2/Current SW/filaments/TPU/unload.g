; File for launching the unloading of filament from extruder 0
              echo "filaments/PLA/load.g:  starting filaments/PLA/load.g"
              echo "filaments/PLA/load.g:  calling sys/filament_load.g"
			  
M98 P"0:/sys/extruder_0_unload_filament.g" T225    ; Call the unload macro with a hot-end temperature of 225C

M703                               ; causes the config.g in the current filament folder to be run
