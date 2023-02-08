; This daemon.g file is a test of this function.
; It should run once every 10 seconds once the printer is up and running. 
;M118 S"daemon.g is starting without  M99" L1   ;WIll insert something into the log


if exists(global.daemon_network_check)             ; needed in case the daemon runs before config.g finishes and creates the variable.
  if global.daemon_network_check <=2              ;three tries will give the network 30 seconds to connect. I might reduce this after testing.
    if network.interfaces[0].state = "active"     ; the network is connected
      set global.daemon_network_check = 99            ; set the variable value higher than the stop trying limit so it wont keep checking
    else
      if global.daemon_network_check = 2          ;  no network after three tries, let's shut off networking
        M552 S0                                   ; disable networking
        M118 S"daemon.g stopped the network because it was not connecting" L1   ; put a comment in the log
        M291 P"Wireless has not connected after 20 seconds, cancelling network ops" S1 T10
      set global.daemon_network_check = global.daemon_network_check+1



