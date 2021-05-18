#!/bin/bash
#
#  +-------------+
#  |REQUEST 4 CPU|
#  +-------------+
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
GROUP=_1_

## Create a directory on /scratch
# mkdir /scratch/${USER}_${PROJ}/_1_

## Set permissions for directory
# chmod 700 /scratch/${USER}_${PROJ}/_1_

##  Copy input files to scratch
# cp /home/$USER/$PROJ/input/* /scratch/${USER}_${PROJ}/

## cd into working scratch directory
cd /scratch/${USER}_${PROJ}/_1_


## --------------------------------
## Load modules
# module load samtools/1.11
module load picard/1.79
module load gatk/4.1.4.0
module list

## --------------------------------
## Mark duplicate reads -- ALREADY DONE FOR ALL SAMPLES
# while read -a line
# do
# java -jar /opt/asn/apps/picard_1.79/picard_1.79/picard-tools-1.79/MarkDuplicates.jar \
# I=/scratch/aubaxh002_02_read_mapping/_1_/4058_S46_small_genome_sorted.bam \
# O=4058_S46_small_genome_dupmarked.bam \
# M=4058_S46_markdup_metrics.txt \
# MAX_RECORDS_IN_RAM=250000
# done < /home/aubaxh002/sample_lists/_1_.txt


## --------------------------------
## Add read group information
# java -jar /opt/asn/apps/picard_1.79/picard_1.79/picard-tools-1.79/AddOrReplaceReadGroups.jar \
# I=4058_S46_small_genome_dupmarked.bam \
# O=4058_S46_small_genome_dupmarked_rgroups.bam \
# SORT_ORDER=coordinate RGID=group1 RGLB=lib1 RGPL=illumina RGSM=4058_S46 RGPU=unit1


## --------------------------------
## Fix mate information
# java -jar /opt/asn/apps/picard_1.79/picard_1.79/picard-tools-1.79/FixMateInformation.jar \
# I=4058_S46_small_genome_dupmarked_rgroups.bam \
# O=4058_S46_small_genome_dupmarked_rgroups_fixmate.bam


## --------------------------------
## Index BAM files
# java -jar /opt/asn/apps/picard_1.79/picard_1.79/picard-tools-1.79/BuildBamIndex.jar \
# I=4058_S46_small_genome_dupmarked_rgroups_fixmate.bam


## --------------------------------
## Run HaplotypeCaller in GVCF mode
gatk HaplotypeCaller \
-R /scratch/aubaxh002_assem_indexing/hifiasm_kangaroo_rat_6cells.p_ctg.fasta \
-I 4058_S46_small_genome_dupmarked_rgroups_fixmate.bam \
--emit-ref-confidence GVCF \
-O 4058_S46_nobaseQrecal.g.vcf








































