#!/bin/bash
#
#   +-----------------------+
#   |  USE:                 |
#   |    - SMALL queue      |
#   |    - 1 CPU + def Gb   |
#   +-----------------------+
#
#  Replace the USER name in this script with your username and
#  call your project whatever you want
#
#  This script must be made executable like this
#    chmod +x my_script
#
#  Submit this script to the queue with a command like this
#    run_script my_script.sh
#
#  My preferred setup before running:
#    -- script to be run in /home/projectdir/scripts
#    -- project directory (of same name as script) in /home/
#    -- /input/ and /output/ subdirs within project dir


## --------------------------------
## ## Copy all ROHan summary files to ROHan output directory
cd /scratch/aubaxh002_08_rohan/

# cp ./_1_/*.summary.txt /home/aubaxh002/08_rohan/output/
# cp ./_2_/*.summary.txt /home/aubaxh002/08_rohan/output/
# cp ./_3_/*.summary.txt /home/aubaxh002/08_rohan/output/
# cp ./_4_/*.summary.txt /home/aubaxh002/08_rohan/output/
# cp ./_5_/*.summary.txt /home/aubaxh002/08_rohan/output/
# cp ./_6_/*.summary.txt /home/aubaxh002/08_rohan/output/
# cp ./_7_/*.summary.txt /home/aubaxh002/08_rohan/output/
# cp ./_8_/*.summary.txt /home/aubaxh002/08_rohan/output/
# cp ./_1_/*.gz /home/aubaxh002/08_rohan/output/
# cp ./_2_/*.gz /home/aubaxh002/08_rohan/output/
# cp ./_3_/*.gz /home/aubaxh002/08_rohan/output/
# cp ./_4_/*.gz /home/aubaxh002/08_rohan/output/
# cp ./_5_/*.gz /home/aubaxh002/08_rohan/output/
# cp ./_6_/*.gz /home/aubaxh002/08_rohan/output/
# cp ./_7_/*.gz /home/aubaxh002/08_rohan/output/
# cp ./_8_/*.gz /home/aubaxh002/08_rohan/output/
cp ./_1_/final*.bam /home/aubaxh002/08_rohan/input/
cp ./_2_/final*.bam /home/aubaxh002/08_rohan/input/
cp ./_3_/final*.bam /home/aubaxh002/08_rohan/input/
cp ./_4_/final*.bam /home/aubaxh002/08_rohan/input/
cp ./_5_/final*.bam /home/aubaxh002/08_rohan/input/
cp ./_6_/final*.bam /home/aubaxh002/08_rohan/input/
cp ./_7_/final*.bam /home/aubaxh002/08_rohan/input/
cp ./_8_/final*.bam /home/aubaxh002/08_rohan/input/


## cd into ROHan output directory
# cd /home/aubaxh002/08_rohan/output/
# 
# while read -a line
# 	do
# 	cat ${line[0]}.summary.txt | head -4 | tail -2 | \
# 	awk '{ print $4, $5, $6}' >> het_ests.txt
# 	echo "${line[0]}" >> het_ests.txt
# 	done < /home/aubaxh002/krat_roh_scripts_asc/sample_list.txt
