#!usr/bin/perl 
use warnings;

#Usage: Perl $.pl  Typing_SNP  $.snp

my %lin;
my %sub1;
my %sub2;
my %sub3;
my %sub4;
my %hash;
open F1, "</home/edwin/script/lineage_assign/typing_SNP" or die $!;
while(<F1>){
chomp;
@a=split "\t",$_;
if($a[1] =~ m/LINEAGE/){
$lin{$a[0]}=$a[1];
}elsif($a[1] =~ m/lineage1/){
$sub1{$a[0]}=$a[1];
}elsif($a[1] =~ m/lineage2/){
$sub2{$a[0]}=$a[1];
}elsif($a[1] =~ m/lineage3/){
$sub3{$a[0]}=$a[1];
}elsif($a[1] =~ m/lineage4/){
$sub4{$a[0]}=$a[1];
}
}
close F1;


my $lineage;
my $sublineage="";
my $k=0;
my $m=0;

open F2, $ARGV[0] or die $!;
while(<F2>){
chomp;
@a=split "\t",$_;
$hash{$a[0]}=1;
}
close F2;

foreach $i(keys %hash){
if(exists $lin{$i} && $lin{$i} ne "LINEAGE4"){
if($k>0){
if($lineage eq $lin{$i}){
}else{
$lineage="Heterozygosity_$lineage-$lin{$i}";
$sublineage="Heterozygosity_$lineage-$lin{$i}";
}
}else{
$lineage=$lin{$i};
$k=1;
}
}
}

if($k==0){
$lineage="LINEAGE4";
foreach $j(keys %hash){
if(exists $sub4{$j} && $sub4{$j} ne "lineage4.9"){
if($m>0){
$temp=$sub4{$j};
$a=length $sublineage;
$b=length $temp;
if($a < $b){
$sublineage=$temp;
}
}else{
$sublineage=$sub4{$j};
$m++;
}
}
}
if($m==0){
$sublineage="lineage4.9.x.x";
}
}

if($k==1){
if($lineage eq "LINEAGE1"){
foreach $j(keys %hash){
if(exists $sub1{$j} && $sub1{$j} ne "lineage1.1"){
if($m>0){
$temp=$sub1{$j};
$a=length $sublineage;
$b=length $temp;
if($a < $b){
$sublineage=$temp;
}
}else{
$sublineage=$sub1{$j};
$m++;
}
}
}
if($m==0){
$sublineage="lineage1.x.x.x";
}
}

if($lineage eq "LINEAGE2"){
foreach $j(keys %hash){
if(exists $sub2{$j} && $sub2{$j} ne "lineage2.2"){
if($m>0){
$temp=$sub2{$j};
$a=length $sublineage;
$b=length $temp;
if($a < $b){
$sublineage=$temp;
}
}else{
$sublineage=$sub2{$j};
$m++;
}
}
}
if($m==0){
$sublineage="lineage2.x.x.x";
}
}

if($lineage eq "LINEAGE3"){
foreach $j(keys %hash){
if(exists $sub3{$j}){
if($m>0){
$temp=$sub3{$j};
$a=length $sublineage;
$b=length $temp;
if($a < $b){
$sublineage=$temp;
}
}else{
$sublineage=$sub3{$j};
$m++;
}
}
}
if($m==0){
$sublineage="lineage3.x.x.x";
}
if($sublineage =~ m/lineage3\.1\.2\.1/){
$sublineage="lineage3.1.2.1";
}
}

if($lineage eq "LINEAGE7"){
$sublineage="lineage7";
}
if($lineage eq "LINEAGE6"){
$sublineage="lineage6";
}
if($lineage eq "LINEAGE5"){
$sublineage="lineage5";
}
}
if($sublineage eq ""){
print "$lineage\t\t$ARGV[0]\n";
}else{
print "$lineage\t$sublineage\t$ARGV[0]\n";
}