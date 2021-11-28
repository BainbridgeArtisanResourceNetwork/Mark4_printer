; Delete the contents of the logfile and restart
M929 S0                  ;stop logging
M30 "0:/sys/log_file.txt"       ; Delete the log_file
M929 P"log_file.txt" S1  ; Restart logging