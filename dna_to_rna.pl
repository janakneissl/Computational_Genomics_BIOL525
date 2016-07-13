#!/usr/bin/perl

########################################
# Simple program to transcribe DNA to  #
# RNA string.                          #
########################################

use strict;
use warnings;
my $dna_seq = "GATGGAACTTGACTACGTAAATT";
print "Original DNA-Sequence: $dna_seq \n";
$dna_seq =~ tr/Tt/Uu/;
print "Corresponding RNA-Seuence: $dna_seq \n";
