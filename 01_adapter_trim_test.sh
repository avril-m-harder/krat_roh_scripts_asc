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
PROJ=01_read_qc_trimming

## Set batch group
GROUP=06

## Create a directory on /scratch
# mkdir /scratch/${USER}_${PROJ}/06

## Set permissions for directory
# chmod 700 /scratch/${USER}_${PROJ}/06

## cd into working scratch directory
cd /scratch/${USER}_${PROJ}/06/


## --------------------------------
## Load modules 
module load trimmomatic/0.38
module load fastqc/0.11.9
module load trimgalore/0.6.6


## Run Trimmomatic to clean and trim adapters from reads using custom adapter.fa file,
## then run FastQC on the trimmed files
# trimmomatic PE -phred33 -threads 10	\
# 4893_S49_L003_R1_001.fastq.gz \
# 4893_S49_L003_R2_001.fastq.gz \
# trimmed_paired_4893_S49_L003_R1_001.fastq.gz \
# trimmed_unpaired_4893_S49_L003_R1_001.fastq.gz \
# trimmed_paired_4893_S49_L003_R2_001.fastq.gz \
# trimmed_unpaired_4893_S49_L003_R2_001.fastq.gz \
# LEADING:20 TRAILING:20 MINLEN:30 \
# ILLUMINACLIP:/home/aubaxh002/krat_roh_analyses/scripts/illumina_truseq_adapter.fa:2:40:10
# 
# fastqc -t 4 -o posttrim_output/ \
# trimmed_paired_4893_S49_L003_R1_001.fastq.gz \
# trimmed_unpaired_4893_S49_L003_R1_001.fastq.gz \
# trimmed_paired_4893_S49_L003_R2_001.fastq.gz \
# trimmed_unpaired_4893_S49_L003_R2_001.fastq.gz

## Try out TrimGalore due to retained reverse read adapters with Trimmomatic
trim_galore --paired --quality 20 --phred33 \
--fastqc_args "--outdir posttrim_output/" \
--length 30 \
4893_S49_L003_R1_001.fastq.gz \
4893_S49_L003_R2_001.fastq.gz


# cp posttrim_output/* /home/aubaxh002/krat_roh_analyses/01_read_qc_trimming/posttrim_fastqc/
mv *.i* stdouts/
mv *.o* stdouts/

## --------------------------------
## Copy results back to project output directory (in home)
# cp /scratch/${USER}_${PROJ}/06/output/* /home/$USER/$PROJ/output/

# mail -s 'QC + trim finished - 06' avrilharder@gmail.com <<< 'QC + trim finished - 06'
