use strict;
use warnings;

system "DEL result.txt";

my $seq;
my	$in1_in = (glob "*.txt")[0];
open  my $in1, '<', $in1_in or die "Fail open $in1_in file\n";
while(<$in1>)
{
	chomp;
	$seq .=$_;
}
close  $in1;
$seq=~s/\s+//g;

my @files=glob "*.seq";
foreach my $file (@files)
{
	my $line1;
	my	$out_out = "$file.fasta";
	open  my $out, '>', $out_out or die  "Fail open $out_out\n";
	my	$in_in = "$file";
	open  my $in, '<', $in_in or die "Fail open $in_in file\n";
	while(my $line=<$in>)
	{
		chomp $line;
		$line1 .=$line;
	}
	close  $in;
	$line1=~s/\s+//;
	if ($file=~/^F/)
	{
		my $line2=reverse $line1;
		$line2=~tr/ATGC/TACG/;
		print $out ">$file.reverse\n$line2\n";
		print $out ">seq\n$seq\n";
	}	
	else
	{
		print $out ">$file\n$line1\n";
		print $out ">seq\n$seq\n";
	}
}

my @files1=glob "*.fasta";
foreach my $file (@files1)
{
	system "clustalw2 -INFILE=$file -TYPE=DNA -ALIGN -OUTFILE=$file.temp -OUTPUT=FASTA -QUIET";
	tran_severline_to_one($file);
}

system "DEL *.fasta";
system "DEL *.temp";
system "DEL *.dnd";
sub tran_severline_to_one
{
	$/="\n>";
	my	$out_out = "result.txt";
	open  my $out, '>>', $out_out or die  "Fail open $out_out\n";

	my	$in_in = "$_[0].temp";
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
