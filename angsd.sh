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
PROJ=angsd


#### IF aubaxh002_angsd DIRECTORY HAS BEEN DELETED ####
## Create a directory on /scratch
# mkdir /scratch/${USER}_${PROJ}/

## Set permissions for directory
# chmod 700 /scratch/${USER}_${PROJ}/

## cd into working scratch directory
# cd /scratch/${USER}_${PROJ}/

## download and install htslib, ANGSD
# git clone https://github.com/samtools/htslib.git
# git clone https://github.com/angsd/angsd.git
# cd htslib
# git submodule update --init --recursive
# make
# cd ../angsd
# make HTSSRC=../htslib


#### IF ALREADY DOWNLOADED ####
## cd into working scratch directory
cd /scratch/${USER}_${PROJ}/


## --------------------------------
##



## --------------------------------
## Copy results back to project output directory (in home)

