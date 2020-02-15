#!/bin/perl -w
#  metaVarFilter.pl filters a VCF file and creates outputs for metaVaR
#  input:  a VCF file produced by DiscoSNP++ ran on metagenomic data
#  output: (i) filter VCF that contains informative biallelic SNVs
#  	   (ii) a file with the depth of coverage of biallelic loci
#  	   (iii) a file with the allele frequencies

use strict;
use Getopt::Long;

our ( $VCF , $PREFIX , $MIN_COV , $MAX_COV , $MIN_POP, $HELP ) = ( "" , "" , 20 , 250 , 4, 0 );
my $result = &GetOptions ( "i=s" => \$VCF ,
                           "p=s" => \$PREFIX ,
                           "a=s" => \$MIN_COV ,
                           "b=s" => \$MAX_COV,
			   "c=s" => \$MIN_POP,
                           "h"     => \$HELP );

usage () if ( ! -f $VCF || $PREFIX eq "" || $HELP );

sub usage {
        my $usage = "
	metaVarFilter.pl filters a VCF file and creates inputs for metaVaR

        Usage:
	metaVarFilter.pl -i input.vcf -p output_prefix [-a minCov -b maxCov -c minPop]         

	Input:
	-i	a VCF file produced by DiscoSNP++ ran on multisample metagenomic data
	-p	a prefix output

        Options:
        -a      The minimum cumulative depth of coverage of a loci across populations (default 20)
        -b      The maximum cumulative depth of coverage of a loci across populations (default 250)
	-c	The minimum number of populations avec a SNP call for a loci to be kept (default 4)
	
	Outputs:
	1. prefix_filtered.vcf		a filtered VCF file that contains informative biallelic SNVs
	2. prefix_cov.txt		a file with the depth of coverage of biallelic loci in each population
	3. prefix_freq.txt		a file with the allele frequencies of biallelic loci in each population


";
        warn ( $usage );
        exit (1);
}

open (IN , $VCF) || die "Cannot open $VCF: $! \n";
open (OUT , ">".$PREFIX."_filtered.vcf" ) || die "Cannot open ".$PREFIX."_filtered.vcf: $! \n";
open (COV , ">".$PREFIX."_cov.txt" ) || die "Cannot open ".$PREFIX."_cov.txt: $! \n";
open (FREQ , ">".$PREFIX."_freq.txt" ) || die "Cannot open ".$PREFIX."_freq.txt: $! \n";
open (CCOV , ">".$PREFIX."_cumulative_coverage.txt" ) || die "Cannot open ".$PREFIX."_cumulative_coverage.txt: $! \n";
while (my $l = <IN>){
	my $ccov = 0;
	my $oc = 0;
	my @d = split( /\t/, $l );
	if( $d[3] =~/^[ATGC]$/ && $d[4] =~/^[ATGC]$/ ){
		for( my $i = 9; $i <= scalar(@d)-1; $i++){
			my @a=split( /\:/, $d[$i]);
			my @b=split( /\,/, $a[3]);
			my $cov_a = $b[0];
			my $cov_b = $b[1];
			$ccov += $cov_a + $cov_b;
			if( $cov_a + $cov_b > 0 && $a[0] =~/[01]/ ){
				$oc++
			}
		}
		if($oc >= $MIN_POP && $ccov < $MAX_COV && $ccov > $MIN_COV){
			print  OUT $l;
			my $lociCov = getCov ($l);
			print COV $lociCov->[0];
			print FREQ $lociCov->[1];
		}
		print CCOV $ccov,"\n";
	}
} 
close ( IN );
close ( OUT );
close ( COV );
close ( FREQ );
close ( CCOV );

## Calculate bilallelic loci depth of coverage and B-allele frequencies
sub getCov {
	my ($vcf_line) = @_;
	my @d = split ( /\t/ , $vcf_line );
	my $cov_line = $d[2];#add variant ID first
	my $freq_line = $d[2];#add variant ID first
	for ( my $i = 9; $i <= scalar(@d)-1; $i++){
		my @a = split( /\:/ , $d[$i]);
		my @b = split( /\,/ , $a[3] );
		my $cov = $b[0] + $b[1];
		$cov_line .= "\t".$cov;
		my $freq = "NA";
		$freq = $b[1]/$cov if( $cov > 0 ); 
		$freq_line .= "\t".$freq;
	}
	$cov_line .= "\n";
	$freq_line .= "\n";
	my @values = ( $cov_line, $freq_line );
	return ( \@values );
}
