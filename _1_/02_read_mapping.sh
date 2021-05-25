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
GROUP=_1_

## Create a directory on /scratch
mkdir /scratch/${USER}_${PROJ}/_1_

## Set permissions for directory
chmod 700 /scratch/${USER}_${PROJ}/_1_

##  Copy input files to scratch
# cp /home/$USER/$PROJ/input/* /scratch/${USER}_${PROJ}/

## cd into working scratch directory
cd /scratch/${USER}_${PROJ}/_1_/


## --------------------------------
## Load modules
module load bwa/0.7.12
module load samtools/1.11
module load picard/1.79
#module load bedtools/2.29.2

## Index reference genome file
# bwa index hifiasm_kangaroo_rat_6cells.p_ctg.fasta.gz


## --------------------------------
## Align reads to default (smaller) genome - keep lanes separate for now
while read -a line
do

bwa mem -t 20 -M ../hifiasm_kangaroo_rat_6cells.p_ctg.fasta.gz \
/scratch/aubaxh002_01_read_qc_trimming/_1_/trimmed_paired_${line[0]}_L003_R1_001.fastq.gz \
/scratch/aubaxh002_01_read_qc_trimming/_1_/trimmed_paired_${line[0]}_L003_R2_001.fastq.gz \
> ${line[0]}_L003_small_genome.bam

bwa mem -t 20 -M ../hifiasm_kangaroo_rat_6cells.p_ctg.fasta.gz \
/scratch/aubaxh002_01_read_qc_trimming/_1_/trimmed_paired_${line[0]}_L004_R1_001.fastq.gz \
/scratch/aubaxh002_01_read_qc_trimming/_1_/trimmed_paired_${line[0]}_L004_R2_001.fastq.gz \
> ${line[0]}_L004_small_genome.bam

## add read group information to differentiate the two lanes (3 and 4)
java -jar /opt/asn/apps/picard_1.79/picard_1.79/picard-tools-1.79/AddOrReplaceReadGroups.jar \
I=${line[0]}_L003_small_genome.bam \
O=${line[0]}_L003_small_genome_rgroups.bam \
SORT_ORDER=coordinate RGID=group1 RGLB=lib1 RGPL=illumina RGSM=4058_S46 RGPU=unit3

java -jar /opt/asn/apps/picard_1.79/picard_1.79/picard-tools-1.79/AddOrReplaceReadGroups.jar \
I=${line[0]}_L004_small_genome.bam \
O=${line[0]}_L004_small_genome_rgroups.bam \
SORT_ORDER=coordinate RGID=group1 RGLB=lib1 RGPL=illumina RGSM=4058_S46 RGPU=unit4

## merge BAM files within each sample
java -jar /opt/asn/apps/picard_1.79/picard_1.79/picard-tools-1.79/MergeSamFiles.jar \
I=${line[0]}_L003_small_genome_rgroups.bam \
I=${line[0]}_L004_small_genome_rgroups.bam \
SORT_ORDER=coordinate \
O=sorted_${line[0]}_small_genome_rgroups.bam

## get some mapping stats
samtools flagstat -@ 20 -O tsv ${line[0]}_small_genome_rgroups.bam > ${line[0]}_rgroups_flagstat_out.txt

done < /home/aubaxh002/sample_lists/_1_.txt


## --------------------------------

## Copy results back to project output directory (in home)
cp sorted_*_small_genome_rgroups.bam /home/$USER/$PROJ/output/sorted_bam_files/
cp *_rgroups_flagstat_out.txt home/$USER/$PROJ/output/flagstat_out/

