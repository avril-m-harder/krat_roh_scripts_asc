#!/bin/bash
#
#  +-----------------+
#  | REQUIRES 20 CPU |
#  +-----------------+
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

##  Set username
USER=aubaxh002

## Set project name
PROJ=04a_bcftoolsROH

## Create a directory on /scratch
# mkdir /scratch/${USER}_${PROJ}/
# 
# ## Set permissions for directory
# chmod 700 /scratch/${USER}_${PROJ}/

## cd into working scratch directory
cd /scratch/${USER}_${PROJ}/


## --------------------------------
## Load modules
module load bcftools/1.13
# module load samtools/1.11
module load vcftools/0.1.14


## --------------------------------
## Generate allele frequency files for use with bcftools roh & index
# bcftools query -f'%CHROM\t%POS\t%REF,%ALT\t%INFO/AF\n' \
# /scratch/aubaxh002_03b_noBQSR_genomicsdb/all_samples_nobaseQrecal_filtered_SNPs_only.vcf.gz \
# | bgzip -c > freqs_morestringent_filteredSNPsonly.tab.gz
# 
# tabix -s1 -b2 -e2 freqs_morestringent_filteredSNPsonly.tab.gz
# 
# bcftools query -f'%CHROM\t%POS\t%REF,%ALT\t%INFO/AF\n' \
# /scratch/aubaxh002_03b_noBQSR_genomicsdb/all_samples_nobaseQrecal_filtered_SNPs_only_less_stringent.vcf.gz \
# | bgzip -c > freqs_lessstringent_filteredSNPsonly.tab.gz
# 
# tabix -s1 -b2 -e2 freqs_lessstringent_filteredSNPsonly.tab.gz

# bcftools query -f'%CHROM\t%POS\t%REF,%ALT\t%INFO/AF\n' \
# /scratch/aubaxh002_03b_noBQSR_genomicsdb/all_samples_nobaseQrecal_filtered_SNPs_only_less_stringent_nearindelfilt.vcf.gz \
# | bgzip -c > freqs_lessstringent_filteredSNPsonly_nearindelfilt.tab.gz
# 
# tabix -s1 -b2 -e2 freqs_lessstringent_filteredSNPsonly_nearindelfilt.tab.gz
# 
# bcftools query -f'%CHROM\t%POS\t%REF,%ALT\t%INFO/AF\n' \
# /scratch/aubaxh002_03b_noBQSR_genomicsdb/all_samples_nobaseQrecal_filtered_SNPs_only_less_stringent_nearindelfilt_missdatafilt.recode.vcf.gz \
# | bgzip -c > freqs_lessstringent_filteredSNPsonly_nearindelfilt_missdatafilt.tab.gz
# 
# tabix -s1 -b2 -e2 freqs_lessstringent_filteredSNPsonly_nearindelfilt_missdatafilt.tab.gz

# cp /home/aubaxh002/07_genic_and_ibs/output/allsamps_het_filt_filtcontigs_LDpruned.recode.vcf.gz \
# allsamps_LDpruned.vcf.gz
# 
bcftools query -f'%CHROM\t%POS\t%REF,%ALT\t%INFO/AF\n' allsamps_LDpruned.vcf.gz \
| bgzip -c > freqs_allsamps_het_filt_filtcontigs_LDpruned.recode.tab.gz

tabix -s1 -b2 -e2 freqs_allsamps_het_filt_filtcontigs_LDpruned.recode.tab.gz

vcftools \
--out allsamps_het_filt_filtcontigs_LDpruned_MAF.05 \
--gzvcf allsamps_LDpruned.vcf.gz \
--recode --recode-INFO-all \
--maf 0.05

gzip allsamps_het_filt_filtcontigs_LDpruned_MAF.05.recode.vcf

bcftools query -f'%CHROM\t%POS\t%REF,%ALT\t%INFO/AF\n' \
allsamps_het_filt_filtcontigs_LDpruned_MAF.05.recode.vcf.gz \
| bgzip -c > freqs_allsamps_het_filt_filtcontigs_LDpruned_MAF.recode.tab.gz

tabix -s1 -b2 -e2 freqs_allsamps_het_filt_filtcontigs_LDpruned_MAF.recode.tab.gz

