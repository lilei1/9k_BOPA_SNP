#!/usr/bin/perl
#2016/07/01 by Li Lei
#This is to help to convert all of the contexure sequences into fasta files. 
#usage: perl ./script/contextual_fasta.pl ./raw/9k_iselect.txt >9k_iselect_contextual.fasta
use strict;
use warnings;
#use Data::Dumper;
my ($INPUT, $OUTPUT) = @ARGV; #$ALCHEMY is ALCHEMY data; $VCF is the SNP data I called from the BAM file;
open(IN1, $INPUT) or die "Could not open this $INPUT";
my %IUPAC = (
   '[A/G]' => 'R',
   '[A/T]' => 'W',
   '[A/C]' => 'M',
   '[T/A]' => 'W',
   '[T/C]' => 'Y',
   '[T/G]' => 'K',
   '[C/A]' => 'M',
   '[C/T]' => 'Y',
   '[C/G]' => 'S',
   '[G/A]' => 'R',
   '[G/T]' => 'K',
   '[G/C]' => 'S',
	);

my $header =<IN1>; #skip the head line
foreach my $row (<IN1>){
        chomp $row;
        my @rtemp = split(/\t/,$row);
        my $Locus_name = $rtemp[1];
        my $seq = uc($rtemp[2]);
        $seq =~ /(\[.*\])/g;
        #print "$seq\n";
        my $key = $1;
        my $val = $IUPAC{$1};
        $seq =~ s/(\[.*\])/$val/g;
        #print " $IUPAC{$1}\t$seq\n";
        print ">".$Locus_name."\n"; #print the name of each loaci
        print "$seq\n";
}

close IN1;
