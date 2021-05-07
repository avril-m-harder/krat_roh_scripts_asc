#!/bin/bash
#
#	QUEUE: LARGE -- CPU: 20
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

## Set batch group
GROUP=_2_

## Create a directory on /scratch
mkdir /scratch/${USER}_${PROJ}/_2_

## Set permissions for directory
chmod 700 /scratch/${USER}_${PROJ}/_2_

##  Copy input files to scratch
# cp /home/$USER/$PROJ/input/* /scratch/${USER}_${PROJ}/

## cd into working scratch directory
cd /scratch/${USER}_${PROJ}/_2_/


## --------------------------------
## Load modules
module load bwa/0.7.12
module load samtools/1.11
#module load bedtools/2.29.2

## Index reference genome file
# bwa index hifiasm_kangaroo_rat_6cells.p_ctg.fasta.gz

## --------------------------------
## Combine reads from different lanes within sample + forward/reverse for each sample
while read -a line
do
cat /scratch/aubaxh002_01_read_qc_trimming/_2_/trimmed_paired_${line[0]}_L003_R1_001.fastq.gz \
/scratch/aubaxh002_01_read_qc_trimming/_2_/trimmed_paired_${line[0]}_L004_R1_001.fastq.gz > \
trimmed_paired_${line[0]}_R1.fastq.gz
cat /scratch/aubaxh002_01_read_qc_trimming/_2_/trimmed_paired_${line[0]}_L003_R2_001.fastq.gz \
/scratch/aubaxh002_01_read_qc_trimming/_2_/trimmed_paired_${line[0]}_L004_R2_001.fastq.gz > \
trimmed_paired_${line[0]}_R2.fastq.gz
done < /home/aubaxh002/sample_lists/_2_.txt


## --------------------------------
## Align reads to default (smaller) genome
while read -a line
do
bwa mem -t 20 -M ../hifiasm_kangaroo_rat_6cells.p_ctg.fasta.gz \
trimmed_paired_${line[0]}_R1.fastq.gz \
trimmed_paired_${line[0]}_R2.fastq.gz \
> ${line[0]}_small_genome.bam
done < /home/aubaxh002/sample_lists/_2_.txt

## --------------------------------
## Sort bam files and get some mapping stats on them
while read -a line
do
samtools sort ${line[0]}_small_genome.bam -o ${line[0]}_small_genome_sorted.bam
samtools flagstat -@ 20 -O tsv ${line[0]}_small_genome_sorted.bam > ${line[0]}_flagstat_out.txt
done < /home/aubaxh002/sample_lists/_2_.txt

## --------------------------------

## Copy results back to project output directory (in home)
cp *sorted.bam /home/$USER/$PROJ/output/sorted_bam_files/
cp *_flagstat_out.txt home/$USER/$PROJ/output/flagstat_out/

