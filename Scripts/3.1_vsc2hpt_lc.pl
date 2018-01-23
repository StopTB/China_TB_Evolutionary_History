#!/usr/bin/perl
#allsnpHpt.pl by tao
#modified by gan
#generate fasta file of each strain, using the recovered cns file, check each locus, filter insertion, low depth,
#filtered loci, and not sequenced loci.
use strict; use warnings;
use File::Basename;

die "usage:perl $0 <vsc file> <snploci> <filt snp file>\n" if @ARGV==0;

open F1, "<$ARGV[0]" or die $!;; #vsc file of indivitual strains
open F2, "<$ARGV[1]" or die $!; #snploci of all strains
open F3, "<$ARGV[2]" or die $!; #filt SNPs *lmq

my %snp;
while (<F3>){
	chomp;
	my @tm = split /\t/, $_;
	if($tm[0] !~ "^#"){
		$snp{$tm[0]} = 1;
	}
}
close F3;

my %cns;
while (<F1>) {
	chomp;
	my @tm = split /\t|:|\%/, $_; 
	if($tm[0] ne "Chrom"){
		my $l = length $tm[3];
		my $f = $tm[8];
		#print $f, "\n";
		if($l == 1){
			if($f eq "-"){
				$cns{$tm[1]} = "N"; # "N" represent coverage lower than 3 
			}
			elsif ($f>=75){
				if(exists $snp{$tm[1]}){
					$cns{$tm[1]} = $tm[3]; #changed $tm[4] to $tm[3](Date:20170814)
				}else{
					$cns{$tm[1]} = lc $tm[4]; # "-" represent SNPs that were filted
				}
			}
			elsif($f<75 && $f>5){
				$cns{$tm[1]} = "?"; # "?" represent Loci with ambigous base call
			}
			else{
				$cns{$tm[1]} = $tm[4]; #reference base
			}
		}else{
			$cns{$tm[1]} = "N"; # "N" represent loci with insertion or deletion
		}
	}
}
close F1;

my $s=$ARGV[2];
$s = basename $s;
chomp $s;
$s =~ s/\.snp//; 
$s =~ s/-/_/g;
print ">$s\n";

while (<F2>) {
	chomp;
	if(exists $cns{$_}){
		print $cns{$_};
	}else{
		print "N"; # "N" represent loci was't covered
	}
}
print "\n";
close F2;
