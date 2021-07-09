#!/bin/bash
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
module load bcftools/1.10.2
module load samtools/1.11


## --------------------------------
## Correct sample names in VCF files because I did something dumb when renaming read 
## groups :| -- same command run in batches using makefile
# while read -a line
# do
# 
# gatk RenameSampleInVcf \
# 	-I /scratch/aubaxh002_03a_preBQSR_snp_calling/${line[0]}_nobaseQrecal.g.vcf \
# 	-O sampfix_${line[0]}_nobaseQrecal.g.vcf \
# 	--NEW_SAMPLE_NAME ${line[0]}
#
# gatk IndexFeatureFile -F sampfix_${line[0]}_nobaseQrecal.g.vcf
# 	
# done < /home/aubaxh002/krat_roh_scripts_asc/sample_list.txt


## --------------------------------
## Genotype GVCFs across all samples simultaneously --
## Only analyzes variants on contigs of minimum length specified in contig filename
ref=/scratch/aubaxh002_assem_indexing/hifiasm_kangaroo_rat_6cells.p_ctg.fasta

while read -a line
do

# gatk GenomicsDBImport \
# 	-V sampfix_3811_S67_nobaseQrecal.g.vcf \
# 	-V sampfix_3850_S45_nobaseQrecal.g.vcf \
# 	-V sampfix_3910_S63_nobaseQrecal.g.vcf \
# 	-V sampfix_4058_S46_nobaseQrecal.g.vcf \
# 	-V sampfix_4100_S68_nobaseQrecal.g.vcf \
# 	-V sampfix_4195_S23_nobaseQrecal.g.vcf \
# 	-V sampfix_4444_S24_nobaseQrecal.g.vcf \
# 	-V sampfix_4459_S64_nobaseQrecal.g.vcf \
# 	-V sampfix_4793_S47_nobaseQrecal.g.vcf \
# 	-V sampfix_4795_S25_nobaseQrecal.g.vcf \
# 	-V sampfix_4796_S26_nobaseQrecal.g.vcf \
# 	-V sampfix_4816_S27_nobaseQrecal.g.vcf \
# 	-V sampfix_4835_S56_nobaseQrecal.g.vcf \
# 	-V sampfix_4867_S65_nobaseQrecal.g.vcf \
# 	-V sampfix_4890_S48_nobaseQrecal.g.vcf \
# 	-V sampfix_4893_S49_nobaseQrecal.g.vcf \
# 	-V sampfix_4895_S57_nobaseQrecal.g.vcf \
# 	-V sampfix_4897_S28_nobaseQrecal.g.vcf \
# 	-V sampfix_4901_S29_nobaseQrecal.g.vcf \
# 	-V sampfix_4910_S50_nobaseQrecal.g.vcf \
# 	-V sampfix_4915_S51_nobaseQrecal.g.vcf \
# 	-V sampfix_4919_S30_nobaseQrecal.g.vcf \
# 	-V sampfix_4922_S58_nobaseQrecal.g.vcf \
# 	-V sampfix_4927_S59_nobaseQrecal.g.vcf \
# 	-V sampfix_4936_S31_nobaseQrecal.g.vcf \
# 	-V sampfix_4943_S32_nobaseQrecal.g.vcf \
# 	-V sampfix_4946_S33_nobaseQrecal.g.vcf \
# 	-V sampfix_4950_S66_nobaseQrecal.g.vcf \
# 	-V sampfix_4952_S34_nobaseQrecal.g.vcf \
# 	-V sampfix_4960_S60_nobaseQrecal.g.vcf \
# 	-V sampfix_4962_S52_nobaseQrecal.g.vcf \
# 	-V sampfix_4970_S61_nobaseQrecal.g.vcf \
# 	-V sampfix_4976_S53_nobaseQrecal.g.vcf \
# 	-V sampfix_5018_S35_nobaseQrecal.g.vcf \
# 	-V sampfix_5026_S62_nobaseQrecal.g.vcf \
# 	-V sampfix_5038_S36_nobaseQrecal.g.vcf \
# 	-V sampfix_5039_S37_nobaseQrecal.g.vcf \
# 	-V sampfix_5040_S54_nobaseQrecal.g.vcf \
# 	-V sampfix_5046_S38_nobaseQrecal.g.vcf \
# 	-V sampfix_5050_S39_nobaseQrecal.g.vcf \
# 	-V sampfix_5054_S55_nobaseQrecal.g.vcf \
# 	-V sampfix_5060_S40_nobaseQrecal.g.vcf \
# 	-V sampfix_5075_S41_nobaseQrecal.g.vcf \
# 	-V sampfix_5114_S42_nobaseQrecal.g.vcf \
# 	-V sampfix_5123_S43_nobaseQrecal.g.vcf \
# 	-V sampfix_545_S21_nobaseQrecal.g.vcf \
# 	-V sampfix_562_S44_nobaseQrecal.g.vcf \
# 	-V sampfix_572_S22_nobaseQrecal.g.vcf \
# 	--genomicsdb-workspace-path ${line[0]}_database_gatk_genomics \
# 	--intervals ${line[0]}
# 
# gatk GenotypeGVCFs \
# 	-R $ref \
# 	-V gendb://${line[0]}_database_gatk_genomics \
# 	-O ${line[0]}_genotype_output_nobaseQrecal.vcf
# 	
# gatk VariantFiltration \
# 	-R $ref \
# 	-V ${line[0]}_genotype_output_nobaseQrecal.vcf \
# 	-O ${line[0]}_genotype_output_nobaseQrecal_filtered.vcf \
# 	--filter-name "QD" \
# 	--filter-expression "QD < 2.0" \
# 	--filter-name "FS" \
# 	--filter-expression "FS > 5.0" \
# 	--filter-name "SOR" \
# 	--filter-expression "SOR > 5.0" \
# 	--filter-name "MQ" \
# 	--filter-expression "MQ < 60.0" \
# 	--filter-name "MQRankSum" \
# 	--filter-expression " MQRankSum < -3.0 || MQRankSum > 3.0" \
# 	--filter-name "ReadPosRankSum" \
# 	--filter-expression "ReadPosRankSum < -8.0"

