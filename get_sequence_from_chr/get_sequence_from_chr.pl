use strict;
use warnings;

my @array;
$/="\n>";
my	$in_in = "2.txt";
open  my $in, '<', $in_in or die "cannot open\n";
while(<$in>)
{
	chomp;
	my @infor=split/\s+/,$_;
	$infor[0]=~/>?(.+)/;
	my $chr=$1;
	my $cout=0;
	for (my $line=1;$line<=$#infor;$line++)
	{
		my @line_sequence=split//,$infor[$line];
		for (my $j=0;$j<=$#line_sequence;$j++)
		{
			$cout++;
			$array[$chr][$cout]=$line_sequence[$j];
		}
	}
}
close  $in;
$/="\n";

my	$out_out = "mRNA.txt";
open  my $out, '>', $out_out or die  "failed open$!\n";

my	$out2_out = "CDS.txt";
open  my $out2, '>', $out2_out or die  "failed open$!\n";

my	$in1_in = "1.txt";
open  my $in1, '<', $in1_in or die "cannot open\n";
while(<$in1>)
{
	chomp;
	my @infor=split/\s+/,$_;
	if ($infor[2] eq "mRNA")
	{
		$infor[8]=~/ID=([\w\d]+)/;
		print $out ">$1\n";
		for (my $o=$infor[3];$o<=$infor[4];$o++)
		{
			print $out "$array[$infor[0]][$o]";
		}
		print $out "\n";
	}
	elsif($infor[2] eq "CDS")
	{
		$infor[8]=~/Parent=([\w\d]+);/;
		print $out2 ">$1\n";
		for (my $o=$infor[3];$o<=$infor[4];$o++)
		{
			print $out2 "$array[$infor[0]][$o]";
		}
		print $out2 "\n";
	}
	else
	{
		next;
	}
}
close  $in1;
close  $out;
close  $out2;
