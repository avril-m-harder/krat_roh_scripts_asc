#!/bin/bash
#
#  +-------------+
#  | NOT BATCHED |
#  +-------------+
#
#  +----------------------+
#  | REQUEST 4 CPU + 60gb |
#  +----------------------+
#
#  Replace the USER name in this script with your username and
#  call your project whatever you want
#
#  This script must be made executable like this
#    chmod +x my_script
#
#  Submit this script to the queue with a command like this
#    run_script_scratch my_script.sh
#

##  Set username
USER=aubaxh002

## Set project name
PROJ=03b_genomicsdb

## Create a directory on /scratch
mkdir /scratch/${USER}_${PROJ}/

## Set permissions for directory
chmod 700 /scratch/${USER}_${PROJ}/

## cd into working scratch directory
cd /scratch/${USER}_${PROJ}/


## --------------------------------
## Load modules 
module load gatk/4.1.4.0
module load picard/1.79

## --------------------------------
## Genotype GVCFs across all samples simultaneously --
## Only analyzes variants on contigs of minimum length specified in contig filename
ref=/scratch/aubaxh002_assem_indexing/hifiasm_kangaroo_rat_6cells.p_ctg.fasta

while read -a line
do

gatk GenomicsDBImport \
	-V ../03d_postBQSR_snp_calling/3811_S67_recal2.g.vcf \
	-V ../03d_postBQSR_snp_calling/3850_S45_recal2.g.vcf \
	-V ../03d_postBQSR_snp_calling/3910_S63_recal2.g.vcf \
	-V ../03d_postBQSR_snp_calling/4058_S46_recal2.g.vcf \
	-V ../03d_postBQSR_snp_calling/4100_S68_recal2.g.vcf \
	-V ../03d_postBQSR_snp_calling/4195_S23_recal2.g.vcf \
	-V ../03d_postBQSR_snp_calling/4444_S24_recal2.g.vcf \
	-V ../03d_postBQSR_snp_calling/4459_S64_recal2.g.vcf \
	-V ../03d_postBQSR_snp_calling/4793_S47_recal2.g.vcf \
	-V ../03d_postBQSR_snp_calling/4795_S25_recal2.g.vcf \
	-V ../03d_postBQSR_snp_calling/4796_S26_recal2.g.vcf \
	-V ../03d_postBQSR_snp_calling/4816_S27_recal2.g.vcf \
	-V ../03d_postBQSR_snp_calling/4835_S56_recal2.g.vcf \
	-V ../03d_postBQSR_snp_calling/4867_S65_recal2.g.vcf \
	-V ../03d_postBQSR_snp_calling/4890_S48_recal2.g.vcf \
	-V ../03d_postBQSR_snp_calling/4893_S49_recal2.g.vcf \
	-V ../03d_postBQSR_snp_calling/4895_S57_recal2.g.vcf \
	-V ../03d_postBQSR_snp_calling/4897_S28_recal2.g.vcf \
	-V ../03d_postBQSR_snp_calling/4901_S29_recal2.g.vcf \
	-V ../03d_postBQSR_snp_calling/4910_S50_recal2.g.vcf \
	-V ../03d_postBQSR_snp_calling/4915_S51_recal2.g.vcf \
	-V ../03d_postBQSR_snp_calling/4919_S30_recal2.g.vcf \
	-V ../03d_postBQSR_snp_calling/4922_S58_recal2.g.vcf \
	-V ../03d_postBQSR_snp_calling/4927_S59_recal2.g.vcf \
	-V ../03d_postBQSR_snp_calling/4936_S31_recal2.g.vcf \
	-V ../03d_postBQSR_snp_calling/4943_S32_recal2.g.vcf \
	-V ../03d_postBQSR_snp_calling/4946_S33_recal2.g.vcf \
	-V ../03d_postBQSR_snp_calling/4950_S66_recal2.g.vcf \
	-V ../03d_postBQSR_snp_calling/4952_S34_recal2.g.vcf \
	-V ../03d_postBQSR_snp_calling/4960_S60_recal2.g.vcf \
	-V ../03d_postBQSR_snp_calling/4962_S52_recal2.g.vcf \
	-V ../03d_postBQSR_snp_calling/4970_S61_recal2.g.vcf \
	-V ../03d_postBQSR_snp_calling/4976_S53_recal2.g.vcf \
	-V ../03d_postBQSR_snp_calling/5018_S35_recal2.g.vcf \
	-V ../03d_postBQSR_snp_calling/5026_S62_recal2.g.vcf \
	-V ../03d_postBQSR_snp_calling/5038_S36_recal2.g.vcf \
	-V ../03d_postBQSR_snp_calling/5039_S37_recal2.g.vcf \
	-V ../03d_postBQSR_snp_calling/5040_S54_recal2.g.vcf \
	-V ../03d_postBQSR_snp_calling/5046_S38_recal2.g.vcf \
	-V ../03d_postBQSR_snp_calling/5050_S39_recal2.g.vcf \
	-V ../03d_postBQSR_snp_calling/5054_S55_recal2.g.vcf \
	-V ../03d_postBQSR_snp_calling/5060_S40_recal2.g.vcf \
	-V ../03d_postBQSR_snp_calling/5075_S41_recal2.g.vcf \
	-V ../03d_postBQSR_snp_calling/5114_S42_recal2.g.vcf \
	-V ../03d_postBQSR_snp_calling/5123_S43_recal2.g.vcf \
	-V ../03d_postBQSR_snp_calling/545_S21_recal2.g.vcf \
	-V ../03d_postBQSR_snp_calling/562_S44_recal2.g.vcf \
	-V ../03d_postBQSR_snp_calling/572_S22_recal2.g.vcf \
	--genomicsdb-workspace-path ${line[0]}_database_gatk_genomics \
	--intervals ${line[0]}

