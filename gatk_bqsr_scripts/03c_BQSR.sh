#!/bin/bash
#
#  +---------+
#  | BATCHED |
#  +---------+
#
#  +----------------------+
#  | REQUEST 4 CPU + 60gb |
#  +----------------------+
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

##  Set username
USER=aubaxh002

## Set project name
PROJ=03c_BQSR

## Create a directory on /scratch
mkdir /scratch/${USER}_${PROJ}/

## Set permissions for directory
chmod 700 /scratch/${USER}_${PROJ}/

## cd into working scratch directory
cd /scratch/${USER}_${PROJ}/


## --------------------------------
## Load modules 
module load gatk/4.1.4.0
module load picard/1.79


## --------------------------------
## Identify high-confidence variants to use as "known sites" for BQSR
## --------------------------------
while read -a line
do
## create calibration table for first round of recal (on original BAM)
gatk BaseRecalibrator \
	-I ../03a_preBQSR_snp_calling/${line[0]}_small_genome_rgroups_dupmarked_fixmate.bam \
	-R $ref \
	--known-sites ../03b_genomicsdb/all_samples_best_sites_nobaseQrecal_SNPs.vcf \
	-O ${line[0]}_recal_before.table

## apply recal to generate recal_1 BAM file
gatk ApplyBQSR \
	-R $ref \
	-I ../03a_preBQSR_snp_calling/${line[0]}_small_genome_rgroups_dupmarked_fixmate.bam \
	-bqsr ${line[0]}_recal_before.table \
	-O ${line[0]}_small_genome_rgroups_dupmarked_fixmate_recal_1.bam

## generate calibration table for first round recal product (BAM file)
gatk BaseRecalibrator \
	-I ${line[0]}_small_genome_rgroups_dupmarked_fixmate_recal_1.bam \
	-R $ref \
	--known-sites ../03b_genomicsdb/all_samples_best_sites_nobaseQrecal_SNPs.vcf \
	-O ${line[0]}_recal_1.table

## generate CSV of recal results
gatk AnalyzeCovariates \
	-before ${line[0]}_recal_before.table \
	-after ${line[0]}_recal_1.table \
	-csv ${line[0]}_bqsr_plot_round1.csv 

## apply recal to generate recal_2 BAM file
gatk ApplyBQSR \
	-R $ref \
	-I ${line[0]}_small_genome_rgroups_dupmarked_fixmate_recal_1.bam \
	-bqsr ${line[0]}_recal_1.table \
	-O ${line[0]}_small_genome_rgroups_dupmarked_fixmate_recal_2.bam

## generate calibration table for second round recal product (BAM file)
gatk BaseRecalibrator \
	-I ${line[0]}_small_genome_rgroups_dupmarked_fixmate_recal_2.bam \
	-R $ref \
	--known-sites ../03b_genomicsdb/all_samples_best_sites_nobaseQrecal_SNPs.vcf \
	-O ${line[0]}_recal_2.table

## generate CSV of recal round two results
gatk AnalyzeCovariates \
	-before ${line[0]}_recal_1.table \
	-after ${line[0]}_recal_2.table \
	-csv ${line[0]}_bqsr_plot_round2.csv
done < /home/aubaxh002/sample_lists/_group_.txt

### Next, visualize BQSR results in R (bqsr_plots.R)