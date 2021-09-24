#!/bin/bash
#
#   +------------------------+
#   |  USE:                  |
#   |    - SMALL queue       |
#   |    - 10 CPU + def Gb   |
#   +------------------------+
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

##  Set username
USER=aubaxh002

## Set project name
PROJ=08_rohan

## Create a directory on /scratch
mkdir /scratch/${USER}_${PROJ}/_1_

## Set permissions for directory
chmod 700 /scratch/${USER}_${PROJ}/_1_

##  Copy input files to scratch
# cp /home/$USER/$PROJ/input/* /scratch/${USER}_${PROJ}/

## cd into working scratch directory
cd /scratch/${USER}_${PROJ}/_1_


## --------------------------------
## Load modules
module load rohan
module load samtools


## --------------------------------
## First, sort, mark duplicates, and index BAM files
gunzip -c /scratch/aubaxh002_02_read_mapping/_1_/hifiasm_kangaroo_rat_6cells.p_ctg.fasta.gz > \
/scratch/aubaxh002_02_read_mapping/_1_/hifiasm_kangaroo_rat_6cells.p_ctg.fasta

samtools faidx /scratch/aubaxh002_02_read_mapping/_1_/hifiasm_kangaroo_rat_6cells.p_ctg.fasta

while read -a line
	do
	samtools sort -n -@ 9 \
	-o querysorted_${line[0]}_small_genome_rgroups.bam \
	/scratch/aubaxh002_02_read_mapping/_1_/sorted_${line[0]}_small_genome_rgroups.bam 
	
	samtools fixmate -r -m -O BAM -@ 9 \
	--reference /scratch/aubaxh002_02_read_mapping/_1_/hifiasm_kangaroo_rat_6cells.p_ctg.fasta.gz \
	querysorted_${line[0]}_small_genome_rgroups.bam \
	fixmate_sorted_${line[0]}_small_genome_rgroups.bam
	
	samtools sort -@ 9 \
	-o sort_fixmate_sorted_${line[0]}_small_genome_rgroups.bam \
	fixmate_sorted_${line[0]}_small_genome_rgroups.bam
	
	samtools markdup -r -O BAM -@ 9 \
	--reference /scratch/aubaxh002_02_read_mapping/_1_/hifiasm_kangaroo_rat_6cells.p_ctg.fasta.gz \
	sort_fixmate_sorted_${line[0]}_small_genome_rgroups.bam \
	final_ROHan_${line[0]}.bam
	
	samtools index final_ROHan_${line[0]}.bam
	
	done < /home/aubaxh002/sample_lists/_1_.txt

	
## --------------------------------
## Run ROHan on samples to estimate ROH and theta
# while read -a line
# 	do
# 	rohan --rohmu 2e-5 -o ${line[0]} -t 10 --tstv 1.9 \
# 	/scratch/aubaxh002_02_read_mapping/_1_/hifiasm_kangaroo_rat_6cells.p_ctg.fasta \
# 	final_ROHan_${line[0]}.bam
# 	done < /home/aubaxh002/sample_lists/_1_.txt


## --------------------------------
## Copy results back to project output directory (in home)
# cp allsamps_* /home/$USER/$PROJ/output/

mail -s 'ROHan _1_ finished' avrilharder@gmail.com <<< 'ROHan _1_ finished'