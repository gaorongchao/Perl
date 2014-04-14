use strict;
use warnings;
use utf8;
use File::Basename;
use Data::Dumper;

my	$out_out = "result_large.txt";
open  my $out, '>', $out_out or die  "Fail open $out_out\n";
my	$in_in = "D-large.in";
open  my $in, '<', $in_in or die "Fail open $in_in file\n";
<$in>;
my $cout=0;
while(my $line=<$in>)
{
	chomp $line;
	$cout++;
	chomp(my $first_line=<$in>);
	my @first=sort(split/\s+/,$first_line);
	chomp(my $second_line=<$in>);
	my @second=sort(split/\s+/,$second_line);
	my $cout1=0;
	my @third=@first;
	my @four=@second;
	for my $i (0..$line-1)
	{
		#print $out "$third[0] $four[0]\n";
		if ($third[0]>$four[0])
		{
			$cout1++;
			shift @third;
			shift @four;
		}
		else
		{
			shift @third;
			pop @four;
		}
	}

	my $cout2=0;
	for my $j (0..$#second)
	{
		for my $m (0..$#second)
		{
			if ($first[$j] <$second[$m])
			{
				$cout2++;
				$second[$m]=10;
				@second=sort @second;
				pop @second;
				last;
			}
			else
			{
				next;
			}
		}
	}
	$cout2=$#first-$cout2+1;
	print $out "Case #$cout: $cout1 $cout2\n";
}
close  $in;
close  $out;
