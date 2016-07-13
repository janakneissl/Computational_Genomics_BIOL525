#!/usr/bin/perl
use strict;
use warnings;
# Load the database modules
use DBI;
use DBD::mysql;

# Create the connection to the database
my $dbh=DBI->connect("DBI:mysql:biol525_jankneis:localhost","jankneis", "jankneis") 
    || die "Error connecting to database: $!\n";

# Number of rows:
my $sth1 = $dbh->prepare("SELECT count(*) FROM wgEncodeGencodeCompV19");
$sth1->execute();
my @row1;
print "Answer to question 1: \n";
while (@row1 = $sth1->fetchrow_array) {
    print "$row1[0]\n";
}
$sth1 -> finish;

# Rows with Chromosome 17 and specified transcription start and end:
my $sth2 = $dbh->prepare("SELECT count(*) FROM wgEncodeGencodeCompV19 WHERE chrom='chr17' AND txStart > 40830967 AND txEnd < 41642846");
$sth2->execute();
my @row2;
print "Answer to question 2: \n";
while (@row2 = $sth2->fetchrow_array) {
    print "$row2[0]\n";
}
$sth2 -> finish;

# Rows also laying on the negative strand:
my $sth3 = $dbh->prepare("SELECT count(*) FROM wgEncodeGencodeCompV19 WHERE chrom='chr17' AND txStart > 40830967 AND txEnd < 41642846 AND strand ='-'");
$sth3->execute();
my @row3;
print "Answer to question 3: \n";
while (@row3 = $sth3->fetchrow_array) {
    print "$row3[0]\n";
}
$sth3 -> finish;

# Rows where additionally there are more than 15 exons:
my $sth4 = $dbh->prepare("SELECT count(*) FROM wgEncodeGencodeCompV19 WHERE chrom='chr17' AND txStart > 40830967 AND txEnd < 41642846 AND strand ='-' AND exonCount >15");
$sth4->execute();
my @row4;
print "Answer to question 4: \n";
while (@row4 = $sth4->fetchrow_array) {
    print "$row4[0]\n";
}
$sth4 -> finish;

# Only rows with a unique name2:
my $sth5 = $dbh->prepare("SELECT DISTINCT name2 FROM wgEncodeGencodeCompV19 WHERE chrom='chr17' AND txStart > 40830967 AND txEnd < 41642846 AND strand ='-' AND exonCount >15");
$sth5->execute();
my @row5;
print "Answer to question 5: \n";
while (@row5 = $sth5->fetchrow_array) {
    print "$row5[0]\n";
}
$sth5->finish;

# Rows with the gene BRCA2:
my $sth6 = $dbh->prepare("SELECT COUNT(*) FROM wgEncodeGencodeCompV19 WHERE name2='BRCA1'");
$sth6->execute();
my @row6;
print "Answer to question 6: \n";
while (@row6 = $sth6->fetchrow_array) {
    print "$row6[0]\n";
}
$sth6 -> finish;


# show genename and status where the two tables have the same name
my $sth7 = $dbh->prepare("SELECT geneStatus, name2 from wgEncodeGencodeCompV19, wgEncodeGencodeAttrsV19 WHERE wgEncodeGencodeCompV19.name2 = wgEncodeGencodeAttrsV19.geneName 
							AND chrom = 'chr17' AND txStart > 40830967 AND txEnd < 41642846 AND strand = '-' AND exonCount > 15 GROUP BY geneStatus, name2;");
$sth7->execute();
my @row7;
print "Answer to question 7: \n";
while (@row7 = $sth7->fetchrow_array) {
    print "$row7[0] $row7[1]\n";
}
$sth7 -> finish;
exit;
