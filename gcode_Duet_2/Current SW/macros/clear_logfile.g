; Delete the contents of the logfile and restart
M929 S0                  ;stop logging
M30 "0:/sys/eventlog.txt"       ; Delete the log_file
M929 P"eventlog.txt" S1  ; Restart logging