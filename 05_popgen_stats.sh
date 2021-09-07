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


## --------------------------------
## Calculate some stats
## -- All samples -- "final" filtered set
## nucleotide diversity in windows (settings borrowed from SM)
# vcftools --gzvcf allsamples_fullfilt.vcf.gz --window-pi 100000 --window-pi-step 50000 \
# --out allsamps_nucdivers
# 
# ## per-sample mean depth (just to cross-check with other output)
# vcftools --gzvcf allsamples_fullfilt.vcf.gz --depth --out allsamps_meandepth
# 
# ## individual heterozygosity (F estimated using a method of moments)
# vcftools --gzvcf allsamples_fullfilt.vcf.gz --het --out allsamps_heterozyg
# 
# ## HWE p-values
# vcftools --gzvcf allsamples_fullfilt.vcf.gz --hardy --out allsamps_hwe
# 
# ## relatedness - not super sure on the math here
# vcftools --gzvcf allsamples_fullfilt.vcf.gz --relatedness --out allsamps_relat1
# 
# ## the other relatedness - method: doi:10.1093/bioinformatics/btq559
# vcftools --gzvcf allsamples_fullfilt.vcf.gz --relatedness2 --out allsamps_relat2
# 
# ## summarize missingness per individual
# vcftools --gzvcf allsamples_fullfilt.vcf.gz --missing-indv --out allsamps_indivmiss
# 
# ## summarize missingness per site
# vcftools --gzvcf allsamples_fullfilt.vcf.gz --missing-site --out allsamps_sitemiss


## -- All samples -- further het filtered set
## nucleotide diversity in windows (settings borrowed from SM)
vcftools --gzvcf \
/scratch/aubaxh002_06_morefilt_and_ROHs/allsamps_het_filt.recode.vcf.gz \
--window-pi 100000 --window-pi-step 50000 \
--out allsamps_hetfiltnucdivers

## and a bunch of other things
for i in depth het hardy relatedness relatedness2 missing-indv missing-site
	do
	vcftools \
	--gzvcf /scratch/aubaxh002_06_morefilt_and_ROHs/allsamps_het_filt.recode.vcf.gz \
	--$i --out allsamps_hetfilt_${i}
	done


## -- All samples -- further het and MAF filtered set
## nucleotide diversity in windows (settings borrowed from SM)
vcftools --gzvcf \
/scratch/aubaxh002_06_morefilt_and_ROHs/allsamps_maf_and_het_filt.recode.vcf.gz \
--window-pi 100000 --window-pi-step 50000 \
--out allsamps_mafandhetfiltnucdivers

## and a bunch of other things
for i in depth het hardy relatedness relatedness2 missing-indv missing-site
	do
	vcftools \
	--gzvcf /scratch/aubaxh002_06_morefilt_and_ROHs/allsamps_maf_and_het_filt.recode.vcf.gz \
	--$i --out allsamps_mafandhetfilt_${i}
	done
	

## --------------------------------
## Copy results back to project output directory (in home)
cp allsamps_* /home/$USER/$PROJ/output/
