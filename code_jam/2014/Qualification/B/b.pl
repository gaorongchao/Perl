use strict;
use warnings;
use utf8;
use File::Basename;
use Data::Dumper;


my	$out_out = "result_Large.txt";
open  my $out, '>', $out_out or die  "Fail open $out_out\n";
my	$in_in = "B-large.in";
open  my $in, '<', $in_in or die "Fail open $in_in file\n";
<$in>;
my $cout=0;
while(my $line=<$in>)
{
	chomp $line;
	$cout++;
	my ($c,$f,$x)=split/\s+/,$line;
	my $time=test($c,$f,$x);
	print $out "Case #$cout: $time\n";
}
close  $in;

sub test {
	my ($c,$f,$x)=@_;
	my $total_time=0;
	for my $i (0..$x)
	{
		my $not_buy_time=$x/(2+$f*$i);
		my $buy_time=$c/(2+$f*$i)+$x/(2+$f*($i+1));
		if ($not_buy_time<$buy_time)
		{
			$total_time +=$not_buy_time;
			return $total_time;
		}
		else
		{
			$total_time +=$c/(2+$f*$i);
		}
	}
}
close  $out;
