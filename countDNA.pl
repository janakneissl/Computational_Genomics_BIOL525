#!/usr/bin/perl

# This program will read in a file of nucleotides, count the number
# of each nucleotide, and print the answer to a file
# The program assumes that lines of sequence consist of only a, c, g, t, or n bases
# No assumption is made as to whether sequence is upper or lower case.

use strict;
use warnings;

open(INFILE, "sequence.fastq") || die("Could not open sequence.fastq\n"); # open the sequence file
open(OUTFILE, ">answers.txt") || die("Could not open answers.txt\n"); # open the output file

my $a_count = 0;
my $c_count = 0;
my $g_count = 0;
my $t_count = 0;
my $n_count = 0;

my $line;
while ($line = <INFILE>) {
    chomp($line);
    print STDERR "\t read $line\n";

    $line = uc($line);
    next if ($line !~ /^[ACGTN]+$/);
    print STDERR "\t processing $line\n";
    
    my @bases = split("", $line);
    
    my $i;
    for ($i = 0; $i < scalar(@bases); $i++) {
	if ($bases[$i] eq "A") {
	    $a_count++;
	} elsif ($bases[$i] eq "C") {
	    $c_count++;
	} elsif ($bases[$i] eq "G") {
	    $g_count++;
	} elsif ($bases[$i] eq "T") {
	    $t_count++;
	} elsif ($bases[$i] eq "N") {
	    $n_count++;
	}
    }
    
    print OUTFILE "Number of As = $a_count\n";
    print OUTFILE "Number of Cs = $c_count\n";
    print OUTFILE "Number of Gs = $g_count\n";
    print OUTFILE "Number of Ts = $t_count\n";
    print OUTFILE "Number of Ns = $n_count\n";
}
