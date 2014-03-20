use strict;
use warnings;
use utf8;

my $cout=0;

my	$out_out = "A-small-practice.out";
#my	$out_out = "A-large-practice.out";
open  my $out, '>', $out_out or die  "Fail open $out_out\n";
my	$in_in = "A-small-practice.in";
#my	$in_in = "A-large-practice.in";
open  my $in, '<', $in_in or die "Fail open $in_in file\n";
<$in>;
while(my $line=<$in>)
{
	$cout++;
	chomp $line;
	my $first=$line;
	my $second=<$in>;
	my $third=<$in>;
	my @infor=split/\s+/,$third;
	foreach my $i (0..$#infor)
	{
		my $m=$i+1;
		foreach my $j ($m..$#infor)
		{
			my $value=$infor[$i]+$infor[$j];
			if ($value  == $first)
			{
				my $out_1=$i+1;
				my $out_2=$j+1;
				print $out "Case #$cout: $out_1 $out_2\n";
				last;
			}
		}
	}
}
close  $in;
close  $out;
