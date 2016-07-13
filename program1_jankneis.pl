#!usr/bin/perl

# This program will read in a file consisting of the first 100 lines of an fastq file 
# and record the amount of sequences containing a 'CAT' 
# The output will be printed to stdout

use strict; #create local instead of global variables
use warnings;

#open the input file, or stop the execution of the program
open(INFILE, "./data/homework1.txt") || die("Could not open homework1.txt\n");

#create variable for amount of sequences with CAT
my $CATcount;
#create a variable to read the file in line by line
my $line;

#start a while loop, which is repeated for each line of the input file
while ($line =<INFILE>){
	chomp($line); #delete the end of line character from current line
	$line = uc($line); #transform all letters of line into uppercase letters
	next if($line !~ /^[ACTGN]+/);
		# test whether line contains a dna sequence, restart the while loop
		# if it is not a sequence
	if($line =~ /CAT/){ #check whether sequence contains a CAT
	 	$CATcount++;
	} 
}
print "Number of sequences with CAT in this file: $CATcount\n"; #print the number of CAT to sdtout
close INFILE; #close the inputfile in the end