## SNPs filtered using more stringent criteria
# bcftools roh \
# --GTs-only 30 \
# --threads 20 \
# -o all_samples_GTonly_AFest_roh_morestringent.txt \
# --AF-file freqs_morestringent_filteredSNPsonly.tab.gz \
# /scratch/aubaxh002_03b_noBQSR_genomicsdb/all_samples_nobaseQrecal_filtered_SNPs_only.vcf.gz
# 
# bcftools roh \
# --threads 20 \
# -o all_samples_GTPL_AFest_roh_morestringent.txt \
# --AF-file freqs_morestringent_filteredSNPsonly.tab.gz \
# /scratch/aubaxh002_03b_noBQSR_genomicsdb/all_samples_nobaseQrecal_filtered_SNPs_only.vcf.gz

## SNPs filtered using less stringent criteria
# bcftools roh \
# --GTs-only 30 \
# --threads 20 \
# -o all_samples_GTonly_AFest_roh_lessstringent.txt \
# --AF-file freqs_lessstringent_filteredSNPsonly.tab.gz \
# /scratch/aubaxh002_03b_noBQSR_genomicsdb/all_samples_nobaseQrecal_filtered_SNPs_only_less_stringent.vcf.gz
# 
# bcftools roh \
# --threads 20 \
# -o all_samples_GTPL_AFest_roh_lessstringent.txt \
# --AF-file freqs_lessstringent_filteredSNPsonly.tab.gz \
# /scratch/aubaxh002_03b_noBQSR_genomicsdb/all_samples_nobaseQrecal_filtered_SNPs_only_less_stringent.vcf.gz

## and with SNPs near indels filtered out, retaining only biallelic sites
# bcftools roh \
# --threads 20 \
# -o all_samples_GTPL_AFest_roh_lessstringent_nearindelfilt.txt \
# --AF-file freqs_lessstringent_filteredSNPsonly_nearindelfilt.tab.gz \
# /scratch/aubaxh002_03b_noBQSR_genomicsdb/all_samples_nobaseQrecal_filtered_SNPs_only_less_stringent_nearindelfilt.vcf.gz 

# bcftools roh \
# --threads 20 \
# --GTs-only 30 \
# -o all_samples_GTonly_AFest_roh_lessstringent_nearindelfilt.txt \
# --AF-file freqs_lessstringent_filteredSNPsonly_nearindelfilt.tab.gz \
# /scratch/aubaxh002_03b_noBQSR_genomicsdb/all_samples_nobaseQrecal_filtered_SNPs_only_less_stringent_nearindelfilt.vcf.gz 

## and with SNPs near indels filtered out, retaining only biallelic sites, and only sites 
## with <20% missing data
# bcftools roh \
# --threads 20 \
# -o all_samples_GTPL_AFest_roh_lessstringent_nearindelfilt_missdatafilt.txt \
# --AF-file freqs_lessstringent_filteredSNPsonly_nearindelfilt_missdatafilt.tab.gz \
# /scratch/aubaxh002_03b_noBQSR_genomicsdb/all_samples_nobaseQrecal_filtered_SNPs_only_less_stringent_nearindelfilt_missdatafilt.recode.vcf.gz 

# bcftools roh \
# --threads 20 \
# --GTs-only 30 \
# -o all_samples_GTonly_AFest_roh_lessstringent_nearindelfilt_missdatafilt.txt \
# --AF-file freqs_lessstringent_filteredSNPsonly_nearindelfilt_missdatafilt.tab.gz \
# /scratch/aubaxh002_03b_noBQSR_genomicsdb/all_samples_nobaseQrecal_filtered_SNPs_only_less_stringent_nearindelfilt_missdatafilt.recode.vcf.gz 

bcftools roh \
--threads 10 \
-o allsamps_het_filt_filtcontigs_LDpruned_GTPL.txt \
--AF-file freqs_allsamps_het_filt_filtcontigs_LDpruned.recode.tab.gz \
allsamps_LDpruned.vcf.gz

bcftools roh \
--threads 10 \
-o allsamps_het_filt_filtcontigs_LDpruned_MAF_GTPL.txt \
--AF-file freqs_allsamps_het_filt_filtcontigs_LDpruned_MAF.recode.tab.gz \
allsamps_het_filt_filtcontigs_LDpruned_MAF.05.recode.vcf.gz 

