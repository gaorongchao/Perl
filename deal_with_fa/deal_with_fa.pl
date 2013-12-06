use strict;
use warnings;

my	$out_out = "result.txt";
open  my $out, '>', $out_out or die  "failed open$!\n";

$/="\n>";
my $cout=0;
my	$in_in = "a.fa";
open  my $in, '<', $in_in or die "cannot open\n";
while(<$in>)
{
	chomp;
	my @infor=split/\n/,$_;

	$infor[0]=~m/>?(.+)/;
	my $title=$1;

	my $length=length($infor[1])*($#infor-1)+length($infor[$#infor]);

	$cout++;

	my $GC=0;
	for my $i (1..$#infor)
	{
		my $GC_line=($infor[$i]=~tr/GC//);
		$GC=$GC+$GC_line;
	}

	my $bili=$GC/$length;
	print $out "$title $length $GC $bili\n";
}
close  $in;
print $out "line $cout\n";
close  $out;

$/="\n";
