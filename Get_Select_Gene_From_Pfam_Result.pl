#!/usr/bin/perl -w
use strict;
use Getopt::Long;
use Bio::SeqIO;

my $cmdline = "perl $0 @ARGV";
my ($fasta, $pfam,$output,$domain);
GetOptions(
            "fasta=s"     => \$fasta,
            "pfam=s"       => \$pfam,
            "output=s"    => \$output,
            "domain=s"    => \$domain
           );

unless( $fasta && $pfam && $output) {
#unless( $fasta && $pfam && $output &&$domain) {
    print <<EOF;
$0 -- Get CDS From Fasta and GFF file

Usage:   perl $0 [options]

Options: -f <STR>: File of fasta file
         -p <STR>: File of Pfam file
         -o <STR>: Output Files

EOF

    exit(0);
}

$|++;

print "# " . (scalar localtime()) . "\n";
my %cds=&seq($fasta);
open OUT,">$output";
open P,$pfam;
my %pfam;
my %exist;
while (<P>){
    chomp;
    next if /#/;
    next if !$_;
    my @array=split;
    if ($array[6] eq "NB-ARC" and !$exist{$array[0]}){
        my $seq=$cds{$array[0]}->seq;
        print OUT ">$array[0]\n$seq\n";
        $exist{$array[0]}=1;
    }
    
}
close P;
close OUT;







sub seq{
    my $io = new Bio::SeqIO(-format => 'fasta', -file => $_[0]);
    my %chr;
    while (my $seq = $io->next_seq){
	my $id=$seq->display_id;
	$chr{$id} = $seq;
    }
    return %chr;
}


