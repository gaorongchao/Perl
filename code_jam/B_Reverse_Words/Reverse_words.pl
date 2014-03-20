use strict;
use warnings;
use utf8;

my $cout=0;
#my	$out_out = "B-small-practice.out";
my	$out_out = "B-large-practice.out";
open  my $out, '>', $out_out or die  "Fail open $out_out\n";
my	$in_in = "B-large-practice.in";
open  my $in, '<', $in_in or die "Fail open $in_in file\n";
<$in>;
while(my $line=<$in>)
{
	chomp $line;
	my @infor=split/\s+/,$line;
	$cout++;
	print $out "Case #$cout: ";
	for (my $i=$#infor;$i>=0;$i--)
	{
		print $out "$infor[$i] ";
	}
	print $out "\n";
}
close  $in;
close  $out;
