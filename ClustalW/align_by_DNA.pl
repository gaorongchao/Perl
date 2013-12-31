use strict;
use warnings;
use Bio::SeqIO;

my @files=glob "*.fasta";
foreach my $file (@files)
{
	system "clustalw2 -INFILE=$file -TYPE=DNA -ALIGN -OUTFILE=A_$file -OUTPUT=FASTA -QUIET";
}
