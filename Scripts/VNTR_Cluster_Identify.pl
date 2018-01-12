#!usr/bin/perl
use warnings;

# perl $.pl original_vntr_file
my $n=0;
my @vntr;
open F1, $ARGV[0] or die $!;
while(<F1>){
chomp;
@a=split "\t",$_;
foreach $i(1..$#a-1){
if($a[$i]=~m/N|\.|\?|[a-z]|\/|,|\(/){
$n++;
}
}
if($n<2){
push @vntr, $_;
}
$n=0;
}
close F1;

my %ID;
my %SZ;
my %VN;
my $m=0;
my $n=1;
my $c=0;
my @list;

foreach $v(@vntr){
chomp;
@a=split "\t",$v;
if($m==0){
foreach $i(1..$#a-1){
$VN{$a[0]}.="_$a[$i]";
}
$VN{$a[0]}=~s/^_//;
push @list, $a[0];
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