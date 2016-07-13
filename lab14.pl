#!usr/bin/perl
use strict;
use warnings;

if(scalar(@ARGV) !=3){ 
	print "Please give the following arguments: input-file name, 
    		output-file name, minimum total number of reads\n"; 
	die();
}

my $inputfile = $ARGV[0];
my $outputfile = $ARGV[1];
my $DPtag = $ARGV[2];

open(INFILE, $inputfile) 
|| die("Could not open the VCF file\n");

open(OUTFILE, ">$outputfile") 
|| die("Cannot create new outputfile\n");
	
while (my $currentline= <INFILE>){
	chomp($currentline);
	if($currentline !~ /^#/){
		my @fields = split(" ", $currentline);
		my $info = $fields[7];
		my @info = split(";", $info);
		my $ABfield = $info[0];
		my @AB = split("=", $ABfield);
		my $rightAB = $AB[1];
		my @finAB = split(",", $rightAB);
		my $DPfield = $info[7];
		my @DP = split("=", $DPfield);
		#print "$DP[1]\n$AB[1]\n";
		if(($finAB[0]>0.1 and $finAB[0]>0.3) or ($finAB[0]>0.7 and $finAB[0]<0.9)){
			if ($DP[1] >= $DPtag){
				print OUTFILE "$currentline\n";
			}
		}
	}
}