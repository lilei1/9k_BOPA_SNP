#!/usr/bin/perl
##by Li Lei, 20170710, in St.Paul;
#this is to check how many no blast hits SNPs in the 9k or BOPA SNPS file
#usage: ./check_noBlast.pl noBlastHits_SNPid 9k_SNPid

use strict;
use warnings;

my ($file1, $file2) = @ARGV;

my %gidhash;


open(SNPID,  "$file1") or die "Could not open $file1";

foreach my $row (<SNPID>){
        chomp $row;
        my @rtemp = split(/\t/,$row);
        my $g_id = $rtemp[0];
           $gidhash{$g_id}=0;
        #print "$rtemp[0]\n";
}
close (SNPID);
#print Dumper(\%gidhash);
open(OUT,  "$file2") or die "Could not open $file2";

foreach my $row (<OUT>){
        chomp $row;
        my @rtemp1 = split(/\t/,$row);
           #print "$rtemp1[0]\n";
           my $gene = $rtemp1[0];
        if(exists $gidhash{$gene}){
           print "$gene\tYes\n";
        }
        else{
           print "$gene\tNOT_EXISTS\n";
        }
}
close (OUT);