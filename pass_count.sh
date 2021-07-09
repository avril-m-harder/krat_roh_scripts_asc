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

## cd into working scratch directory
cd /home/aubaxh002/03_snp_calling/output/

echo "All SNPs in more stringent filter flagged\n" >> count_results.txt
gzip -cd all_samples_nobaseQrecal_filter_flagged.vcf.gz | grep "^ptg" | wc -l >> count_results.txt

echo "\n\nPASS SNPs in more stringent filter flagged (could incl. indels)\n" >> count_results.txt
gzip -cd all_samples_nobaseQrecal_filter_flagged.vcf.gz | grep "PASS" | wc -l >> count_results.txt

echo "\n\nPASS SNPs kept in more stringent filtered\n" >> count_results.txt
gzip -cd /scratch/aubaxh002_03b_noBQSR_genomicsdb/all_samples_nobaseQrecal_filtered_SNPs_only.vcf.gz | grep "^ptg" | wc -l >> count_results.txt

echo "\n\nAll SNPs in less stringent filter flagged\n" >> count_results.txt
gzip -cd all_samples_nobaseQrecal_filter_flagged_less_stringent.vcf.gz | grep "^ptg" | wc -l >> count_results.txt

echo "\n\nPASS SNPs in less stringent filter flagged (could incl. indels)\n" >> count_results.txt
gzip -cd all_samples_nobaseQrecal_filter_flagged_less_stringent.vcf.gz | grep "PASS" | wc -l >> count_results.txt

echo "\n\nPASS SNPs kept in less stringent filtered\n" >> count_results.txt
gzip -cd /scratch/aubaxh002_03b_noBQSR_genomicsdb/all_samples_nobaseQrecal_filtered_SNPs_only_less_stringent.vcf.gz | grep "^ptg" | wc -l >> count_results.txt

echo "\n\nPASS SNPs kept in less stringent filtered + SNPs near indels removed\n" >> count_results.txt
gzip -cd /home/aubaxh002/03_snp_calling/output/all_samples_nobaseQrecal_filtered_SNPs_only_less_stringent_nearindelfilt.vcf.gz | grep "^ptg" | wc -l >> count_results.txt

echo "\n\nPASS SNPs kept in less stringent filtered + SNPs near indels removed + missing data filter\n" >> count_results.txt
gzip -cd /home/aubaxh002/03_snp_calling/output/all_samples_nobaseQrecal_filtered_SNPs_only_less_stringent_nearindelfilt_missdatafilt.recode.vcf.gz | grep "^ptg" | wc -l >> count_results.txt