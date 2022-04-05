; File for loading PLA filament

var hotend_unload_temperature = 215

M98 P"0:/sys/filament_load.g" T{var.hotend_unload_temperature}

