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
PROJ=05_popgen_stats

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


## --------------------------------
## Copy VCF file here
# cp /home/aubaxh002/03_snp_calling/output/all_samples_nobaseQrecal_filtered_SNPs_only_less_stringent_nearindelfilt_missdatafilt.recode.vcf.gz \
# ./allsamples_fullfilt.vcf.gz

cp allsamps_het_filt_filtcontigs_LDpruned_MAF.05.recode.vcf.gz allsamps_MAFLD.vcf.gz


## --------------------------------
## Calculate some stats
## nucleotide diversity in windows (settings borrowed from SM)
# vcftools --gzvcf allsamps_MAFLD.vcf.gz --window-pi 100000 --window-pi-step 50000 \
# --out allsamps_MAFLD_nucdivers

## per-sample mean depth (just to cross-check with other output)
vcftools --gzvcf allsamps_MAFLD.vcf.gz --depth --out allsamps_MAFLD_meandepth

## individual heterozygosity (F estimated using a method of moments)
vcftools --gzvcf allsamps_MAFLD.vcf.gz --het --out allsamps_MAFLD_heterozyg

## HWE p-values
# vcftools --gzvcf allsamps_MAFLD.vcf.gz --hardy --out allsamps_MAFLD_hwe
# 
# ## relatedness - not super sure on the math here
# vcftools --gzvcf allsamps_MAFLD.vcf.gz --relatedness --out allsamps_MAFLD_relat1
# 
# ## the other relatedness - method: doi:10.1093/bioinformatics/btq559
# vcftools --gzvcf allsamps_MAFLD.vcf.gz --relatedness2 --out allsamps_MAFLD_relat2

## summarize missingness per individual
vcftools --gzvcf allsamps_MAFLD.vcf.gz --missing-indv --out allsamps_MAFLD_indivmiss

## summarize missingness per site
# vcftools --gzvcf allsamps_MAFLD.vcf.gz --missing-site --out allsamps_MAFLD_sitemiss


## --------------------------------
## Copy results back to project output directory (in home)
cp allsamps_* /home/$USER/$PROJ/output/
