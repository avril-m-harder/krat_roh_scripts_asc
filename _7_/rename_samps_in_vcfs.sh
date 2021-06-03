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
#

##  Set username
USER=aubaxh002

## Set project name
PROJ=rename_samps

## Set batch group
GROUP=_7_

## cd into working scratch directory
cd /scratch/aubaxh002_03b_noBQSR_genomicsdb


## --------------------------------
## Load modules 
module load gatk/4.1.4.0
module load picard/1.79


## --------------------------------
## Correct sample names in VCF files because I did something dumb when renaming read groups :|
while read -a line
do

gatk RenameSampleInVcf \
	-I /scratch/aubaxh002_03a_preBQSR_snp_calling/${line[0]}_nobaseQrecal.g.vcf \
	-O sampfix_${line[0]}_nobaseQrecal.g.vcf \
	--NEW_SAMPLE_NAME ${line[0]}
	
done < /home/aubaxh002/sample_lists/_7_.txt
