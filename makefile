# Makefile
# Date: 4/2/2015 - Created by Mark Christie
# set paths, directories, and filenames

# JW update:14 Oct 2015; AH update for ASC: 29 Apr 2021

## Script for Duke samples
FILE1 = 01a_read_qc_trimming.sh

## Script for U of I samples
FILE2 = 01b_read_qc_trimming.sh

## Set project name
USER = aubaxh002
PROJ = 01_read_qc_trimming

## Set dir names
HOMEDIR = /home/aubaxh002/krat_roh_analyses/scripts
SCRATCHDIR = /scratch/${USER}_${PROJ}

## Each directory will only contain the scripts used to process that particular
## group of samples. Scripts will be held in /home/, data will be processed in /scratch/.
DIRECTORY1 = 01
DIRECTORY2 = 02
DIRECTORY3 = 03
DIRECTORY4 = 04
DIRECTORY5 = 05
DIRECTORY6 = 06
DIRECTORY7 = 07
DIRECTORY8 = 08
DIRECTORY9 = 09
DIRECTORY10 = 10
DIRECTORY11 = 11
DIRECTORY12 = 12
DIRECTORY13 = 13
DIRECTORY14 = 14
DIRECTORY15 = 15
DIRECTORY16 = 16
DIRECTORY17 = 17
DIRECTORY18 = 18

all:
	@echo "Please type....."
	@echo "    make directories"
	@echo "    make scripts"
	@echo "    make setgroup"
	@echo "    make prep"
	
directories:
	@echo "Here we go directories"
	mkdir $(SCRATCHDIR)
	mkdir $(SCRATCHDIR)/$(DIRECTORY1)
	mkdir $(SCRATCHDIR)/$(DIRECTORY2)
	mkdir $(SCRATCHDIR)/$(DIRECTORY3)
	mkdir $(SCRATCHDIR)/$(DIRECTORY4)
	mkdir $(SCRATCHDIR)/$(DIRECTORY5)
	mkdir $(SCRATCHDIR)/$(DIRECTORY6)
	mkdir $(SCRATCHDIR)/$(DIRECTORY7)
	mkdir $(SCRATCHDIR)/$(DIRECTORY8)
	mkdir $(SCRATCHDIR)/$(DIRECTORY9)
	mkdir $(SCRATCHDIR)/$(DIRECTORY10)
	mkdir $(SCRATCHDIR)/$(DIRECTORY11)
	mkdir $(SCRATCHDIR)/$(DIRECTORY12)
	mkdir $(SCRATCHDIR)/$(DIRECTORY13)
	mkdir $(SCRATCHDIR)/$(DIRECTORY14)
	mkdir $(SCRATCHDIR)/$(DIRECTORY15)
	mkdir $(SCRATCHDIR)/$(DIRECTORY16)
	mkdir $(SCRATCHDIR)/$(DIRECTORY17)
	mkdir $(SCRATCHDIR)/$(DIRECTORY18)
	cp $(HOMEDIR)/submit_jobs.sh $(SCRATCHDIR)/
	
scripts:
	@echo "Here we go write scripts and set queue prefs"
	cp -r /home/aubaxh002/krat_roh_analyses/queue_setting_files/$(PROJ)_asc_queue.txt \
	/home/aubaxh002/.asc_queue
	
	cp -r $(HOMEDIR)/$(FILE1) $(SCRATCHDIR)/$(DIRECTORY1)/$(FILE1)
	cp -r $(HOMEDIR)/$(FILE1) $(SCRATCHDIR)/$(DIRECTORY2)/$(FILE1)
	cp -r $(HOMEDIR)/$(FILE1) $(SCRATCHDIR)/$(DIRECTORY3)/$(FILE1)
	cp -r $(HOMEDIR)/$(FILE1) $(SCRATCHDIR)/$(DIRECTORY4)/$(FILE1)
	cp -r $(HOMEDIR)/$(FILE1) $(SCRATCHDIR)/$(DIRECTORY5)/$(FILE1)
	cp -r $(HOMEDIR)/$(FILE1) $(SCRATCHDIR)/$(DIRECTORY6)/$(FILE1)
	cp -r $(HOMEDIR)/$(FILE1) $(SCRATCHDIR)/$(DIRECTORY7)/$(FILE1)
	cp -r $(HOMEDIR)/$(FILE1) $(SCRATCHDIR)/$(DIRECTORY8)/$(FILE1)
	cp -r $(HOMEDIR)/$(FILE1) $(SCRATCHDIR)/$(DIRECTORY9)/$(FILE1)
	cp -r $(HOMEDIR)/$(FILE1) $(SCRATCHDIR)/$(DIRECTORY10)/$(FILE1)
	cp -r $(HOMEDIR)/$(FILE1) $(SCRATCHDIR)/$(DIRECTORY11)/$(FILE1)
	cp -r $(HOMEDIR)/$(FILE1) $(SCRATCHDIR)/$(DIRECTORY12)/$(FILE1)
	cp -r $(HOMEDIR)/$(FILE1) $(SCRATCHDIR)/$(DIRECTORY13)/$(FILE1)
	cp -r $(HOMEDIR)/$(FILE1) $(SCRATCHDIR)/$(DIRECTORY14)/$(FILE1)
	cp -r $(HOMEDIR)/$(FILE1) $(SCRATCHDIR)/$(DIRECTORY15)/$(FILE1)
	cp -r $(HOMEDIR)/$(FILE1) $(SCRATCHDIR)/$(DIRECTORY16)/$(FILE1)
	cp -r $(HOMEDIR)/$(FILE2) $(SCRATCHDIR)/$(DIRECTORY17)/$(FILE2)
	cp -r $(HOMEDIR)/$(FILE2) $(SCRATCHDIR)/$(DIRECTORY18)/$(FILE2)		

