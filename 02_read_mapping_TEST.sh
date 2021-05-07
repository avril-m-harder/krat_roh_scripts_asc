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

## Create a directory on /scratch
# mkdir /scratch/${USER}_${PROJ}/

## Set permissions for directory
# chmod 700 /scratch/${USER}_${PROJ}/

##  Copy input files to scratch
# cp /home/$USER/$PROJ/input/* /scratch/${USER}_${PROJ}/

## cd into working scratch directory
cd /scratch/${USER}_${PROJ}/


## --------------------------------
## Load modules
# module load bwa/0.7.12
module load samtools/1.11
module load bedtools/2.29.2

## Index reference genome files
# bwa index hifiasm_kangaroo_rat_6cells.p_ctg.fasta.gz

# bwa index hifiasm_kangaroo_rat_6cells_no_purge.p_ctg.fasta.gz

## --------------------------------
## Combine reads from different lanes within sample + forward/reverse
## ONLY FOCUSING ON TWO SAMPLES FOR NOW
## sample 4922
# cat /scratch/aubaxh002_01_read_qc_trimming/_6_/trimmed_paired_4922_S58_L003_R1_001.fastq \
# /scratch/aubaxh002_01_read_qc_trimming/_6_/trimmed_paired_4922_S58_L004_R1_001.fastq > \
# trimmed_paired_4922_S58_R1.fastq
# 
# cat /scratch/aubaxh002_01_read_qc_trimming/_6_/trimmed_paired_4922_S58_L003_R2_001.fastq \
# /scratch/aubaxh002_01_read_qc_trimming/_6_/trimmed_paired_4922_S58_L004_R2_001.fastq > \
# trimmed_paired_4922_S58_R2.fastq
# 
# ## sample 4927
# cat /scratch/aubaxh002_01_read_qc_trimming/_6_/trimmed_paired_4927_S59_L003_R1_001.fastq \
# /scratch/aubaxh002_01_read_qc_trimming/_6_/trimmed_paired_4927_S59_L004_R1_001.fastq > \
# trimmed_paired_4927_S59_R1.fastq
# 
# cat /scratch/aubaxh002_01_read_qc_trimming/_6_/trimmed_paired_4927_S59_L003_R2_001.fastq \
# /scratch/aubaxh002_01_read_qc_trimming/_6_/trimmed_paired_4927_S59_L004_R2_001.fastq > \
# trimmed_paired_4927_S59_R2.fastq

## --------------------------------
## Align reads from smallest sample to:
## default genome
# bwa mem -t 20 -M hifiasm_kangaroo_rat_6cells.p_ctg.fasta.gz \
# trimmed_paired_4922_S58_R1.fastq \
# trimmed_paired_4922_S58_R2.fastq \
# > 4922_S58_small_genome.bam

## no-purge genome
# bwa mem -t 20 -M hifiasm_kangaroo_rat_6cells_no_purge.p_ctg.fasta.gz \
# trimmed_paired_4922_S58_R1.fastq \
# trimmed_paired_4922_S58_R2.fastq \
# > 4922_S58_large_genome.bam

## --------------------------------
## Align reads from largest sample to:
## default genome
# bwa mem -t 20 -M hifiasm_kangaroo_rat_6cells.p_ctg.fasta.gz \
# trimmed_paired_4927_S59_R1.fastq \
# trimmed_paired_4927_S59_R2.fastq \
# > 4927_S59_small_genome.bam

## no-purge genome
# bwa mem -t 20 -M hifiasm_kangaroo_rat_6cells_no_purge.p_ctg.fasta.gz \
# trimmed_paired_4927_S59_R1.fastq \
# trimmed_paired_4927_S59_R2.fastq \
# > 4927_S59_large_genome.bam

## --------------------------------
## Get some read mapping stats on the BAM files
# samtools flagstat -@ 20 -O tsv 4922_S58_small_genome.bam
# samtools flagstat -@ 20 -O tsv 4922_S58_large_genome.bam
# samtools flagstat -@ 20 -O tsv 4927_S59_small_genome.bam
# samtools flagstat -@ 20 -O tsv 4927_S59_large_genome.bam

## --------------------------------
## Sort bam files
samtools sort 4922_S58_small_genome.bam -o 4922_S58_small_genome_sorted.bam
samtools sort 4922_S58_large_genome.bam -o 4922_S58_large_genome_sorted.bam
samtools sort 4927_S59_small_genome.bam -o 4927_S59_small_genome_sorted.bam
samtools sort 4927_S59_large_genome.bam -o 4927_S59_large_genome_sorted.bam

## --------------------------------
## Get some alignment coverage stats (-dz = only report non-zero positions)
bedtools genomecov -dz -ibam 4922_S58_small_genome_sorted.bam > 4922_S58_small_genome_covg.txt
bedtools genomecov -dz -ibam 4922_S58_large_genome_sorted.bam > 4922_S58_large_genome_covg.txt
bedtools genomecov -dz -ibam 4927_S59_small_genome_sorted.bam > 4927_S59_small_genome_covg.txt
bedtools genomecov -dz -ibam 4927_S59_large_genome_sorted.bam > 4927_S59_large_genome_covg.txt

## --------------------------------

## Copy results back to project output directory (in home)
# cp hifiasm_kangaroo_rat_6cells_no_purge.p_ctg.fasta.fai /home/$USER/$PROJ/output/

