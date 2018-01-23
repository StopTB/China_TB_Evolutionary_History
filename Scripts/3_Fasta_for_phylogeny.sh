# The pipeline for preparing fasta file for phylogeny tree reconstruction

# Step 1: call consensus loci information for each strain

ls *pileup|while read i;do j=${i%pileup}cns; java -jar /home/edwin/bin/VarScan.v2.3.6.jar mpileup2cns $i --min-coverage 3 --min-avg-qual 20 --min-var-freq 0.75 --strand-filter 1 --min-reads2 2 > $j;done

# Step 2: sort and uniq all the variant loci in all strains

cut -f1 *.snp|sort -n|uniq > all_location.list; 

# Step 3: re-call the nucleotide type of all variant loci in each strain based on the cns file from Step 1.

ls *.snp|while read i;do k=${i%snp}cns;l=${i%snp}fas;perl 3.1_vsc2hpt_lc.pl $k all_location.list $i > $l;done

# Step 4: merge all the fasta files and remove the gaps. This step will creat a fasta file with all strains aligned and those gaps filtered.

cat *.fas > all_strains.fas;
cut -f1-2 *.snp|sort -k1 -n|uniq > loci_file.list;
perl 3.2_del-InvMis.pl all_strains.fas loci_file.list 30
# Here, 30 means the gap region with 30% strains missing will be filtered.