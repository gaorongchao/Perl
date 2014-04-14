use strict;
use warnings;
use utf8;
use 5.16.3;
use File::Basename;
use Data::Dumper;


my	$out_out = "result.txt";
open  my $out, '>', $out_out or die  "Fail open $out_out\n";
my (%hash,);
# 如果存在就放在hash中
my	$in_in = "A-small-practice.in";
open  my $in, '<', $in_in or die "Fail open $in_in file\n";
<$in>;
while(my $line=<$in>)
{
	chomp $line;
	my @infor=split/\s+/,$line;
	if ($infor[1] == 0)
	{
		print $out "0";
	}
	elsif ($infor[0]>=1)
	{
		for my $i (1..$infor[0])
		{
			my $exist_line=<$in>;
			my @exists=split/\//,$exist_line;
			for my $i (0..$#infor)
			{
				my $to_hash;
				for my $j (0..$i)
				{
					$to_hash .= "/$exists[$j]";
				}
				$hash{$to_hash}=1;
			}
		}
		for my $m (1..$infor[1])
		{
			my $not_exists_line=<$in>;
		}
	}
	else
	{
		for my $m (1..$infor[1])
		{
			my $not_exists_line=<$in>;
		}
	}
	print Dumper(\%hash);
	undef %hash;
}
close  $in;
close  $out;