setgroup:
	@echo "Here we go set groups"
	sed -i 's/_group_/$(DIRECTORY1)/g' $(SCRATCHDIR)/$(DIRECTORY1)/$(FILE1)
	sed -i 's/_group_/$(DIRECTORY2)/g' $(SCRATCHDIR)/$(DIRECTORY2)/$(FILE1)
	sed -i 's/_group_/$(DIRECTORY3)/g' $(SCRATCHDIR)/$(DIRECTORY3)/$(FILE1)
	sed -i 's/_group_/$(DIRECTORY4)/g' $(SCRATCHDIR)/$(DIRECTORY4)/$(FILE1)
	sed -i 's/_group_/$(DIRECTORY5)/g' $(SCRATCHDIR)/$(DIRECTORY5)/$(FILE1)
	sed -i 's/_group_/$(DIRECTORY6)/g' $(SCRATCHDIR)/$(DIRECTORY6)/$(FILE1)
	sed -i 's/_group_/$(DIRECTORY7)/g' $(SCRATCHDIR)/$(DIRECTORY7)/$(FILE1)
	sed -i 's/_group_/$(DIRECTORY8)/g' $(SCRATCHDIR)/$(DIRECTORY8)/$(FILE1)
	sed -i 's/_group_/$(DIRECTORY9)/g' $(SCRATCHDIR)/$(DIRECTORY9)/$(FILE1)
	sed -i 's/_group_/$(DIRECTORY10)/g' $(SCRATCHDIR)/$(DIRECTORY10)/$(FILE1)
	sed -i 's/_group_/$(DIRECTORY11)/g' $(SCRATCHDIR)/$(DIRECTORY11)/$(FILE1)
	sed -i 's/_group_/$(DIRECTORY12)/g' $(SCRATCHDIR)/$(DIRECTORY12)/$(FILE1)
	sed -i 's/_group_/$(DIRECTORY13)/g' $(SCRATCHDIR)/$(DIRECTORY13)/$(FILE1)
	sed -i 's/_group_/$(DIRECTORY14)/g' $(SCRATCHDIR)/$(DIRECTORY14)/$(FILE1)
	sed -i 's/_group_/$(DIRECTORY15)/g' $(SCRATCHDIR)/$(DIRECTORY15)/$(FILE1)
	sed -i 's/_group_/$(DIRECTORY16)/g' $(SCRATCHDIR)/$(DIRECTORY16)/$(FILE1)
	sed -i 's/_group_/$(DIRECTORY17)/g' $(SCRATCHDIR)/$(DIRECTORY17)/$(FILE2)
	sed -i 's/_group_/$(DIRECTORY18)/g' $(SCRATCHDIR)/$(DIRECTORY18)/$(FILE2)
	
prep:
	@echo "Here we go prep jobs"
	chmod +x $(SCRATCHDIR)/$(DIRECTORY1)/$(FILE1)
	chmod +x $(SCRATCHDIR)/$(DIRECTORY2)/$(FILE1)
	chmod +x $(SCRATCHDIR)/$(DIRECTORY3)/$(FILE1)
	chmod +x $(SCRATCHDIR)/$(DIRECTORY4)/$(FILE1)
	chmod +x $(SCRATCHDIR)/$(DIRECTORY5)/$(FILE1)
	chmod +x $(SCRATCHDIR)/$(DIRECTORY6)/$(FILE1)
	chmod +x $(SCRATCHDIR)/$(DIRECTORY7)/$(FILE1)
	chmod +x $(SCRATCHDIR)/$(DIRECTORY8)/$(FILE1)
	chmod +x $(SCRATCHDIR)/$(DIRECTORY9)/$(FILE1)
	chmod +x $(SCRATCHDIR)/$(DIRECTORY10)/$(FILE1)
	chmod +x $(SCRATCHDIR)/$(DIRECTORY11)/$(FILE1)
	chmod +x $(SCRATCHDIR)/$(DIRECTORY12)/$(FILE1)
	chmod +x $(SCRATCHDIR)/$(DIRECTORY13)/$(FILE1)
	chmod +x $(SCRATCHDIR)/$(DIRECTORY14)/$(FILE1)
	chmod +x $(SCRATCHDIR)/$(DIRECTORY15)/$(FILE1)
	chmod +x $(SCRATCHDIR)/$(DIRECTORY16)/$(FILE1)
	chmod +x $(SCRATCHDIR)/$(DIRECTORY17)/$(FILE2)
	chmod +x $(SCRATCHDIR)/$(DIRECTORY18)/$(FILE2)
	
	