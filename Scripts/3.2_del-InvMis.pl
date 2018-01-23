#!/usr/bin/perl
use strict; 
use warnings;

#exclude loci at which N(>threshold) strains have ambiguous base
#by using fasta file which composed by all of the strain.

die "usage:perl $0 <fa_file> <loci_file> <threshold>\n" if @ARGV==0;

open (FA, "<$ARGV[0]");
open (SNP, "<$ARGV[1]");

my $hpt = $ARGV[0];
$hpt =~ s/\.fas//;
my $thr = $ARGV[2]/100; 

open (HPT, ">$hpt.del-InvMisF$ARGV[2].fa");
open (LOC, ">$hpt.del-InvMisF$ARGV[2].loc");

my %seq;
my $str;
while(<FA>){
	chomp;
	$_ =~ s/\s+//g;
	if ($_ =~ /^>/){
		$str = $_;
	}elsif($_){
		$seq{$str} = $_; 
	}
}
close FA;

my %loc;
my %ref;
my $n = 0;
while (<SNP>){
        chomp;
        my @a=split "\t", $_;
        $loc{$n} = $a[0];
        $ref{$n} = $a[1];
        $n++;
}
close SNP;

my $sn = keys %seq;
my @loci; 
my %len;
foreach my $k(keys %seq){
	my $sl=length $seq{$k}; 
	if(!exists $len{$sl}){ 
		$len{$sl}=1; 
	}else{ 
		$len{$sl}++;
	}
}
my $hl = (keys %len); 

if($hl >1){
	print "Input alingment is not aligned strictlly \n"
}else{
	my $sl = ((keys %len)[0]-1); 
	if ($sl != ($n-1)){
			print "Alingment and snpLoci is not match \n";
			die;
	}
	for my $loc (0..$sl){
		my %gt=();
		$gt{N}=0;
		foreach my $k(keys %seq){
			my $nuc = substr ($seq{$k}, $loc, 1);
            if($nuc =~ m/A|T|G|C|a|t|g|c|n|N/){
			$nuc= uc($nuc);    #capitalise "a t g c n"
            }
            if($nuc =~ m/N|-|\?/){     
				$gt{N}++;
			}
			elsif(!exists $gt{$nuc}){
				$gt{$nuc}=1; 
			}else{
				$gt{$nuc}++;
			}
        }
		my $frqmis = $gt{N}/$sn;
		my $gtn = keys %gt; 
        if($gt{N} == 0 && $frqmis < $thr && $gtn >= 2){    #nucletide type should be at least 2, if only 1, no useful information provided.
            push @loci, $loc;
            }elsif($gt{N} >0 && $frqmis < $thr && $gtn > 2){
			push @loci, $loc;
		}
	}
}

foreach my $k(keys %seq){
        my $j;
        $j=$k;
        $j=~s/\.cns//;
        print HPT $j, "\n";
        foreach (@loci){
                my $nuc = substr ($seq{$k},$_,1);
                print HPT $nuc;
        }
        print HPT "\n";
}

if(!exists $seq{">H37Rv"}){
#	print HPT ">H37Rv\n";
	foreach(@loci){
#    	    print HPT $ref{$_};
        	print LOC "gi|57116681|ref|NC_000962.2|", "\t",$loc{$_},"\t", $ref{$_}, "\n";
	}
#	print HPT "\n";
}else{
foreach(@loci){
        print LOC "gi|57116681|ref|NC_000962.2|", "\t",$loc{$_},"\t", $ref{$_}, "\n";
}
}

close HPT;
close LOC;
