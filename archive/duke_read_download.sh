#!/bin/bash
#
#  Replace the USER name in this script with your username and
#  call your project whatever you want
#
#  This script must be made executable like this
#    chmod +x my_script
#
#  Submit this script to the queue with a command like this
#    run_script_scratch my_script.sh
#
#  My preferred setup before running:
#    -- script to be run in /home/scripts
#    -- project directory (of same name as script) in /home/
#    -- /input/ and /output/ subdirs within project dir

## --------------------------------
## Run the good stuff 

cd /home/aubaxh002/reseq_data/

date

expect << 'EOS'
set timeout 216000
spawn sftp harder_6914@dnaseq2.igsp.duke.edu
expect "harder_6914@dnaseq2.igsp.duke.edu's password:"
send "7NX6N1Q3Hs6J\n"
expect "sftp>"
send "get -r Harder_6914_210423A7/\n"
expect "sftp>"
send "bye\n"
EOS

date

## --------------------------------

