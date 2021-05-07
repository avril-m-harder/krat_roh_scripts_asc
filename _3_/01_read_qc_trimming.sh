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
GROUP=_3_

## Create a directory on /scratch
# mkdir /scratch/${USER}_${PROJ}/_3_

## Set permissions for directory
# chmod 700 /scratch/${USER}_${PROJ}/_3_

##  Move unzipped fastq files to  dir to process
# while read -a line
# do
# 	mv /scratch/${USER}_${PROJ}/${line[0]}*.fastq /scratch/${USER}_${PROJ}/_3_/
# done < /home/aubaxh002/sample_lists/_3_.txt

## cd into working scratch directory
cd /scratch/${USER}_${PROJ}/_3_/

## make output folder for fastqc output
# mkdir ./output/


## --------------------------------
## Load modules 

module load trimmomatic/0.38
module load fastqc/0.10.1

## Run fastqc on all 4 read files per sample
# while read -a line
# do
# 	fastqc -t 4 -o output/ \
# 	${line[0]}_L003_R1_001.fastq \
# 	${line[0]}_L003_R2_001.fastq \
# 	${line[0]}_L004_R1_001.fastq \
# 	${line[0]}_L004_R2_001.fastq
# done < /home/aubaxh002/sample_lists/_3_.txt

## Run Trimmomatic to clean and trim adapters from reads using custom adapter.fa file,
## then run FastQC on the trimmed files
while read -a line
do
	trimmomatic PE -phred33 -threads 10	\
	${line[0]}_L003_R1_001.fastq \
	${line[0]}_L003_R2_001.fastq \
	trimmed_paired_${line[0]}_L003_R1_001.fastq \
	trimmed_unpaired_${line[0]}_L003_R1_001.fastq \
	trimmed_paired_${line[0]}_L003_R2_001.fastq \
	trimmed_unpaired_${line[0]}_L003_R2_001.fastq \
	LEADING:20 TRAILING:20 MINLEN:30 \
	ILLUMINACLIP:/home/aubaxh002/scripts/illumina_truseq_adapter.fa:2:40:10

	trimmomatic PE -phred33 -threads 10	\
	${line[0]}_L004_R1_001.fastq \
	${line[0]}_L004_R2_001.fastq \
	trimmed_paired_${line[0]}_L004_R1_001.fastq \
	trimmed_unpaired_${line[0]}_L004_R1_001.fastq \
	trimmed_paired_${line[0]}_L004_R2_001.fastq \
	trimmed_unpaired_${line[0]}_L004_R2_001.fastq \
	LEADING:20 TRAILING:20 MINLEN:30 \
	ILLUMINACLIP:/home/aubaxh002/scripts/illumina_truseq_adapter.fa:2:40:10
	
	fastqc -t 4 -o output/ \
	trimmed_paired_${line[0]}_L003_R1_001.fastq \
	trimmed_unpaired_${line[0]}_L003_R1_001.fastq \
	trimmed_paired_${line[0]}_L003_R2_001.fastq \
	trimmed_unpaired_${line[0]}_L003_R2_001.fastq

	fastqc -t 4 -o output/ \
	trimmed_paired_${line[0]}_L004_R1_001.fastq \
	trimmed_unpaired_${line[0]}_L004_R1_001.fastq \
	trimmed_paired_${line[0]}_L004_R2_001.fastq \
	trimmed_unpaired_${line[0]}_L004_R2_001.fastq
done < /home/aubaxh002/sample_lists/_3_.txt


## --------------------------------

## Copy results back to project output directory (in home)
cp /scratch/${USER}_${PROJ}/_3_/output/* /home/$USER/$PROJ/output/
