#!/bin/bash
#
#   +-----------------------+
#   |  USE:                 |
#   |    - SMALL queue      |
#   |    - 1 CPU + def Gb   |
#   +-----------------------+
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
#  My preferred setup before running:
#    -- script to be run in /home/projectdir/scripts
#    -- project directory (of same name as script) in /home/
#    -- /input/ and /output/ subdirs within project dir

##  Set username
USER=aubaxh002

## Set project name
PROJ=08_rohan

## Create a directory on /scratch
mkdir /scratch/${USER}_${PROJ}/

## Set permissions for directory
chmod 700 /scratch/${USER}_${PROJ}/

##  Copy input files to scratch
cp /home/$USER/$PROJ/input/* /scratch/${USER}_${PROJ}/

## cd into working scratch directory
cd /scratch/${USER}_${PROJ}/


## --------------------------------
## Load modules
module load rohan


## --------------------------------
## Run ROHan on samples to estimate ROH and theta -- uses raw BAM files, which I have to 
## regenerate because fuck me



## --------------------------------
## Copy results back to project output directory (in home)
# cp allsamps_* /home/$USER/$PROJ/output/

mail -s 'ROHan finished' avrilharder@gmail.com <<< 'ROHan' finished'