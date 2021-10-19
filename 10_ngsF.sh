#!/bin/bash
#
#   +-----------------------+
#   |  USE:                 |
#   |    - MEDIUM queue     |
#   |    - 10 CPU + 10 Gb   |
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
PROJ=09_ngsrelate

## Create a directory on /scratch
# mkdir /scratch/${USER}_${PROJ}/

## Set permissions for directory
# chmod 700 /scratch/${USER}_${PROJ}/

##  Copy input files to scratch
# cp /home/$USER/$PROJ/input/* /scratch/${USER}_${PROJ}/

## cd into working scratch directory
cd /scratch/${USER}_${PROJ}/


## --------------------------------
## Install NgsRelate - only run if re-initiating the project scratch directory
# git clone --recursive https://github.com/SAMtools/htslib
# git clone https://github.com/ANGSD/ngsRelate
# cd htslib/;make -j2;cd ../ngsRelate;make HTSSRC=../htslib/


## --------------------------------
## Run NgsRelate using VCF input
# cp /home/aubaxh002/07_genic_and_ibs/output/allsamps_het_filt_filtcontigs_LDpruned.recode.vcf.gz \
# ./allsamps_LDpruned.vcf.gz 
# cp /home/aubaxh002/07_genic_and_ibs/input/genic_regions.bed .

# ./ngsRelate/ngsRelate -h allsamps_LDpruned.vcf.gz \
# -T PL \
# -A AF \
# -p 10 \
# -O ngsrelate_allsamps_LDpruned.res

## filter input VCF for genic regions and run ngsRelate again
module load vcftools
module load samtools

## include genes
# vcftools --gzvcf allsamps_LDpruned.vcf.gz \
# --recode --recode-INFO-all \
# --bed genic_regions.bed \
# --out allsamps_LDpruned_genicSNPs
# 	
# bgzip allsamps_LDpruned_genicSNPs.recode.vcf
# 
# ## exclude genes
# # vcftools --gzvcf allsamps_LDpruned.vcf.gz \
# # --recode --recode-INFO-all \
# # --exclude-bed genic_regions.bed \
# # --out allsamps_LDpruned_intergenicSNPs
# 
# bgzip allsamps_LDpruned_intergenicSNPs.recode.vcf
# 
# ## run ngsrelate
# ./ngsRelate/ngsRelate -h allsamps_LDpruned_genicSNPs.recode.vcf.gz \
# -T PL \
# -A AF \
# -p 10 \
# -O ngsrelate_allsamps_LDpruned_genic.res
# 
# ./ngsRelate/ngsRelate -h allsamps_LDpruned_intergenicSNPs.recode.vcf.gz \
# -T PL \
# -A AF \
# -p 10 \
# -O ngsrelate_allsamps_LDpruned_intergenic.res

./ngsRelate/ngsRelate -F 1 \
-p 10 -h allsamps_LDpruned.vcf.gz \
-O ngsrelate_F_estimates.res

## --------------------------------
## Copy results back to project output directory (in home)
# cp *.res /home/$USER/$PROJ/output/

mail -s 'NgsRelate finished' avrilharder@gmail.com <<< 'NgsRelate finished'












