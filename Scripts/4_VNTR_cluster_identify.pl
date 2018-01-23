#!usr/bin/perl
use warnings;

@pro=("gx","hlj","hn","sc","sd","sh");
foreach $i(@pro){
#	print "$i\n";
}

@sub=("L4.2","L4.4","L4.5","L2.2","L2.3");
foreach $i(@sub){
#	print "$i\n";
}

open F1, $ARGV[0] or die $!;
while(<F1>){
	chomp;
	@a=split "\t",$_;
	foreach $a(@pro){
		if($a[0] =~ m/$a/){
			foreach $b(@sub){
				if($a[-1] =~ m/$b/){
					open (OUT, ">>$a-$b.txt");
					print OUT "$_\n";
					close OUT;
				}
			}
		}
	}
}
close F1;

my $n=0;
my @vntr;

foreach $kk(@pro){
	foreach $mm(@sub){
		my %ID;
		my %SZ;
		my %VN;
		my $m=0;
		my $n=1;
		my $c=0;
		my @list;
		print "---------$kk-$mm--------\n";
		open F1, "<$kk-$mm.txt";
		while(<F1>){
		chomp;
		@a=split "\t",$_;
		if($m==0){
		foreach $i(1..$#a-1){
		$VN{$a[0]}.="_$a[$i]";
		}
		$VN{$a[0]}=~s/^_//;
		push @list, $a[0];
		#print "$a[0]\t$VN{$a[0]}\n";
		$m=1;
		}else{
		foreach $j(@list){
		@b=split "_",$VN{$j};
		foreach $k(1..$#a-1){
		if(($a[$k]!~m/N|\.|\?|[a-z]|\/|,|\(/)&&($b[$k-1]!~m/N|\.|\?|[a-z]|\/|,|\(/)){
		if($a[$k] ne $b[$k-1]){
		$c++;
		}
		}
		}
		if($c==0){
		#print "$j\t$a[0]\n";
		if(exists $ID{$j}){
		if(!exists $ID{$a[0]}){
		$ID{$a[0]}=$ID{$j};
		$SZ{$ID{$j}}++;
		}
		}else{
		$ID{$j}=$n;
		$ID{$a[0]}=$n;
		$SZ{$n}=2;
		$n++;
		}
		}
		$c=0;
		}
		foreach $i(1..$#a-1){
		$VN{$a[0]}.="_$a[$i]";
		}
		$VN{$a[0]}=~s/^_//;
		push @list, $a[0];
		}
		}
		foreach $i(1..$n-1){
		print "$i";
		print "\t$SZ{$i}";
		foreach $j(keys %ID){
		if($ID{$j}==$i){
		print "\t$j\t$VN{$j}";
		}
		}
		print "\n";
		}
		close F1;
	}
}