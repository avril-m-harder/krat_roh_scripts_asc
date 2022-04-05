#!/bin/bash
#
#  +-----------------+
#  | REQUIRES 10 CPU |
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
mkdir /scratch/${USER}_${PROJ}/

## Set permissions for directory
chmod 700 /scratch/${USER}_${PROJ}/

## cd into working scratch directory
cd /scratch/${USER}_${PROJ}/

## copy input file
cp /home/aubaxh002/03_snp_calling/output/all_samples_nobaseQrecal_filtered_SNPs_only_less_stringent_nearindelfilt_missdatafilt.recode.vcf.gz all_samples_most_filtered.recode.vcf.gz
gunzip all_samples_most_filtered.recode.vcf.gz

## --------------------------------
## Load modules
module load bcftools/1.10.2
module load samtools/1.11


## --------------------------------
## Replace all genotypes with 0|0
sed -r 's/0\/1/0\|0/g' all_samples_most_filtered.recode.vcf > all_samples_most_filtered_custom_homozygous.recode.vcf
sed -r -i 's/1\/1/0\|0/g' all_samples_most_filtered_custom_homozygous.recode.vcf
sed -r -i 's/\.\/\./0\|0/g' all_samples_most_filtered_custom_homozygous.recode.vcf
sed -r -i 's/0\|1/0\|0/g' all_samples_most_filtered_custom_homozygous.recode.vcf
sed -r -i 's/1\|1/0\|0/g' all_samples_most_filtered_custom_homozygous.recode.vcf

gzip -c all_samples_most_filtered_custom_homozygous.recode.vcf > \
all_samples_most_filtered_custom_homozygous.recode.vcf.gz


## --------------------------------
## Copy allele frequency file (built for original, unchanged VCF file)
cp /home/aubaxh002/04_roh_analysis/input/freqs_lessstringent_filteredSNPsonly_nearindelfilt_missdatafilt.tab.gz* .


## --------------------------------
## Call ROHs in custom homozygous samples with same AF file used for original population
## and with GTs only (no likelihoods)

bcftools roh \
--threads 10 \
--GTs-only 30 \
-o GTsonly_custom_homozygous_ROHs.txt \
--AF-file freqs_lessstringent_filteredSNPsonly_nearindelfilt_missdatafilt.tab.gz \
all_samples_most_filtered_custom_homozygous.recode.vcf.gz

## --------------------------------
## Call ROHs in custom homozygous samples with same AF file used for original population
## and using original likelihoods

bcftools roh \
--threads 10 \
-o GTPL_custom_homozygous_ROHs.txt \
--AF-file freqs_lessstringent_filteredSNPsonly_nearindelfilt_missdatafilt.tab.gz \
all_samples_most_filtered_custom_homozygous.recode.vcf.gz


## --------------------------------
## Extract information on ROHs (i.e., exclude information on individual sites)
grep "^RG" GTsonly_custom_homozygous_ROHs.txt > GTsonly_custom_homozygous_ROHs_RG_ONLY.txt
grep "^RG" GTPL_custom_homozygous_ROHs.txt > GTPL_custom_homozygous_ROHs_RG_ONLY.txt


## --------------------------------
## Copy back to home directory
cp GTsonly_custom_homozygous_ROHs.txt /home/aubaxh002/04_roh_analysis/output
cp GTPL_custom_homozygous_ROHs.txt /home/aubaxh002/04_roh_analysis/output

cp GTsonly_custom_homozygous_ROHs_RG_ONLY.txt /home/aubaxh002/04_roh_analysis/output
cp GTPL_custom_homozygous_ROHs_RG_ONLY.txt /home/aubaxh002/04_roh_analysis/output


## <>-----<>-----<>-----<>-----<>-----<>-----<>-----<>-----<>-----<>-----<>-----<>-----<>-
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
##     -V, --viterbi-training <float>     estimate HMM parameters, <float> is the convergence threshold, e.g. 1e-10 (experimental)