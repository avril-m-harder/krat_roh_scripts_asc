#!/bin/bash
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
#  My preferred setup before running:
#    -- script to be run in /home/scripts
#    -- project directory (of same name as script) in /home/
#    -- /input/ and /output/ subdirs within project dir

##  Set username
USER=aubaxh002

## Set project name
PROJ=03_variantcalling

## Set batch group
GROUP=_group_

##  Copy input files to scratch
# cp /home/$USER/$PROJ/input/* /scratch/${USER}_${PROJ}/

## cd into working scratch directory
cd /scratch/${USER}_${PROJ}/_group_


## --------------------------------
## Load modules 
module load gatk/4.1.4.0


## --------------------------------
## Genotype GVCFs across all samples simultaneously --
## Only analyzes variants on contigs of minimum length specified in contig filename
ref=/scratch/aubaxh002_assem_indexing/hifiasm_kangaroo_rat_6cells.p_ctg.fasta

while read -a line
do

gatk GenomicsDBImport \
	-V 3811_S67_nobaseQrecal.g.vcf \
	-V 3850_S45_nobaseQrecal.g.vcf \
	-V 3910_S63_nobaseQrecal.g.vcf \
	-V 4058_S46_nobaseQrecal.g.vcf \
	-V 4100_S68_nobaseQrecal.g.vcf \
	-V 4195_S23_nobaseQrecal.g.vcf \
	-V 4444_S24_nobaseQrecal.g.vcf \
	-V 4459_S64_nobaseQrecal.g.vcf \
	-V 4793_S47_nobaseQrecal.g.vcf \
	-V 4795_S25_nobaseQrecal.g.vcf \
	-V 4796_S26_nobaseQrecal.g.vcf \
	-V 4816_S27_nobaseQrecal.g.vcf \
	-V 4835_S56_nobaseQrecal.g.vcf \
	-V 4867_S65_nobaseQrecal.g.vcf \
	-V 4890_S48_nobaseQrecal.g.vcf \
	-V 4893_S49_nobaseQrecal.g.vcf \
	-V 4895_S57_nobaseQrecal.g.vcf \
	-V 4897_S28_nobaseQrecal.g.vcf \
	-V 4901_S29_nobaseQrecal.g.vcf \
	-V 4910_S50_nobaseQrecal.g.vcf \
	-V 4915_S51_nobaseQrecal.g.vcf \
	-V 4919_S30_nobaseQrecal.g.vcf \
	-V 4922_S58_nobaseQrecal.g.vcf \
	-V 4927_S59_nobaseQrecal.g.vcf \
	-V 4936_S31_nobaseQrecal.g.vcf \
	-V 4943_S32_nobaseQrecal.g.vcf \
	-V 4946_S33_nobaseQrecal.g.vcf \
	-V 4950_S66_nobaseQrecal.g.vcf \
	-V 4952_S34_nobaseQrecal.g.vcf \
	-V 4960_S60_nobaseQrecal.g.vcf \
	-V 4962_S52_nobaseQrecal.g.vcf \
	-V 4970_S61_nobaseQrecal.g.vcf \
	-V 4976_S53_nobaseQrecal.g.vcf \
	-V 5018_S35_nobaseQrecal.g.vcf \
	-V 5026_S62_nobaseQrecal.g.vcf \
	-V 5038_S36_nobaseQrecal.g.vcf \
	-V 5039_S37_nobaseQrecal.g.vcf \
	-V 5040_S54_nobaseQrecal.g.vcf \
	-V 5046_S38_nobaseQrecal.g.vcf \
	-V 5050_S39_nobaseQrecal.g.vcf \
	-V 5054_S55_nobaseQrecal.g.vcf \
	-V 5060_S40_nobaseQrecal.g.vcf \
	-V 5075_S41_nobaseQrecal.g.vcf \
	-V 5114_S42_nobaseQrecal.g.vcf \
	-V 5123_S43_nobaseQrecal.g.vcf \
	-V 545_S21_nobaseQrecal.g.vcf \
	-V 562_S44_nobaseQrecal.g.vcf \
	-V 572_S22_nobaseQrecal.g.vcf \
	--genomicsdb-workspace-path ${line[0]}_database_gatk_genomics \
	--intervals ${line[0]}

gatk GenotypeGVCFs \
	-R $ref \
	-V gendb://${line[0]}_database_gatk_genomics \
	-O ${line[0]}_genotype_output_nobaseQrecal.vcf
	
gatk SelectVariants \
	--select-type-to-include SNP \
	-R $ref \
	-V ${line[0]}_genotype_output_nobaseQrecal.vcf \
	-O ${line[0]}_genotype_output_nobaseQrecal_SNPs.vcf
	
gatk VariantFiltration \
	-R $ref \
	-V ${line[0]}_genotype_output_nobaseQrecal_SNPs.vcf
	-O ${line[0]}_genotype_output_nobaseQrecal_SNPs_filtered.vcf \
	--filter-name "QD" \
	--filter-expression "QD < 2.0" \
	--filter-name "FS" \
	--filter-expression "FS > 40.0" \
	--filter-name "SOR" \
	--filter-expression "SOR > 5.0" \
	--filter-name "MQ" \
	--filter-expression "MQ < 20.0" \
	--filter-name "MQRankSum" \
	--filter-expression " MQRankSum < -3.0 || MQRankSum > 3.0" \
	--filter-name "ReadPosRankSum" \
	--filter-expression "ReadPosRankSum < -8.0" \
	--filter-name "AN" \
	--filter-expression "AN < 130" 

done < /home/aubaxh002/krat_roh_scripts_asc/contigs_100kb.txt






