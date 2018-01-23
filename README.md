# China_TB_Evolutionary_History
This repository contains the analysis scripts that were written and used in the article of "".

# Authors of this study
Qingyun Liu, Aijing Ma, Lanhai Wei, Yu Pang, Beibei Wu, Tao Luo, Yang Zhou, Hong-Xiang Zheng, Qi Jiang, Mingyu Gan, Tianyu Zuo, Mei Liu, Chongguang Yang, Li Jin, Iñaki Comas, Sebastien Gagneux, Yanlin Zhao, Caitlin S. Pepperell, Qian Gao

# Abstract of this article
The majority of the world’s tuberculosis (TB) patients are found in a small number of high-burden countries from which detailed data are lacking. To explore the evolutionary history of M. tuberculosis in China—the third highest TB burden country, we analyzed a countrywide collection of 4,578 strains. Despite the large M. tuberculosis population in China, little genetic diversity was detected, with 99.0% of the bacterial population belonging to lineage 2 and three sublineages of lineage 4. The deeply rooted phylogenetic positions and geographic restriction of these four genotypes indicate that these populations expanded in situ following a small number of introductions to China. Coalescent analyses estimated that these genotypes emerged in China around 1,000 years ago, expanded in parallel from the 12th century onward, with the whole population peaking in the late 18th century. More recently, the population dynamics of M. tuberculosis in China became dominated by the locally emerged sublineage L2.3 that showed higher transmissibility and extensive global dissemination. In conclusion, our results suggest that historical introductions and expansions of four MTBC genotypes shaped the current TB epidemic in China. 

# Introduction and usage of the analyzing scripts

If you have any question regarding the analysis scripts, please send an email to Qingyun Liu (edwinew@foxmail.com).

1. WGS data analysis and SNP calling
   The python scripts "1_Paired_Fixed_SNP_Calling.py" and "1_Single_Fixed_SNP_Calling.py" were written to generate the executive scripts for WGS data analysis from data trimming to SNP calling. "1_Paired_Fixed_SNP_Calling.py" is for paired-end sequencing data and "1_Single_Fixed_SNP_Calling.py" is for single-end sequencing data.
   Usage: python3 1_Paired_Fixed_SNP_Calling.py/1_Single_Fixed_SNP_Calling.py Strain_list
   (Strain_list is a list of strain names in the local directory; this command will generate a executive script named "pair_end.sh" or "single_end.sh"; then bash the sh file)

2. Lineage/Sublineage typing based on WGS data
   The perl script "2_Lineage_typing.pl" was written for lineage/sublineage typing using the SNP barcodes that were identified and validated by Coll, F. et al (Nat Commun,2014).
   Usage: Perl 2_Lineage_typing.pl SNP_file
   (SNP_file is the snp file that was generated for each strain in the step above, which contains three columns: loci, reference allele, mutant)
   
3. Prepare fasta file for phylogenetic tree reconstruction
   The shell script "3_Fasta_for_phylogeny.sh" was written to prepare fasta file for phylogeny tree reconstruction.
   Usage: sh 3_Fasta_for_phylogeny.sh
   (This script will also run another two scripts that contained in the same folder: 3.1_vsc2hpt_lc.pl and 3.2_del-InvMis.pl)
   
4. Identify MIRU-VNTR clusters
   The perl script "4_VNTR_cluster_identify.pl" was written to identify VNTR clusters in a loci matrix of typing results.
   Usage: perl 4_VNTR_cluster_identify.pl VNTR_data.txt
   (This command will print out all the VNTR clusters that were in different sublineages and different county sites; The example file of VNTR_data.txt is provided in Data folder)
   
5. PCA analysis
   The R script "5_PCA.r" was written for PCA analysis of the separation of sublineage L4.11 from its sister sublineages.
   
6. Nucleotide diversity and Rarefaction analysis.
   The R scripts "6_Pi_Nuc_Div.r" and "7_Rarefaction.r" were written for nucleotide diversity (pi) and Rarefaction analysis.
   
7. Figure ploting.
   The R scripts "8_BSP_Plot.r" and "9_Circular_Plot.r" were used for Bayesian Skyline Ploting and Cicular Ploting in this article.
