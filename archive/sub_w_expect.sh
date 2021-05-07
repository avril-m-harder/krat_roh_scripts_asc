send "run_script 01_read_qc_trimming.sh\n"
## select queue
expect "*"
send "medium\n"
## num processors
expect "*"
send "4\n"
## time limit (go with default)
expect "*"
send "\n" 
## memory limit (go with default, but format is ##gb)
expect "*"
send "\n"
## job name
expect "*"
send "01_read_qc_trimming_\n"
## cluster to use (go with default)
expect "*"
send "\n"
