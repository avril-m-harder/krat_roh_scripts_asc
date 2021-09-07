#!/bin/bash
#
#  Replace the USER name in this script with your username and
#  call your project whatever you want
#
#  This script must be made executable like this
#    chmod +x my_script
#
#  Submit this script to the queue with a command like this
#    run_script my_script.sh

##  Set username
USER=aubaxh002

## Set project name
PROJ=07_genic_and_ibs

## Create a directory on /scratch
mkdir /scratch/${USER}_${PROJ}/

## Set permissions for directory
chmod 700 /scratch/${USER}_${PROJ}/

## cd into working scratch directory
cd /scratch/${USER}_${PROJ}/


## --------------------------------
## Load module 
module load anaconda/3-2020.11
module load vcftools/0.1.14


## --------------------------------
## Generate new genic and intergenic VCF files
cp /home/aubaxh002/06_morefilt_and_ROHs/output/allsamps_het_filt.recode.vcf.gz .

## keep SNPs located in annotated genic regions
vcftools --gzvcf allsamps_het_filt.recode.vcf.gz \
--bed genic_regions.bed \
--recode --recode-INFO-all \
--out allsamps_het_filt_genicSNPs


## keep SNPs located outside of annotated genic regions (i.e., intergenic)
vcftools --gzvcf allsamps_het_filt.recode.vcf.gz \
--exclude-bed genic_regions.bed \
--recode --recode-INFO-all \
--out allsamps_het_filt_intergenicSNPs


## --------------------------------
## Convert VCF to PLINK format(s)
# plink \
# --vcf /scratch/aubaxh002_03b_noBQSR_genomicsdb/all_samples_nobaseQrecal_filtered_SNPs_only_less_stringent.vcf.gz \
# --allow-extra-chr \
# --out gatk_less_stringent

# plink \
# --vcf /scratch/aubaxh002_03b_noBQSR_genomicsdb/all_samples_nobaseQrecal_filtered_SNPs_only.vcf.gz \
# --allow-extra-chr \
# --out gatk_more_stringent


## --------------------------------
## Select .fam file to use
## parent-offspring relationships only (all relations also available)
# cp /home/aubaxh002/krat_roh_scripts_asc/parent_offspring_only_plink_fam_file.txt \
# /scratch/${USER}_${PROJ}/gatk_less_stringent.fam

# cp /home/aubaxh002/krat_roh_scripts_asc/parent_offspring_only_plink_fam_file.txt \
# /scratch/${USER}_${PROJ}/gatk_more_stringent.fam


## --------------------------------
## Run PLINK to ID ROHs, varying a couple of parameters to check effects on output:
## try out a few different values for # of heterozygous sites allowed within a window,
## default = 1
# for a in 1 2 3 4
# do
## try out a few different values for max inverse density (kb/var),
## default = at least 1 var / 50 kb
# 	for b in 10 50 100 
# 	do
# 		plink --bim gatk_less_stringent.bim \
# 		--bed gatk_less_stringent.bed \
# 		--fam gatk_less_stringent.fam \
# 		--allow-extra-chr --no-pheno \
# 		--homozyg-window-het $a \
# 		--homozyg-window-missing 5 \
# 		--homozyg-window-snp 50 \
# 		--homozyg-density $b \
# 		--homozyg-gap 100 \
# 		--homozyg-window-threshold 0.05 \
# 		--homozyg-snp 100 \
# 		--homozyg-kb 100 \
# 		--out ./output/gatk_less_stringent.$a.$b.roh
# 	done
# done


# for a in 1 2 3 4
# do
# ## try out a few different values for max inverse density (kb/var),
# ## default = at least 1 var / 50 kb
# 	for b in 10 50 100 
# 	do
# 		plink --bim gatk_more_stringent.bim \
# 		--bed gatk_more_stringent.bed \
# 		--fam gatk_more_stringent.fam \
# 		--allow-extra-chr --no-pheno \
# 		--homozyg-window-het $a \
# 		--homozyg-window-missing 5 \
# 		--homozyg-window-snp 50 \
# 		--homozyg-density $b \
# 		--homozyg-gap 100 \
# 		--homozyg-window-threshold 0.05 \
# 		--homozyg-snp 100 \
# 		--homozyg-kb 100 \
# 		--out ./output/gatk_more_stringent.$a.$b.roh
# 	done
# done

## --------------------------------
## Copy results back to project output directory (in home)



























