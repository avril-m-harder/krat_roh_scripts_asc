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
#
## --------------------------------
## Copy trimmed read files back to /home/

cd /scratch/aubaxh002_01_read_qc_trimming/_5_/ 
gzip trimmed*.fastq
cp trimmed*.fastq.gz /home/aubaxh002/01_read_qc_trimming/output/trimmed_read_files/

cd /scratch/aubaxh002_01_read_qc_trimming/_6_/ 
gzip trimmed*.fastq
cp trimmed*.fastq.gz /home/aubaxh002/01_read_qc_trimming/output/trimmed_read_files/
