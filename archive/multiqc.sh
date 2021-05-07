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
## Load modules 
ml anaconda/3-2019.10

# cd /scratch/aubaxh002_01_read_qc_trimming/_1_/
# multiqc -o /scratch/aubaxh002_01_read_qc_trimming/multiqc_output .
# 
# cd /scratch/aubaxh002_01_read_qc_trimming/_2_/
# multiqc -o /scratch/aubaxh002_01_read_qc_trimming/multiqc_output .
# 
# cd /scratch/aubaxh002_01_read_qc_trimming/_3_/
# multiqc -o /scratch/aubaxh002_01_read_qc_trimming/multiqc_output .
# 
# cd /scratch/aubaxh002_01_read_qc_trimming/_4_/
# multiqc -o /scratch/aubaxh002_01_read_qc_trimming/multiqc_output .
# 
# cd /scratch/aubaxh002_01_read_qc_trimming/_5_/
# multiqc -o /scratch/aubaxh002_01_read_qc_trimming/multiqc_output .
# 
# cd /scratch/aubaxh002_01_read_qc_trimming/_6_/
# multiqc -o /scratch/aubaxh002_01_read_qc_trimming/multiqc_output .
# 
# cd /scratch/aubaxh002_01_read_qc_trimming/_7_/
# multiqc -o /scratch/aubaxh002_01_read_qc_trimming/multiqc_output .
# 
# cd /scratch/aubaxh002_01_read_qc_trimming/_8_/
# multiqc -o /scratch/aubaxh002_01_read_qc_trimming/multiqc_output .

# cd /home/aubaxh002/01_read_qc_trimming/output/raw/
# multiqc .

cd /home/aubaxh002/01_read_qc_trimming/output/trimmed_paired/
multiqc .

cd /home/aubaxh002/01_read_qc_trimming/output/trimmed_unpaired
multiqc .