#!/usr/bin/perl
#2016/08/25 by Li Lei
#Tis is for find which SNPs need to flipped and which SNP need to force reference alleles, and which one need to both. 
#usage: perl check_rc_ref_allele.pl /home/morrellp/llei/shared/Datasets/Genotyping/9k_BOPA_POPA_refv1.0/9k_iselect/new_barley_fixed_rc_sorted.vcf /home/morrellp/llei/shared/Datasets/Genotyping/BOPA1and2/Bopa1and2.vcf
use strict;
use warnings;
#use Data::Dumper;
my ($VCF_pos, $vcf_geno) = @ARGV; #vcf is the new file Paul made 
my %hash;
open(IN1, $VCF_pos) or die "Could not open this $VCF_pos";
#my $header =<IN1>; #skip the head line
foreach my $row (<IN1>){
        chomp $row;
        if ($row =~ /^#/){
            next;
        }
        else{
            my @rtemp = split(/\t/,$row);
            my $Locus_name = $rtemp[2];
            #my $chs = $rtemp[0];
            #my $pos = $rtemp [1];
               $hash{$Locus_name} = $row;
        }
       
}

close IN1;




open(IN2, $vcf_geno) or die "Could not open this $vcf_geno"; #SNP_BAC is the file Paul made by Harvest
open(OUT1, ">force_ref");
open(OUT2, ">flipped_strand");
open(OUT3, ">keep_old");
open(OUT4, ">flipped_force_ref");
open(OUT5, ">werid_SNPs");
foreach my $row (<IN2>){
        chomp $row;
        if ($row =~ /^#/){
            next;
        }
        else{
              my @rtemp = split(/\t/,$row);
              my $ref_geno = $rtemp[3];
              my $alt_geno = $rtemp[4];
              my $snpid = $rtemp[2];
              if (exists $hash{$snpid}){
                  my $line_pos = $hash{$snpid};
                  my @temp = split(/\t/,$line_pos);
                  my $ref_pos = $temp[3];
                  my $alt_pos = $temp[4];
                  if($ref_pos eq $alt_geno and $alt_pos eq $ref_geno){
                     print OUT1 "$snpid\t$ref_geno\t$alt_geno\t$ref_pos\t$alt_pos\n";
                  }
                  elsif($ref_pos eq &com_DNA($ref_geno) and $alt_pos eq &com_DNA($alt_geno)){
                     print OUT2 "$snpid\t$ref_geno\t$alt_geno\t$ref_pos\t$alt_pos\n";
                  }
                  elsif($ref_pos eq  $ref_geno and $alt_pos eq $alt_geno){
                     print  OUT3 "$snpid\t$ref_geno\t$alt_geno\t$ref_pos\t$alt_pos\n";
                  }
                  
                  elsif($ref_pos eq &com_DNA($alt_geno) and $alt_pos eq &com_DNA($ref_geno)){
                     print  OUT4 "$snpid\t$ref_geno\t$alt_geno\t$ref_pos\t$alt_pos\n";
                  }
                  else{
                    print OUT5 "$snpid\t$ref_geno\t$alt_geno\t$ref_pos\t$alt_pos\n";
                  }
              }
          }
}

close IN2;

sub com_DNA{
    my $dna = shift;
    my $revcomp = reverse($dna);
       $revcomp  =~ tr /atcgATCG/tagcTAGC/;
    return $revcomp;
}