gatk GenotypeGVCFs \
	-R $ref \
	-V gendb://${line[0]}_database_gatk_genomics \
	-O ${line[0]}_genotype_output_recal2.vcf
	
gatk VariantFiltration \
	-R $ref \
	-V ${line[0]}_genotype_output_recal2.vcf
	-O ${line[0]}_genotype_output_recal2_filtered.vcf \
	--filter-name "QD" \
	--filter-expression "QD < 2.0" \
	--filter-name "FS" \
	--filter-expression "FS > 20.0" \
	--filter-name "SOR" \
	--filter-expression "SOR > 5.0" \
	--filter-name "MQ" \
	--filter-expression "MQ < 20.0" \
	--filter-name "MQRankSum" \
	--filter-expression " MQRankSum < -3.0 || MQRankSum > 3.0" \
	--filter-name "ReadPosRankSum" \
	--filter-expression "ReadPosRankSum < -8.0"

gatk SelectVariants \
	-R $ref \
	-V ${line[0]}_genotype_output_recal2_filtered.vcf \
	--select-type-to-include SNP \
	-select 'vc.isNotFiltered()' \
	-O all_sites_${line[0]}_recal2_SNPs.vcf

done < /home/aubaxh002/krat_roh_scripts_asc/contigs_100kb.txt


## --------------------------------
## Combine VCF files
gatk MergeVcfs \
	-I all_sites_3811_S67_recal2_SNPs.vcf \
	-I all_sites_3850_S45_recal2_SNPs.vcf \
	-I all_sites_3910_S63_recal2_SNPs.vcf \
	-I all_sites_4058_S46_recal2_SNPs.vcf \
	-I all_sites_4100_S68_recal2_SNPs.vcf \
	-I all_sites_4195_S23_recal2_SNPs.vcf \
	-I all_sites_4444_S24_recal2_SNPs.vcf \
	-I all_sites_4459_S64_recal2_SNPs.vcf \
	-I all_sites_4793_S47_recal2_SNPs.vcf \
	-I all_sites_4795_S25_recal2_SNPs.vcf \
	-I all_sites_4796_S26_recal2_SNPs.vcf \
	-I all_sites_4816_S27_recal2_SNPs.vcf \
	-I all_sites_4835_S56_recal2_SNPs.vcf \
	-I all_sites_4867_S65_recal2_SNPs.vcf \
	-I all_sites_4890_S48_recal2_SNPs.vcf \
	-I all_sites_4893_S49_recal2_SNPs.vcf \
	-I all_sites_4895_S57_recal2_SNPs.vcf \
	-I all_sites_4897_S28_recal2_SNPs.vcf \
	-I all_sites_4901_S29_recal2_SNPs.vcf \
	-I all_sites_4910_S50_recal2_SNPs.vcf \
	-I all_sites_4915_S51_recal2_SNPs.vcf \
	-I all_sites_4919_S30_recal2_SNPs.vcf \
	-I all_sites_4922_S58_recal2_SNPs.vcf \
	-I all_sites_4927_S59_recal2_SNPs.vcf \
	-I all_sites_4936_S31_recal2_SNPs.vcf \
	-I all_sites_4943_S32_recal2_SNPs.vcf \
	-I all_sites_4946_S33_recal2_SNPs.vcf \
	-I all_sites_4950_S66_recal2_SNPs.vcf \
	-I all_sites_4952_S34_recal2_SNPs.vcf \
	-I all_sites_4960_S60_recal2_SNPs.vcf \
	-I all_sites_4962_S52_recal2_SNPs.vcf \
	-I all_sites_4970_S61_recal2_SNPs.vcf \
	-I all_sites_4976_S53_recal2_SNPs.vcf \
	-I all_sites_5018_S35_recal2_SNPs.vcf \
	-I all_sites_5026_S62_recal2_SNPs.vcf \
	-I all_sites_5038_S36_recal2_SNPs.vcf \
	-I all_sites_5039_S37_recal2_SNPs.vcf \
	-I all_sites_5040_S54_recal2_SNPs.vcf \
	-I all_sites_5046_S38_recal2_SNPs.vcf \
	-I all_sites_5050_S39_recal2_SNPs.vcf \
	-I all_sites_5054_S55_recal2_SNPs.vcf \
	-I all_sites_5060_S40_recal2_SNPs.vcf \
	-I all_sites_5075_S41_recal2_SNPs.vcf \
	-I all_sites_5114_S42_recal2_SNPs.vcf \
	-I all_sites_5123_S43_recal2_SNPs.vcf \
	-I all_sites_545_S21_recal2_SNPs.vcf \
	-I all_sites_562_S44_recal2_SNPs.vcf \
	-I all_sites_572_S22_recal2_SNPs.vcf \
	-O all_samples_all_sites_recal2_SNPs.vcf






