#Usage: python3 .py strain_list
#strain_list format: ERR137225.fastq.gz --> ERR137225
import sys

f1=open(sys.argv[1]).readlines()

for strain in f1:
	strain=strain.rstrip()
	step1="/home/zty/sickle-master/sickle se -t sanger -f "+strain+".fastq.gz -o "+strain+".fastq"+"\n"
	step2="/home/zty/bowtie2-2.2.9/bowtie2 -x /home/zty/tb_h37rv.fasta -U "+strain+".fastq -S "+strain+".sam"+"\n"
	step3="samtools view -bhSt /home/zty/tb_h37rv.fasta.fai "+strain+".sam -o "+strain+".paired.bam"+"\n"
	step4="samtools sort "+strain+".paired.bam  -o "+strain+".sort.bam"+"\n"
	step5=("depth=$( samtools depth "+ strain+".sort.bam | awk '{s+=$3}END{print s/NR}' )"+"\n"
		"coverage=$( samtools depth "+strain+".sort.bam | awk 'END{print NR/4411532}' )"+"\n"
		"a=$(($( echo $depth | awk '{printf (\"%.f\",$1)}' )))"+"\n"
		"if [ \"$a\" -ge 10 ] && (echo ${coverage} 0.95 | awk '!($1>=$2){exit 1}');then"+"\n"
		"\t"+"samtools mpileup -q 30 -Q 30 -Bf /home/zty/tb_h37rv.fasta "+strain+".sort.bam > "+strain+".pileup"+"\n"
		"\t"+"b=$(($( echo $depth | awk '{printf (\"%.f\",$1)}' )/10))"+"\n"
		 "\t"+"if $b < 5;then"+"\n"
		"\t"+"\t"+"java -jar /home/zty/VarScan.v2.3.9.jar mpileup2snp "+strain+".pileup --min-coverage 5 --min-reads2 2 --min-avg-qual 30 --min-var-freq 0.75 --p-value 99e-02 > "+strain+".varscan"+"\n"
		"\t"+"else"+"\n"
		"\t"+"java -jar /home/zty/VarScan.v2.3.9.jar mpileup2snp "+strain+".pileup --min-coverage $b --min-reads2 2 --min-avg-qual 30 --min-var-freq 0.75 --p-value 99e-02 > "+strain+".varscan"+"\n"
		"\t"+"fi"+"\n"
		"\t"+"java -jar /home/zty/VarScan.v2.3.9.jar mpileup2cns "+strain+".pileup --min-coverage 3 --min-avg-qual 20 --min-var-freq 0.75 --strand-filter 0 --min-reads2 2 > "+strain+".cns"+"\n"
		"\t"+"awk -F '[:]' '{if($9==0 || $10==0)$0=\"\";else print $0}' "+strain+".varscan > "+strain+".vars"+"\n"
		"\t"+"perl /home/zty/script/varscan_work_flow/0.1_PE_IS_filt_Rv.pl  /home/zty/script/varscan_work_flow/PPE_INS_list/PPE_INS_loci_Rv.list "+strain+".vars > "+strain+".var.ppe"+"\n"
		"\t"+"perl /home/zty/script/varscan_work_flow/1_format_trans.pl "+strain+".var.ppe > "+strain+".var.for"+"\n"
		"\t"+"cut -f2,3,4 "+strain+".var.for > "+strain+".snp"+"\n"
		"\t"+"rm "+strain+".sam "+strain+".varscan "+strain+".paired.bam "+strain+".fastq "+strain+".var.for "+strain+".var.ppe "+strain+".pileup"+"\n"
		"else"+"\n"
		"\t"+"echo "+strain+" do not meet criteria: ${depth}"+" ${coverage} >> discard"+"\n"
		"\t"+"rm "+strain+".sam "+strain+".varscan "+strain+".paired.bam "+strain+".fastq "+strain+".var.for "+strain+".var.ppe "+strain+".pileup"+"\n"
		"fi"+"\n"
		)
	open("single_end.sh","a").write(step1+step2+step3+step4+step5)