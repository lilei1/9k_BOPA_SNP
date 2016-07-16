#!/usr/bin/perl
#20160715
#change the old name as new name for the Illumina contexture sequence.
#usage:
use strict;
use warnings;
my ($name_key, $contexture) = @ARGV;
open(IN1, $name_key) or die "Could not open this $name_key";

my %hash;
foreach my $row (<IN1>){
chomp $row;
my @rtemp = split(/\t/,$row);
   $hash{$rtemp[0]}=$rtemp[1];
}

close IN1;

open(IN2, $contexture) or die "Could not open this $contexture";
my $header = <IN2>;

foreach my $row (<IN2>){
chomp $row;
my @rtemp = split(/\t/,$row);
   if (exists $hash{$rtemp[0]}){
           print "$hash{$rtemp[0]}\t$rtemp[2]\n";
   }
   else{
   	 print "$rtemp[0]\tNONE\n";
   }
}

close IN1;
