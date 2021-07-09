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

## cd into working scratch directory
cd /scratch/aubaxh002_03b_noBQSR_genomicsdb/


## --------------------------------
## Load module 
module load bcftools/1.10.2

## bcftools stats details
# About:   Parses VCF or BCF and produces stats which can be plotted using plot-vcfstats.
#          When two files are given, the program generates separate stats for intersection
#          and the complements. By default only sites are compared, -s/-S must given to include
#          also sample columns.
# Usage:   bcftools stats [options] <A.vcf.gz> [<B.vcf.gz>]
# 
# Options:
#         --af-bins <list>               allele frequency bins, a list (0.1,0.5,1) or a file (0.1\n0.5\n1)
#         --af-tag <string>              allele frequency tag to use, by default estimated from AN,AC or GT
#     -1, --1st-allele-only              include only 1st allele at multiallelic sites
#     -c, --collapse <string>            treat as identical records with <snps|indels|both|all|some|none>, see man page for details [none]
#     -d, --depth <int,int,int>          depth distribution: min,max,bin size [0,500,1]
#     -e, --exclude <expr>               exclude sites for which the expression is true (see man page for details)
#     -E, --exons <file.gz>              tab-delimited file with exons for indel frameshifts (chr,from,to; 1-based, inclusive, bgzip compressed)
#     -f, --apply-filters <list>         require at least one of the listed FILTER strings (e.g. "PASS,.")
#     -F, --fasta-ref <file>             faidx indexed reference sequence file to determine INDEL context
#     -i, --include <expr>               select sites for which the expression is true (see man page for details)
#     -I, --split-by-ID                  collect stats for sites with ID separately (known vs novel)
#     -r, --regions <region>             restrict to comma-separated list of regions
#     -R, --regions-file <file>          restrict to regions listed in a file
#     -s, --samples <list>               list of samples for sample stats, "-" to include all samples
#     -S, --samples-file <file>          file of samples to include
#     -t, --targets <region>             similar to -r but streams rather than index-jumps
#     -T, --targets-file <file>          similar to -R but streams rather than index-jumps
#     -u, --user-tstv <TAG[:min:max:n]>  collect Ts/Tv stats for any tag using the given binning [0:1:100]
#         --threads <int>                use multithreading with <int> worker threads [0]
#     -v, --verbose                      produce verbose per-site and per-sample output

## --------------------------------
## Get VCF stats 

## SNPs filtered using more stringent criteria
bcftools stats --threads 20 \
--fasta-ref /scratch/aubaxh002_assem_indexing/hifiasm_kangaroo_rat_6cells.p_ctg.fasta \
--samples - \
all_samples_nobaseQrecal_filtered_SNPs_only.vcf.gz > more_stringent_vcf_stats.txt

## SNPs filtered using less stringent criteria
bcftools stats --threads 20 \
--fasta-ref /scratch/aubaxh002_assem_indexing/hifiasm_kangaroo_rat_6cells.p_ctg.fasta \
--samples - \
all_samples_nobaseQrecal_filtered_SNPs_only_less_stringent.vcf.gz > less_stringent_vcf_stats.txt
