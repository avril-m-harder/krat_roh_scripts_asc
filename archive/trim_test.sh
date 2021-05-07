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

## cd into working scratch directory
cd /scratch/aubaxh002_01_read_qc_trimming/

## --------------------------------
## Run the good stuff 

module load trimmomatic/0.38
module load fastqc/0.10.1

cd /scratch/aubaxh002_01_read_qc_trimming/_5_/

trimmomatic PE -phred33 -threads 10	\
545_S21_L003_R1_001.fastq \
545_S21_L003_R2_001.fastq \
trimmed_paired_545_S21_L003_R1_001.fastq \
trimmed_unpaired_545_S21_L003_R1_001.fastq \
trimmed_paired_545_S21_L003_R2_001.fastq \
trimmed_unpaired_545_S21_L003_R2_001.fastq \
LEADING:20 TRAILING:20 MINLEN:30 \
ILLUMINACLIP:/home/aubaxh002/scripts/illumina_truseq_adapter.fa:2:40:10

fastqc -t 4 -o output/ \
trimmed_paired_545_S21_L003_R1_001.fastq \
trimmed_unpaired_545_S21_L003_R1_001.fastq \
trimmed_paired_545_S21_L003_R2_001.fastq \
trimmed_unpaired_545_S21_L003_R2_001.fastq

## --------------------------------