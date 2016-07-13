#!usr/bin/perl

###############################################
# Further program to practice data extraction #
# from a database using the DBI module in     #
# perl to interact with mySQL database.       #
###############################################

use strict;
use warnings;
use DBI;
use DBD::mysql;

#define all variables:
	my $inputfile;
	my $db_table;
	my $outputfile;
	my $currentline;
	my @currentline;
	my $chromosome;
	my $genestart;
	my $geneend;
	my $genename;
	

#check for the amount of input
	if(scalar(@ARGV) !=3){ 
		print "Please give the following arguments: bed-file, 
				database-name, outputfile name\n"; 
		die();
	}

#assign the variable names to the input
	$inputfile = $ARGV[0];
	$db_table = $ARGV[1];
	$outputfile = $ARGV[2];

#set up the connection to the database-name
	my $dbh=DBI->connect("DBI:mysql:biol525_jankneis:localhost","jankneis", "jankneis") 
    || die "Error connecting to database: $!\n";

#read in the inputfile and open the output file
	open(INFILE, $inputfile) 
	|| die("Could not open the bed-file\n");
	#create a new outputfile and open it
	open(OUTFILE, ">$outputfile") 
	|| die("Cannot create new outputfile\n");
	
#create some structure in the outputfile
	print OUTFILE "Overlapping entries in $db_table and $inputfile";
	print OUTFILE "Chromosome\tGenestart\tGeneend\tGenename\n";
	
	
#the input file can be read in line by line and the query can be performed on each line
	while ($currentline= <INFILE>){
	#the line should be split into the fields: chromosome, genestart, geneend and name
	@currentline = split("\t", $currentline);
	$chromosome = $currentline[0];
	$genestart = $currentline[1];
	$geneend = $currentline[2];
	$genename = $currentline[3];
	print OUTFILE "\nThe line from the file is\n@currentline\n";

	#the queries to perform on the line has to be prepared and executed and printed 

	print OUTFILE "The lines from the table are: \n";
	#1: the gene in the deb file starts before a database entry and ends after it
	my $sth1 = $dbh -> prepare("SELECT DISTINCT chrom, chromStart, chromEnd, name FROM $db_table WHERE chrom =? AND chromStart > ? AND chromEnd < ?");
	$sth1 -> execute($chromosome, $genestart, $geneend);
	while(my @result1 = $sth1 -> fetchrow_array()){
		print OUTFILE "@result1\n";
	}
	#2: the gene in the deb file starts after a database entry and ends before it
	my $sth2 = $dbh -> prepare("SELECT DISTINCT chrom, chromStart, chromEnd, name FROM $db_table WHERE chrom=? AND chromStart < ? AND chromEnd > ?");
	$sth2 -> execute($chromosome, $genestart, $geneend);
	while(my @result2 = $sth2 -> fetchrow_array()){
		print OUTFILE "@result2\n";
	}
	#3: the gene in the deb file starts before a database entry and ends within it 
	my $sth3 = $dbh -> prepare("SELECT DISTINCT chrom, chromStart, chromEnd, name FROM $db_table WHERE chrom =? AND chromStart > ? AND chromStart < ?");
	$sth3 -> execute($chromosome, $genestart, $geneend);
	while(my @result3 = $sth3 -> fetchrow_array()){
		print OUTFILE "@result3\n";
	}
	#4: the gene in the deb file starts after a database entry and ends after it 
	my $sth4 = $dbh -> prepare("SELECT DISTINCT chrom, chromStart, chromEnd, name FROM $db_table WHERE chrom =? AND chromEnd > ? AND chromEnd < ?");
	$sth4 -> execute($chromosome, $genestart, $geneend);
	while(my @result4 = $sth4 -> fetchrow_array()){
		print OUTFILE "@result4\n";
	}
	
}
