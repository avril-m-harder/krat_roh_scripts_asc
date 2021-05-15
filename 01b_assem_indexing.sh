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
PROJ=assem_indexing

## Create a directory on /scratch
mkdir /scratch/${USER}_${PROJ}/

## Set permissions for directory
chmod 700 /scratch/${USER}_${PROJ}/

##  Copy input files to scratch
cp /home/aubaxh002/02_read_mapping/input/hifiasm_kangaroo_rat_6cells.p_ctg.fasta.gz /scratch/${USER}_${PROJ}/

## cd into working scratch directory
cd /scratch/${USER}_${PROJ}/


## --------------------------------
## Load modules
module load samtools/1.11
module load picard/1.79
module load bwa/0.7.12


## --------------------------------
## Unzip FASTA and create indexes needed for GATK Best Practices
# gunzip hifiasm_kangaroo_rat_6cells.p_ctg.fasta.gz

# bwa index hifiasm_kangaroo_rat_6cells.p_ctg.fasta

# samtools faidx hifiasm_kangaroo_rat_6cells.p_ctg.fasta

java -jar /opt/asn/apps/picard_1.79/picard_1.79/picard-tools-1.79/CreateSequenceDictionary.jar \
REFERENCE=hifiasm_kangaroo_rat_6cells.p_ctg.fasta \
OUTPUT=hifiasm_kangaroo_rat_6cells.p_ctg.dictionary.bam


## --------------------------------
