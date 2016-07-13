#!/usr/bin/perl/

#####################################
# First program I wrote.            #
# It transcribes a DNA string to    #
# its complimentary sequence.       #
#####################################

use strict;
use warnings;
my $dna_seq = "AAAACCCGGT";
print "Original DNA-Sequence: $dna_seq \n";
$dna_seq = reverse($dna_seq);
$dna_seq =~tr/ATCGatcg/TAGCtagc/;
print "Complementary Sequence: $dna_seq \n";
