#!/bin/bash
#
#  +-------------------------------------+
#  | QUEUE: MEDIUM -- CPU: 4 -- MEM 16GB |
#  +-------------------------------------+
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


#### Link to Qualimap command line overview:
## http://qualimap.conesalab.org/doc_html/command_line.html#multi-sample-bam-qc


##  Set username
USER=aubaxh002

## Set project name
PROJ=qualimap

#### IF aubaxh002_qualimap DIRECTORY HAS BEEN DELETED ####
## Create a directory on /scratch
# mkdir /scratch/${USER}_${PROJ}/
# 
# ## Set permissions for directory
# chmod 700 /scratch/${USER}_${PROJ}/
# 
# ## cd into working scratch directory
# cd /scratch/${USER}_${PROJ}/
# 
# ## download and unzip qualimap
# wget https://bitbucket.org/kokonech/qualimap/downloads/qualimap_v2.2.1.zip
# unzip qualimap_v2.2.1.zip
# cd qualimap_v2.2.1/


## First run only: unzip BAM files
# cd /home/aubaxh002/03_snp_calling/input/
# gunzip *.gz


#### IF ALREADY DOWNLOADED ####
## cd into working scratch directory
cd /scratch/${USER}_${PROJ}/qualimap_v2.2.1/

## --------------------------------
## Load modules
module load R


## --------------------------------
## First run only: unzip BAM files
# cd /home/aubaxh002/03_snp_calling/input/
# gunzip *.gz

# cd /scratch/${USER}_${PROJ}/qualimap_v2.2.1/


## --------------------------------
## Run Qualimap in Multi-sample BAM QC mode, providing raw BAM files
# qualimap multi-bamqc -d /home/aubaxh002/qualimap/qualimap_bam_files_01.txt \
# --run-bamqc \
# --java-mem-size=16G \
# --paint-chromosome-limits \
# -outformat PDF \
# -outfile multibamqc_report_01.pdf


## --------------------------------
## Run Qualimap in Multi-sample BAM QC mode, providing Qualimap output directories
## PDF output
# qualimap multi-bamqc -d /home/aubaxh002/qualimap/qualimap_stats_files_01.txt \
# --java-mem-size=16G \
# --paint-chromosome-limits \
# -outformat PDF \
# -outfile multibamqc_report_01.pdf

## HTML output
qualimap multi-bamqc -d /home/aubaxh002/qualimap/qualimap_stats_files_01.txt \
--java-mem-size=16G \
--paint-chromosome-limits \
-outformat HTML \
-outdir multibamqc_report_01
