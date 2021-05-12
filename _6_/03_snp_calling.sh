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
PROJ=03_variantcalling

## Set batch group
GROUP=_6_

## Create a directory on /scratch
mkdir /scratch/${USER}_${PROJ}/_6_

## Set permissions for directory
chmod 700 /scratch/${USER}_${PROJ}/_6_

##  Copy input files to scratch
# cp /home/$USER/$PROJ/input/* /scratch/${USER}_${PROJ}/

## cd into working scratch directory
cd /scratch/${USER}_${PROJ}/_6_


## --------------------------------
## Load modules 

# module load samtools/1.11
# module load gatk/4.1.4.0
module load picard/1.79

## --------------------------------
## Mark duplicate reads
while read -a line
	do
	java -jar /opt/asn/apps/picard_1.79/picard_1.79/picard-tools-1.79/MarkDuplicates.jar \
	I=/scratch/aubaxh002_02_read_mapping/_6_/${line[0]}_small_genome_sorted.bam \
	O=${line[0]}_small_genome_dupmarked.bam \
	M=${line[0]}_markdup_metrics.txt \
	MAX_RECORDS_IN_RAM=250000
	done < /home/aubaxh002/sample_lists/_6_.txt


## --------------------------------

## Copy results back to project output directory (in home)
# cp hifiasm_kangaroo_rat_6cells_no_purge.p_ctg.fasta.fai /home/$USER/$PROJ/output/