## --------------------------------
## Extract information on ROHs (i.e., exclude information on individual sites)
# grep "^RG" all_samples_GTPL_AFest_roh_lessstringent_nearindelfilt.txt >\
# all_samples_GTPL_AFest_roh_lessstringent_nearindelfilt_RG_ONLY.txt
# 
# grep "^RG" all_samples_GTonly_AFest_roh_lessstringent_nearindelfilt.txt >\
# all_samples_GTonly_AFest_roh_lessstringent_nearindelfilt_RG_ONLY.txt
# 
# grep "^RG" all_samples_GTPL_AFest_roh_lessstringent_nearindelfilt_missdatafilt.txt >\
# all_samples_GTPL_AFest_roh_lessstringent_nearindelfilt_missdatafilt_RG_ONLY.txt
# 
# grep "^RG" all_samples_GTonly_AFest_roh_lessstringent_nearindelfilt_missdatafilt.txt >\
# all_samples_GTonly_AFest_roh_lessstringent_nearindelfilt_missdatafilt_RG_ONLY.txt

grep "^RG" allsamps_het_filt_filtcontigs_LDpruned_GTPL.txt > \
allsamps_het_filt_filtcontigs_LDpruned_GTPL_RG_ONLY.txt

grep "^RG" allsamps_het_filt_filtcontigs_LDpruned_MAF_GTPL.txt > \
allsamps_het_filt_filtcontigs_LDpruned_MAF_GTPL_RG_ONLY.txt

mail -s 'BCFtools/ROH finished' avrilharder@gmail.com <<< 'BCFtools/ROH finished'




## --------------------------------
## bcftools roh details
## other info: https://samtools.github.io/bcftools/howtos/roh-calling.html
##
## About:   HMM model for detecting runs of autozygosity.
## Usage:   bcftools roh [options] <in.vcf.gz>
## 
## General Options:
##         --AF-dflt <float>              if AF is not known, use this allele frequency [skip]
##         --AF-tag <TAG>                 use TAG for allele frequency
##         --AF-file <file>               read allele frequencies from file (CHR\tPOS\tREF\tALT\tAF)
##     -b  --buffer-size <int[,int]>      buffer size and the number of overlapping sites, 0 for unlimited [0]
##                                            If the first number is negative, it is interpreted as the maximum memory to
##                                            use, in MB. The default overlap is set to roughly 1% of the buffer size.
##     -e, --estimate-AF [TAG],<file>     estimate AF from FORMAT/TAG (GT or PL) of all samples ("-") or samples listed
##                                             in <file>. If TAG is not given, the frequency is estimated from GT by default
##         --exclude <expr>               exclude sites for which the expression is true
##     -G, --GTs-only <float>             use GTs and ignore PLs, instead using <float> for PL of the two least likely genotypes.
##                                            Safe value to use is 30 to account for GT errors.
##         --include <expr>               select sites for which the expression is true
##     -i, --ignore-homref                skip hom-ref genotypes (0/0)
##     -I, --skip-indels                  skip indels as their genotypes are enriched for errors
##     -m, --genetic-map <file>           genetic map in IMPUTE2 format, single file or mask, where string "{CHROM}"
##                                            is replaced with chromosome name
##     -M, --rec-rate <float>             constant recombination rate per bp
##     -o, --output <file>                write output to a file [standard output]
##     -O, --output-type [srz]            output s:per-site, r:regions, z:compressed [sr]
##     -r, --regions <region>             restrict to comma-separated list of regions
##     -R, --regions-file <file>          restrict to regions listed in a file
##     -s, --samples <list>               list of samples to analyze [all samples]
##     -S, --samples-file <file>          file of samples to analyze [all samples]
##     -t, --targets <region>             similar to -r but streams rather than index-jumps
##     -T, --targets-file <file>          similar to -R but streams rather than index-jumps
##         --threads <int>                use multithreading with <int> worker threads [0]
## 
## HMM Options:
##     -a, --hw-to-az <float>             P(AZ|HW) transition probability from HW (Hardy-Weinberg) to AZ (autozygous) state [6.7e-8]
##     -H, --az-to-hw <float>             P(HW|AZ) transition probability from AZ to HW state [5e-9]
##     -V, --viterbi-training <float>     estimate HMM parameters, <float> is the convergence threshold, e.g. 1e-10 (experiment