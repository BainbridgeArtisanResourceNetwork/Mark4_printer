; File for unloading TPU filament

var hotend_unload_temperature = 240

M98 P"0:/sys/filament_unload.g" T{var.hotend_unload_temperature}