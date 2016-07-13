#!usr/bin/perl

#############################################
# Program to extract variants from a vcf    #
# file, which have a minimum depth defined  #
# as input and a low or high allele balance #
#############################################

use strict;
use warnings;

if(scalar(@ARGV) !=3){ 
	print "Please give the following arguments: input-file name, 
    		output-file name, minimum total number of reads\n"; 
	die();
}

#use the command line input to define variables
my $inputfile = $ARGV[0];
my $outputfile = $ARGV[1];
my $DPtag = $ARGV[2];

open(INFILE, $inputfile) 
|| die("Could not open the VCF file\n");

open(OUTFILE, ">$outputfile") 
|| die("Cannot create new outputfile\n");
	
#read in the input file 
while (my $currentline= <INFILE>){
	chomp($currentline);
	if($currentline !~ /^#/){ 
		my @fields = split(" ", $currentline);
		my $info = $fields[7];
		my @info = split(";", $info); #split info field from VCF file 
		my $ABfield = $info[0];
		my @AB = split("=", $ABfield);  # extract allele balance
		my $rightAB = $AB[1]; 
		my @finAB = split(",", $rightAB);
		my $DPfield = $info[7];
		my @DP = split("=", $DPfield); # DP = combined depth across samples
		
		#find variants with a allele balance of 0.1-0.3 or 0.7-0.9
		if(($finAB[0]>0.1 and $finAB[0]<0.3) or ($finAB[0]>0.7 and $finAB[0]<0.9)){ 
			if ($DP[1] >= $DPtag){ #define minimum depth as input
				print OUTFILE "$currentline\n";
			}
		}
	}
}
