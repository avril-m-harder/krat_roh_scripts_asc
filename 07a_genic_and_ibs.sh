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
# cp /home/aubaxh002/06_morefilt_and_ROHs/output/allsamps_het_filt.recode.vcf.gz .
# cp /home/${USER}/${PROJ}/input/* .

## include genes
# vcftools --gzvcf allsamps_het_filt.recode.vcf.gz \
# --recode --recode-INFO-all \
# --bed genic_regions.bed \
# --out allsamps_het_filt_genicSNPs
# 	
# bgzip allsamps_het_filt_genicSNPs.recode.vcf
# 
# ## include genes + buffer
# vcftools --gzvcf allsamps_het_filt.recode.vcf.gz \
# --recode --recode-INFO-all \
# --bed genic_regions_w_5kb_buffer.bed \
# --out allsamps_het_filt_genicSNPs_5kbbuffer
# 	
# bgzip allsamps_het_filt_genicSNPs_5kbbuffer.recode.vcf

## exclude genes
# vcftools --gzvcf allsamps_het_filt.recode.vcf.gz \
# --recode --recode-INFO-all \
# --exclude-bed genic_regions.bed \
# --out allsamps_het_filt_intergenicSNPs
# 	
# bgzip allsamps_het_filt_intergenicSNPs.recode.vcf
# 
# ## exclude genes + buffer
# vcftools --gzvcf allsamps_het_filt.recode.vcf.gz \
# --recode --recode-INFO-all \
# --exclude-bed genic_regions_w_5kb_buffer.bed \
# --out allsamps_het_filt_intergenicSNPs_5kbbuffer
# 	
# bgzip allsamps_het_filt_intergenicSNPs_5kbbuffer.recode.vcf


## --------------------------------
## Convert VCF to PLINK format(s)
# for i in allsamps_het_filt_genicSNPs \
# 		 allsamps_het_filt_intergenicSNPs \
# 		 allsamps_het_filt_genicSNPs_5kbbuffer \
# 		 allsamps_het_filt_intergenicSNPs_5kbbuffer
# 	do
# 	plink \
# 	--vcf ${i}.recode.vcf.gz \
# 	--allow-extra-chr \
# 	--out ${i}
# 	done


## --------------------------------
## Produce .ped and .map files for PLINK
for i in allsamps_het_filt 
# 		 allsamps_het_filt_genicSNPs \
# 		 allsamps_het_filt_intergenicSNPs \
# 		 allsamps_het_filt_genicSNPs_5kbbuffer \
# 		 allsamps_het_filt_intergenicSNPs_5kbbuffer
	do
	vcftools --plink \
	--out ${i} \
	--gzvcf ${i}.recode.vcf.gz
	done


## --------------------------------
## Run PLINK to calculate IBS -- produces a matrix of proportions of sites identical 
## between samples
# for i in allsamps_het_filt_genicSNPs \
# 		 allsamps_het_filt_intergenicSNPs \
# 		 allsamps_het_filt_genicSNPs_5kbbuffer \
# 		 allsamps_het_filt_intergenicSNPs_5kbbuffer
# 	do
# 	plink \
# 	--file ${i} \
# 	--out ${i} \
# 	--distance ibs flat-missing 
# 	done
	

## Run PLINK to calculate IBD -- see Ch. 8 here: 
## https://zzz.bwh.harvard.edu/plink/dist/plink-doc-1.07.pdf, but using v1.9 
for i in allsamps_het_filt
# 		 allsamps_het_filt_genicSNPs \
# 		 allsamps_het_filt_intergenicSNPs \
# 		 allsamps_het_filt_genicSNPs_5kbbuffer \
# 		 allsamps_het_filt_intergenicSNPs_5kbbuffer
	do
	plink \
	--file ${i} \
	--out ${i} \
	--genome full
	done


## --------------------------------
## Copy results back to project output directory (in home)
