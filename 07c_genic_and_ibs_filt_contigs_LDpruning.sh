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
## Addition of LD pruning for strong LD! Just run on allsamps het- and contig-filtered
## VCF, then subset LD-pruned VCF to genic and intergenic SNPs +/- 5kb buffers.
## produce .map file
# vcftools --plink \
# --out allsamps_het_filt_filtcontigs \
# --gzvcf allsamps_het_filt_filtcontigs.recode.vcf.gz

## ID SNPs in strong LD -- requires 16 Gb memory!
# plink \
# --file allsamps_het_filt_filtcontigs \
# --out allsamps_het_filt_filtcontigs_LDpruned \
# --allow-extra-chr \
# --indep-pairwise 50 5 0.5


## --------------------------------
## Convert VCF to PLINK format(s)
# for i in allsamps_het_filt \
# 		 allsamps_het_filt_genicSNPs \
# 		 allsamps_het_filt_intergenicSNPs \
# 		 allsamps_het_filt_genicSNPs_5kbbuffer \
# 		 allsamps_het_filt_intergenicSNPs_5kbbuffer
# 	do
#  	bgzip ${i}_filtcontigs.recode.vcf
# 	
# 	plink \
# 	--vcf ${i}_filtcontigs.recode.vcf.gz \
# 	--allow-extra-chr \
# 	--out ${i}_filtcontigs
# 	done
# 
# 
## --------------------------------
## Produce .ped and .map files for PLINK
# for i in allsamps_het_filt \
# 		 allsamps_het_filt_genicSNPs \
# 		 allsamps_het_filt_intergenicSNPs \
# 		 allsamps_het_filt_genicSNPs_5kbbuffer \
# 		 allsamps_het_filt_intergenicSNPs_5kbbuffer
# 	do
# 	vcftools --plink \
# 	--out ${i}_filtcontigs \
# 	--gzvcf ${i}_filtcontigs.recode.vcf.gz
# 	done
# 	
# ## reformat the .map files because they don't include the contig name for some reason?
# for i in allsamps_het_filt \
# 		 allsamps_het_filt_genicSNPs \
# 		 allsamps_het_filt_intergenicSNPs \
# 		 allsamps_het_filt_genicSNPs_5kbbuffer \
# 		 allsamps_het_filt_intergenicSNPs_5kbbuffer
# 	do
# 	awk -F [':','\t'] '{print $2"\t"$2":"$3"\t"$4"\t"$5}' ${i}_filtcontigs.map > temp.map
# 	## hold on to old file though, just in case
# 	mv ${i}_filtcontigs.map unformatted_${i}_filtcontigs.map
# 	mv temp.map ${i}_filtcontigs.map
# 	done
# 
# 
# ## Run PLINK to calculate IBD & IBS, excluding SNPs identified as in LD 
# for i in allsamps_het_filt \
# 		 allsamps_het_filt_genicSNPs \
# 		 allsamps_het_filt_intergenicSNPs \
# 		 allsamps_het_filt_genicSNPs_5kbbuffer \
# 		 allsamps_het_filt_intergenicSNPs_5kbbuffer
# 	do
# 	plink \
# 	--file ${i}_filtcontigs \
# 	--out ${i}_filtcontigs_LDpruned \
# 	--exclude allsamps_het_filt_filtcontigs_LDpruned.prune.out \
# 	--allow-extra-chr \
# 	--genome full
# 	done
# 	
# for i in allsamps_het_filt \
# 		 allsamps_het_filt_genicSNPs \
# 		 allsamps_het_filt_intergenicSNPs \
# 		 allsamps_het_filt_genicSNPs_5kbbuffer \
# 		 allsamps_het_filt_intergenicSNPs_5kbbuffer
# 	do
# 	plink \
# 	--file ${i}_filtcontigs \
# 	--out ${i}_filtcontigs \
# 	--allow-extra-chr \
# 	--genome full
# 	done
	
## --------------------------------
## Produce a new VCF without LD-pruned SNPs for 05_popgen analyses on that set
sed 's/\:/\t/g' allsamps_het_filt_filtcontigs_LDpruned.prune.in > LDpruned_keepsites.tsv

vcftools \
--gzvcf allsamps_het_filt_filtcontigs.recode.vcf.gz \
--out allsamps_het_filt_filtcontigs_LDpruned \
--positions LDpruned_keepsites.tsv \
--recode --recode-INFO-all 


## --------------------------------
## Copy VCF files and .genome back to project output directory (in home) (intermediate steps are fast)

mail -s '07c_filtcontigs_LD finished' avrilharder@gmail.com <<< '07c filtering finished'
