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
GROUP=_group_

## Create a directory on /scratch
mkdir /scratch/${USER}_${PROJ}/_group_

## Set permissions for directory
chmod 700 /scratch/${USER}_${PROJ}/_group_

##  Copy input files to scratch
# cp /home/$USER/$PROJ/input/* /scratch/${USER}_${PROJ}/

## cd into working scratch directory
cd /scratch/${USER}_${PROJ}/_group_


## --------------------------------
## Load modules 

module load samtools/1.11
module load picard/1.79

## --------------------------------
## Mark duplicate reads
# while read -a line
# do
# java -jar /opt/asn/apps/picard_1.79/picard_1.79/picard-tools-1.79/MarkDuplicates.jar \
# I=/scratch/aubaxh002_02_read_mapping/_group_/${line[0]}_small_genome_sorted.bam \
# O=${line[0]}_small_genome_dupmarked.bam \
# M=${line[0]}_markdup_metrics.txt \
# MAX_RECORDS_IN_RAM=250000
# done < /home/aubaxh002/sample_lists/_group_.txt


## --------------------------------
## Add read group information
while read -a line
do
java -jar /opt/asn/apps/picard_1.79/picard_1.79/picard-tools-1.79/AddOrReplaceReadGroups.jar \
I=${line[0]}_small_genome_dupmarked.bam \
O=${line[0]}_small_genome_dupmarked_rgroups.bam \
SORT_ORDER=coordinate RGID=group1 RGLB=lib1 RGPL=illumina RGSM=${line[0]} RGPU=unit1
done < /home/aubaxh002/sample_lists/_group_.txt


## --------------------------------
## Performing local realignment around indels -- only supported in gatk v<3.6
module load gatk/3.4-46

## generate list of intervals to be realigned
while read -a line
do
gatk -T RealignerTargetCreator \
-R /scratch/aubaxh002_assem_indexing/hifiasm_kangaroo_rat_6cells.p_ctg.fasta \
-I ${line[0]}_small_genome_dupmarked_rgroups.bam \
-o ${line[0]}_target_intervals.list

## perform realignment
gatk -T IndelRealigner \
-R /scratch/aubaxh002_assem_indexing/hifiasm_kangaroo_rat_6cells.p_ctg.fasta \
-I ${line[0]}_small_genome_dupmarked_rgroups.bam \
-targetIntervals ${line[0]}_target_intervals.list \
-o ${line[0]}_small_genome_dupmarked_rgroups_realigned.bam
done < /home/aubaxh002/sample_lists/_group_.txt


## --------------------------------
## Fix mate information
while read -a line
do
java -jar /opt/asn/apps/picard_1.79/picard_1.79/picard-tools-1.79/FixMateInformation.jar \
I=${line[0]}_small_genome_dupmarked_rgroups_realigned.bam \
O=${line[0]}_small_genome_dupmarked_rgroups_realigned_fixmate.bam
done < /home/aubaxh002/sample_lists/_group_.txt


## --------------------------------
## Index BAM files
while read -a line
do
java -jar /opt/asn/apps/picard_1.79/picard_1.79/picard-tools-1.79/BuildBamIndex.jar \
I=${line[0]}_small_genome_dupmarked_rgroups_realigned_fixmate.bam
done < /home/aubaxh002/sample_lists/_group_.txt


## --------------------------------
## Recalibrate base quality scores (??)
## Run without this step here, run from here down with this step in another script:
## 03_snp_calling_w_recal.sh

## --------------------------------
## Run HaplotypeCaller in GVCF mode using GATK v4
module unload gatk/3.4-46
module load gatk/4.1.4.0

while read -a line
do
gatk HaplotypeCaller \
-R /scratch/aubaxh002_assem_indexing/hifiasm_kangaroo_rat_6cells.p_ctg.fasta \
-I ${line[0]}_small_genome_dupmarked_rgroups_realigned_fixmate.bam \
--emit-ref-confidence GVCF \
-O ${line[0]}_nobaseQrecal.g.vcf
done < /home/aubaxh002/sample_lists/_group_.txt

