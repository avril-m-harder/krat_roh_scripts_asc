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
PROJ=03b_noBQSR_genomicsdb

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
	-V ../03a_preBQSR_snp_calling/3811_S67_nobaseQrecal.g.vcf \
	-V ../03a_preBQSR_snp_calling/3850_S45_nobaseQrecal.g.vcf \
	-V ../03a_preBQSR_snp_calling/3910_S63_nobaseQrecal.g.vcf \
	-V ../03a_preBQSR_snp_calling/4058_S46_nobaseQrecal.g.vcf \
	-V ../03a_preBQSR_snp_calling/4100_S68_nobaseQrecal.g.vcf \
	-V ../03a_preBQSR_snp_calling/4195_S23_nobaseQrecal.g.vcf \
	-V ../03a_preBQSR_snp_calling/4444_S24_nobaseQrecal.g.vcf \
	-V ../03a_preBQSR_snp_calling/4459_S64_nobaseQrecal.g.vcf \
	-V ../03a_preBQSR_snp_calling/4793_S47_nobaseQrecal.g.vcf \
	-V ../03a_preBQSR_snp_calling/4795_S25_nobaseQrecal.g.vcf \
	-V ../03a_preBQSR_snp_calling/4796_S26_nobaseQrecal.g.vcf \
	-V ../03a_preBQSR_snp_calling/4816_S27_nobaseQrecal.g.vcf \
	-V ../03a_preBQSR_snp_calling/4835_S56_nobaseQrecal.g.vcf \
	-V ../03a_preBQSR_snp_calling/4867_S65_nobaseQrecal.g.vcf \
	-V ../03a_preBQSR_snp_calling/4890_S48_nobaseQrecal.g.vcf \
	-V ../03a_preBQSR_snp_calling/4893_S49_nobaseQrecal.g.vcf \
	-V ../03a_preBQSR_snp_calling/4895_S57_nobaseQrecal.g.vcf \
	-V ../03a_preBQSR_snp_calling/4897_S28_nobaseQrecal.g.vcf \
	-V ../03a_preBQSR_snp_calling/4901_S29_nobaseQrecal.g.vcf \
	-V ../03a_preBQSR_snp_calling/4910_S50_nobaseQrecal.g.vcf \
	-V ../03a_preBQSR_snp_calling/4915_S51_nobaseQrecal.g.vcf \
	-V ../03a_preBQSR_snp_calling/4919_S30_nobaseQrecal.g.vcf \
	-V ../03a_preBQSR_snp_calling/4922_S58_nobaseQrecal.g.vcf \
	-V ../03a_preBQSR_snp_calling/4927_S59_nobaseQrecal.g.vcf \
	-V ../03a_preBQSR_snp_calling/4936_S31_nobaseQrecal.g.vcf \
	-V ../03a_preBQSR_snp_calling/4943_S32_nobaseQrecal.g.vcf \
	-V ../03a_preBQSR_snp_calling/4946_S33_nobaseQrecal.g.vcf \
	-V ../03a_preBQSR_snp_calling/4950_S66_nobaseQrecal.g.vcf \
	-V ../03a_preBQSR_snp_calling/4952_S34_nobaseQrecal.g.vcf \
	-V ../03a_preBQSR_snp_calling/4960_S60_nobaseQrecal.g.vcf \
	-V ../03a_preBQSR_snp_calling/4962_S52_nobaseQrecal.g.vcf \
	-V ../03a_preBQSR_snp_calling/4970_S61_nobaseQrecal.g.vcf \
	-V ../03a_preBQSR_snp_calling/4976_S53_nobaseQrecal.g.vcf \
	-V ../03a_preBQSR_snp_calling/5018_S35_nobaseQrecal.g.vcf \
	-V ../03a_preBQSR_snp_calling/5026_S62_nobaseQrecal.g.vcf \
	-V ../03a_preBQSR_snp_calling/5038_S36_nobaseQrecal.g.vcf \
	-V ../03a_preBQSR_snp_calling/5039_S37_nobaseQrecal.g.vcf \
	-V ../03a_preBQSR_snp_calling/5040_S54_nobaseQrecal.g.vcf \
	-V ../03a_preBQSR_snp_calling/5046_S38_nobaseQrecal.g.vcf \
	-V ../03a_preBQSR_snp_calling/5050_S39_nobaseQrecal.g.vcf \
	-V ../03a_preBQSR_snp_calling/5054_S55_nobaseQrecal.g.vcf \
	-V ../03a_preBQSR_snp_calling/5060_S40_nobaseQrecal.g.vcf \
	-V ../03a_preBQSR_snp_calling/5075_S41_nobaseQrecal.g.vcf \
	-V ../03a_preBQSR_snp_calling/5114_S42_nobaseQrecal.g.vcf \
	-V ../03a_preBQSR_snp_calling/5123_S43_nobaseQrecal.g.vcf \
	-V ../03a_preBQSR_snp_calling/545_S21_nobaseQrecal.g.vcf \
	-V ../03a_preBQSR_snp_calling/562_S44_nobaseQrecal.g.vcf \
	-V ../03a_preBQSR_snp_calling/572_S22_nobaseQrecal.g.vcf \
	--genomicsdb-workspace-path ${line[0]}_database_gatk_genomics \
	--intervals ${line[0]}

gatk GenotypeGVCFs \
	-R $ref \
	-V gendb://${line[0]}_database_gatk_genomics \
	-O ${line[0]}_genotype_output_nobaseQrecal.vcf
	
gatk VariantFiltration \
	-R $ref \
	-V ${line[0]}_genotype_output_nobaseQrecal.vcf
	-O ${line[0]}_genotype_output_nobaseQrecal_filtered.vcf \
	--filter-name "QD" \
	--filter-expression "QD < 2.0" \
	--filter-name "FS" \
	--filter-expression "FS > 5.0" \
	--filter-name "SOR" \
	--filter-expression "SOR > 5.0" \
	--filter-name "MQ" \
	--filter-expression "MQ < 60.0" \
	--filter-name "MQRankSum" \
	--filter-expression " MQRankSum < -3.0 || MQRankSum > 3.0" \
	--filter-name "ReadPosRankSum" \
	--filter-expression "ReadPosRankSum < -8.0"

## not removing filter-failing SNPs or indels for now -- will apply filters in R,
## may come back later and make sure outputs between filtering approaches match
# gatk SelectVariants \
# 	-R $ref \
# 	-V ${line[0]}_genotype_output_nobaseQrecal_filtered.vcf \
# 	--select-type-to-include SNP \
# 	-select 'vc.isNotFiltered()' \
# 	-O filtered_${line[0]}_nobaseQrecal_SNPs.vcf

done < /home/aubaxh002/krat_roh_scripts_asc/contigs_100kb.txt

## --------------------------------
## Make list file of VCFs to combine
ls *filtered.vcf > filtered_contig_vcf_files.list


## --------------------------------
## Combine filtered VCF files
gatk MergeVcfs \
	-I filtered_contig_vcf_files.list \
	-O all_samples_nobaseQrecal_filtered.vcf.gz






