; File for loading PLA filament

var hotend_load_temperature = 225

M98 P"0:/sys/filament_load.g" T{var.hotend_load_temperature}