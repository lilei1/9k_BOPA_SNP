#!/usr/bin/perl
#2016/07/15 by Li Lei
#This is to replace the golden path position with the refv1.0 position, and feed this file and Alchemy data with Tom's python code and produce a ped an map files; 
#usage: perl replace_physipos.pl /panfs/roc/groups/9/morrellp/shared/Datasets/Genotyping/9k_BOPA_POPA_refv1.0/9k_iselect/new_barley_fixed_rc.vcf /panfs/roc/groups/9/morrellp/shared/Datasets/Genotyping/9k_BOPA_POPA_refv1.0/9k_iselect/HarvEST_Outputs/SNP_BAC.txt > ../output/SNP_BAC_refv1.0.txt
use strict;
use warnings;
#use Data::Dumper;
my ($VCF, $SNP_BAC) = @ARGV; #vcf is the new file Paul made 
my %hash;
open(IN1, $VCF) or die "Could not open this $VCF";
#my $header =<IN1>; #skip the head line
foreach my $row (<IN1>){
        chomp $row;
        if ($row =~ /^#/){
            next;
        }
        else{
            my @rtemp = split(/\t/,$row);
            my $Locus_name = $rtemp[2];
            my $chs = $rtemp[0];
            my $pos = $rtemp [1];
               $hash{$Locus_name} = $chs."_".$pos;
        }
       
}

close IN1;




open(IN2, $SNP_BAC) or die "Could not open this $SNP_BAC"; #SNP_BAC is the file Paul made by Harvest

my $header =<IN2>; #skip the head line
print "$header\t";
foreach my $row (<IN2>){
        chomp $row;
        my @rtemp = split(/\t/,$row);
        my $snpid = $rtemp[0];
        if (exists $hash{$snpid}){
            my $new_pos = $hash{$snpid};
            my ($chrs, $pos) = split(/\_/,$new_pos);
            #use the ne position and new chromosome to replace the old positions;
            print "$rtemp[0]\t$rtemp[1]\t$rtemp[2]\t$rtemp[3]\t$rtemp[4]\t$rtemp[5]\t$chrs\t$rtemp[7]\t$rtemp[8]\t$rtemp[9]\t$pos\t$rtemp[11]\t$rtemp[12]\t$rtemp[13]\t$rtemp[14]\t$rtemp[15]\t$rtemp[16]\n";
        }
}

close IN1;