## pretty stringent filtering criteria I think? another set of criteria is below
# gatk SelectVariants \
# 	-R $ref \
# 	-V ${line[0]}_genotype_output_nobaseQrecal_filtered.vcf \
# 	--select-type-to-include SNP \
# 	-select 'vc.isNotFiltered()' \
# 	-O filtered_${line[0]}_nobaseQrecal_SNPs.vcf
# 
# echo ${line[0]} >> done_contigs.txt


## --------------------------------
## A second set of less stringent criteria
# gatk VariantFiltration \
# 	-R $ref \
# 	-V ${line[0]}_genotype_output_nobaseQrecal.vcf \
# 	-O ${line[0]}_genotype_output_nobaseQrecal_filtered_less_stringent.vcf \
# 	--filter-name "QD" \
# 	--filter-expression "QD < 2.0" \
# 	--filter-name "FS" \
# 	--filter-expression "FS > 40.0" \
# 	--filter-name "SOR" \
# 	--filter-expression "SOR > 5.0" \
# 	--filter-name "MQ" \
# 	--filter-expression "MQ < 20.0" \
# 	--filter-name "MQRankSum" \
# 	--filter-expression " MQRankSum < -3.0 || MQRankSum > 3.0" \
# 	--filter-name "ReadPosRankSum" \
# 	--filter-expression "ReadPosRankSum < -8.0"

# gatk SelectVariants \
# 	-R $ref \
# 	-V ${line[0]}_genotype_output_nobaseQrecal_filtered_less_stringent.vcf \
# 	--select-type-to-include SNP \
# 	-select 'vc.isNotFiltered()' \
# 	-O filtered_${line[0]}_nobaseQrecal_SNPs_less_stringent.vcf


## --------------------------------
## Creating another set of VCF files with less stringent filtering, removing SNPs within 5
## bp of indels using bcftools before retaining only SNPs with SelectVariants
bcftools filter --SnpGap 5 \
--threads 4 \
-o ${line[0]}_genotype_output_nobaseQrecal_filtered_less_stringent_nearindelfilt.vcf \
./less_stringent_flagged/${line[0]}_genotype_output_nobaseQrecal_filtered_less_stringent.vcf

gatk SelectVariants \
	-R $ref \
	-V ${line[0]}_genotype_output_nobaseQrecal_filtered_less_stringent_nearindelfilt.vcf \
	--select-type-to-include SNP \
	-select 'vc.isNotFiltered()' \
	-restrict-alleles-to BIALLELIC \
	-O filtered_${line[0]}_nobaseQrecal_SNPs_less_stringent_nearindelfilt.vcf

echo ${line[0]} >> round2_done_contigs.txt

done < /home/aubaxh002/100kb_contig_lists/_c1_.txt

