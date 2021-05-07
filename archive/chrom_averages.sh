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

##  Set username
USER=aubaxh002

## Set project name
PROJ=02_read_mapping

## cd into working scratch directory
cd /scratch/${USER}_${PROJ}/


## --------------------------------
## Use awk to summarize coverage by chromosome (average coverage per) 

# awk '{sum3[$1] += $3; count3[$1]++}; END{ for (id in sum3) { print id, sum3[id]/count3[id] > "4922_S58_small_genome_covg_by_chrom.txt" } }' < 4922_S58_small_genome_covg.txt
# awk '{sum3[$1] += $3; count3[$1]++}; END{ for (id in sum3) { print id, sum3[id]/count3[id] > "4922_S58_large_genome_covg_by_chrom.txt" } }' < 4922_S58_large_genome_covg.txt
# awk '{sum3[$1] += $3; count3[$1]++}; END{ for (id in sum3) { print id, sum3[id]/count3[id] > "4927_S59_small_genome_covg_by_chrom.txt" } }' < 4927_S59_small_genome_covg.txt
awk '{sum3[$1] += $3; count3[$1]++}; END{ for (id in sum3) { print id, sum3[id]/count3[id] > "4927_S59_large_genome_covg_by_chrom.txt" } }' < 4927_S59_large_genome_covg.txt

## --------------------------------

## Copy results back to project output directory (in home)
# cp 4922_S58_small_genome_covg_by_chrom.txt /home/$USER/$PROJ/output/
# cp 4922_S58_large_genome_covg_by_chrom.txt /home/$USER/$PROJ/output/
# cp 4927_S59_small_genome_covg_by_chrom.txt /home/$USER/$PROJ/output/
cp 4927_S59_large_genome_covg_by_chrom.txt /home/$USER/$PROJ/output/