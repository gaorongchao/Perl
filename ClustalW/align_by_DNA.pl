use strict;
use warnings;
use Bio::SeqIO;

my @files=glob "*.fasta";
foreach my $file (@files)
{
	system "clustalw2 -INFILE=$file -TYPE=DNA -ALIGN -OUTFILE=$file.A -OUTPUT=FASTA -QUIET";
	tran_severline_to_one($file);
}

sub tran_severline_to_one
{
	$/="\n>";
	my	$out_out = "$_[0].B";
	open  my $out, '>', $out_out or die  "Fail open $out_out\n";

	my	$in_in = "$_[0].A";
	open  my $in, '<', $in_in or die "Fail open $in_in file\n";
	while(my $line=<$in>)
	{
		chomp $line;
		my @infor=split/\n/,$line;
		$infor[0]=~/>?(.+)/;
		print $out ">$1\n";
		my $output_line;
		for my $i (1..$#infor)
		{
			$output_line .=$infor[$i];
		}
		print $out "$output_line\n";
	}
	close  $in;
	close  $out;
	$/="\n";
}
