#!/bin/bash
#
#   +-----------------------+
#   |  USE:                 |
#   |    - SMALL queue      |
#   |    - 1 CPU + def Gb   |
#   +-----------------------+
#
#  Replace the USER name in this script with your username and
#  call your project whatever you want
#
#  This script must be made executable like this
#    chmod +x my_script
#
#  Submit this script to the queue with a command like this
#    run_script my_script.sh
#
#  My preferred setup before running:
#    -- script to be run in /home/projectdir/scripts
#    -- project directory (of same name as script) in /home/
#    -- /input/ and /output/ subdirs within project dir

##  Set username
USER=aubaxh002

## Set project name
PROJ=06_morefilt_and_ROHs

## Create a directory on /scratch
mkdir /scratch/${USER}_${PROJ}/

## Set permissions for directory
chmod 700 /scratch/${USER}_${PROJ}/

##  Copy input files to scratch
cp /home/$USER/$PROJ/input/* /scratch/${USER}_${PROJ}/

## cd into working scratch directory
cd /scratch/${USER}_${PROJ}/


## --------------------------------
## Load modules
module load vcftools/0.1.14
module load bcftools/1.13

## --------------------------------
## Copy VCF file here
# cp /home/aubaxh002/03_snp_calling/output/all_samples_nobaseQrecal_filtered_SNPs_only_less_stringent_nearindelfilt_missdatafilt.recode.vcf.gz \
# ./allsamples_fullfilt.vcf.gz


## --------------------------------
## Filter by MAF and HWE (MAF >= 0.05 and sites with high heterozygosity - see 
## popgenstatscheck.R for details)
# vcftools --gzvcf allsamples_fullfilt.vcf.gz --maf 0.05 \
# --exclude high_het_sites_to_filter.txt \
# --recode --recode-INFO-all \
# --out allsamps_maf_and_het_filt

# bgzip allsamps_maf_and_het_filt.recode.vcf

bcftools stats allsamps_maf_and_het_filt.recode.vcf.gz > \
allsamps_maf_and_het_filt_STATS.txt

## --------------------------------
## Filter only by HWE (sites with high heterozygosity - see 
## popgenstatscheck.R for details)
# vcftools --gzvcf allsamples_fullfilt.vcf.gz \
# --exclude-positions high_het_sites_to_filter.txt \
# --recode --recode-INFO-all \
# --out allsamps_het_filt

# bgzip allsamps_het_filt.recode.vcf

bcftools stats allsamps_het_filt.recode.vcf.gz > \
allsamps_het_filt_STATS.txt

## --------------------------------
## Generate allele frequency files for use with bcftools roh & index
# bcftools query -f'%CHROM\t%POS\t%REF,%ALT\t%INFO/AF\n' \
# allsamps_maf_and_het_filt.recode.vcf.gz \
# | bgzip -c > allsamps_maf_and_het_filt.recode.tab.gz
# 
# tabix -s1 -b2 -e2 allsamps_maf_and_het_filt.recode.tab.gz
# 
# bcftools query -f'%CHROM\t%POS\t%REF,%ALT\t%INFO/AF\n' \
# allsamps_het_filt.recode.vcf.gz \
# | bgzip -c > allsamps_het_filt.recode.tab.gz
# 
# tabix -s1 -b2 -e2 allsamps_het_filt.recode.tab.gz
# 
# 
# ## --------------------------------
# ## Call ROHs using likelihood information
# bcftools roh \
# --threads 20 \
# -o allsamps_maf_and_het_filt.txt \
# --AF-file allsamps_maf_and_het_filt.recode.tab.gz \
# allsamps_maf_and_het_filt.recode.vcf.gz
# 
# bcftools roh \
# --threads 20 \
# -o allsamps_het_filt.txt \
# --AF-file allsamps_het_filt.recode.tab.gz \
# allsamps_het_filt.recode.vcf.gz
# 
# grep "^RG" allsamps_het_filt.txt > allsamps_het_filt_RG_ONLY.txt
# grep "^RG" allsamps_maf_and_het_filt.txt > allsamps_maf_and_het_filt_RG_ONLY.txt
# 
# ## --------------------------------
# ## Copy results back to project output directory (in home)
# cp allsamps_het_filt_RG_ONLY.txt /home/$USER/$PROJ/output/
# cp allsamps_maf_and_het_filt_RG_ONLY.txt /home/$USER/$PROJ/output/

mail -s 'BCFtools/ROH run finished' avrilharder@gmail.com <<< 'BCFtools/ROH run finished'