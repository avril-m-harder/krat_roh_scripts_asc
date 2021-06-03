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
PROJ=04b_plink

## Create a directory on /scratch
mkdir /scratch/${USER}_${PROJ}/

## Set permissions for directory
chmod 700 /scratch/${USER}_${PROJ}/

##  Copy input files to scratch
cp /home/$USER/$PROJ/input/* /scratch/${USER}_${PROJ}/

## cd into working scratch directory
cd /scratch/${USER}_${PROJ}/


## --------------------------------
## Load module (if PLINK is installed?) 

module load samtools/1.11

samtools faidx hifiasm_kangaroo_rat_6cells_no_purge.p_ctg.fasta


## --------------------------------

## Copy results back to project output directory (in home)
cp hifiasm_kangaroo_rat_6cells_no_purge.p_ctg.fasta.fai /home/$USER/$PROJ/output/
