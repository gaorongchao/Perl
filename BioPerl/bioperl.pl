use strict;
use warnings;
use Data::Dumper;
use Bio::SeqIO;

my $seqo_object=Bio::SeqIO->new(-file=>">result2.fasta",-format=>"genbank");
my $seqi_object=Bio::SeqIO->new(-file=>"Os01g0104900.fasta",-format=>"fasta");
while(my $seq_object=$seqi_object->next_seq)
{
	$seqo_object->write_seq($seq_object);
}
