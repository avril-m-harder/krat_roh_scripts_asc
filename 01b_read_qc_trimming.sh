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
PROJ=01_read_qc_trimming

## Set batch group
GROUP=_group_

## Create a directory on /scratch
# mkdir /scratch/${USER}_${PROJ}/_group_

## Set permissions for directory
chmod 700 /scratch/${USER}_${PROJ}/_group_

##  Move unzipped fastq files to  dir to process
# while read -a line
# do
# 	cp /home/aubaxh002/reseq_data/Willoughby_krat.202233/${line[0]}*.fastq.gz \
# 	/scratch/${USER}_${PROJ}/_group_/
# done < /home/aubaxh002/krat_roh_analyses/preSNPcall_sample_lists/_group_.txt

## cd into working scratch directory
cd /scratch/${USER}_${PROJ}/_group_/


## --------------------------------
## Load modules 
module load trimgalore/0.6.6
module load fastqc/0.11.9

# mkdir pretrim_output/
mkdir posttrim_output/
# mkdir stdouts/
# 
# ## Run fastqc on all 4 read files per sample
# while read -a line
# do
# 	fastqc -t 4 -o pretrim_output/ \
# 	${line[0]}_L002_R1_001.fastq.gz\
# 	${line[0]}_L002_R2_001.fastq.gz
# done < /home/aubaxh002/krat_roh_analyses/preSNPcall_sample_lists/_group_.txt
# 
# cp pretrim_output/* /home/aubaxh002/krat_roh_analyses/01_read_qc_trimming/pretrim_fastqc/

## Run TrimGalore to clean and trim adapters from reads,
## then run FastQC on the trimmed files
while read -a line
do
	
	trim_galore --paired --quality 20 --phred33 \
	--fastqc_args "--outdir posttrim_output/" \
	--length 30 \
	${line[0]}_L002_R1_001.fastq.gz \
	${line[0]}_L002_R2_001.fastq.gz

done < /home/aubaxh002/krat_roh_analyses/preSNPcall_sample_lists/_group_.txt

cp posttrim_output/* /home/aubaxh002/krat_roh_analyses/01_read_qc_trimming/posttrim_fastqc/
mv *.i* stdouts/
mv *.o* stdouts/

## --------------------------------
## Copy results back to project output directory (in home)
# cp /scratch/${USER}_${PROJ}/_group_/output/* /home/$USER/$PROJ/output/

# mail -s 'QC + trim finished - _group_' avrilharder@gmail.com <<< 'QC + trim finished - _group_'
