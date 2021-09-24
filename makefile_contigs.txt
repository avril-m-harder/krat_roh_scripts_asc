# Makefile
# Date: 4/2/2015 - Created by Mark Christie
# set paths, directories, and filenames

# JW update:14 Oct 2015; AH update for ASC: 29 Apr 2021

PATHDIR = /home/aubaxh002/krat_roh_scripts_asc

## Each directory will only contain the scripts used to process that particular
## group of contigs. Scripts will be held in /home/, data will be processed in /scratch/.
DIRECTORY1 = _c1_
DIRECTORY2 = _c2_
DIRECTORY3 = _c3_
DIRECTORY4 = _c4_
DIRECTORY5 = _c5_
DIRECTORY6 = _c6_
DIRECTORY7 = _c7_
DIRECTORY8 = _c8_
DIRECTORY9 = _c9_
DIRECTORY10 = _c10_

FILE1 = 03b_noBQSR_genomicsdb_contig_batches.sh

all:
	@echo "Please type....."
	@echo "    make directories"
	@echo "    make scripts"
	@echo "    make setgroup"
	
directories:
	@echo "Here we go directories"
	mkdir $(PATHDIR)/$(DIRECTORY1)
	mkdir $(PATHDIR)/$(DIRECTORY2)
	mkdir $(PATHDIR)/$(DIRECTORY3)
	mkdir $(PATHDIR)/$(DIRECTORY4)
	mkdir $(PATHDIR)/$(DIRECTORY5)
	mkdir $(PATHDIR)/$(DIRECTORY6)
	mkdir $(PATHDIR)/$(DIRECTORY7)
	mkdir $(PATHDIR)/$(DIRECTORY8)
	mkdir $(PATHDIR)/$(DIRECTORY9)
	mkdir $(PATHDIR)/$(DIRECTORY10)

scripts:
	cp -r $(PATHDIR)/$(FILE1) $(PATHDIR)/$(DIRECTORY1)/$(FILE1)
	cp -r $(PATHDIR)/$(FILE1) $(PATHDIR)/$(DIRECTORY2)/$(FILE1)
	cp -r $(PATHDIR)/$(FILE1) $(PATHDIR)/$(DIRECTORY3)/$(FILE1)
	cp -r $(PATHDIR)/$(FILE1) $(PATHDIR)/$(DIRECTORY4)/$(FILE1)
	cp -r $(PATHDIR)/$(FILE1) $(PATHDIR)/$(DIRECTORY5)/$(FILE1)
	cp -r $(PATHDIR)/$(FILE1) $(PATHDIR)/$(DIRECTORY6)/$(FILE1)
	cp -r $(PATHDIR)/$(FILE1) $(PATHDIR)/$(DIRECTORY7)/$(FILE1)
	cp -r $(PATHDIR)/$(FILE1) $(PATHDIR)/$(DIRECTORY8)/$(FILE1)
	cp -r $(PATHDIR)/$(FILE1) $(PATHDIR)/$(DIRECTORY9)/$(FILE1)
	cp -r $(PATHDIR)/$(FILE1) $(PATHDIR)/$(DIRECTORY10)/$(FILE1)

setgroup:
	@echo "Here we go set groups"
	sed -i 's/_group_/$(DIRECTORY1)/g' $(PATHDIR)/$(DIRECTORY1)/$(FILE1)
	sed -i 's/_group_/$(DIRECTORY2)/g' $(PATHDIR)/$(DIRECTORY2)/$(FILE1)
	sed -i 's/_group_/$(DIRECTORY3)/g' $(PATHDIR)/$(DIRECTORY3)/$(FILE1)
	sed -i 's/_group_/$(DIRECTORY4)/g' $(PATHDIR)/$(DIRECTORY4)/$(FILE1)
	sed -i 's/_group_/$(DIRECTORY5)/g' $(PATHDIR)/$(DIRECTORY5)/$(FILE1)
	sed -i 's/_group_/$(DIRECTORY6)/g' $(PATHDIR)/$(DIRECTORY6)/$(FILE1)
	sed -i 's/_group_/$(DIRECTORY7)/g' $(PATHDIR)/$(DIRECTORY7)/$(FILE1)
	sed -i 's/_group_/$(DIRECTORY8)/g' $(PATHDIR)/$(DIRECTORY8)/$(FILE1)
	sed -i 's/_group_/$(DIRECTORY9)/g' $(PATHDIR)/$(DIRECTORY9)/$(FILE1)
	sed -i 's/_group_/$(DIRECTORY10)/g' $(PATHDIR)/$(DIRECTORY10)/$(FILE1)
