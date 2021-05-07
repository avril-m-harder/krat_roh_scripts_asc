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
PROJ=nopurge_lastz

## Create a directory on /scratch
# mkdir /scratch/${USER}_${PROJ}/

## Set permissions for directory
# chmod 700 /scratch/${USER}_${PROJ}/

##  Copy input files to scratch
# cp /home/$USER/$PROJ/input/* /scratch/${USER}_${PROJ}/

## cd into working scratch directory
cd /scratch/${USER}_${PROJ}/


## --------------------------------
## Run the good stuff 

# module load lastz/1.04.00
module load mummer/3.22

## use perl script to keep only contigs with length >= 1 Mb
perl removesmalls.pl 1000000 hifiasm_kangaroo_rat_6cells_no_purge.p_ctg.fasta > \
nosmalls_hifiasm_kangaroo_rat_6cells_no_purge.p_ctg.fasta

## LASTZ
## align the larger, low-purge assembly against itself, discarding redundant matches
# lastz nosmalls_hifiasm_kangaroo_rat_6cells_no_purge.p_ctg.fasta \
# nosmalls_hifiasm_kangaroo_rat_6cells_no_purge.p_ctg.fasta \
# --action:target=multiple \
# --rdotplot=nosmalls_nopurge_lastz_rplot.txt \
# --format=general:nmismatch,name1,strand1,start1,end1,name2,strand2,start2,end2 > \
# nosmalls_nopurge_lastz_general.txt

## mummer
## align sequences
nucmer -p nucmer_out_nosmalls_nopurge \
nosmalls_hifiasm_kangaroo_rat_6cells_no_purge.p_ctg.fasta \
nosmalls_hifiasm_kangaroo_rat_6cells_no_purge.p_ctg.fasta

## convert output to something useful
show-coords -r -l nucmer_out_nosmalls_nopurge.delta > nucmer_out_nosmalls_nopurge.coords



## --------------------------------

## Copy results back to project output directory (in home)
# cp nosmalls_nopurge_lastz_rplot.txt /home/$USER/$PROJ/output/
# cp nosmalls_nopurge_lastz_general.txt /home/$USER/$PROJ/output/
cp nucmer_out_nosmalls_nopurge* /home/$USER/$PROJ/output/
