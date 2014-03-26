use strict;
use warnings;
use utf8;

=cut
转换规则的思考


=cut

my $file="1_The_Basics.html";


my	$out_out = "bbcode_1_The_Basics.html";
open  my $out, '>', $out_out or die  "Fail open $out_out\n";

my	$in_in = "$file";
open  my $in, '<', $in_in or die "Fail open $in_in file\n";
while(my $line=<$in>)
{
	chomp $line;
	if ($line=~m/<title>/)
	{
		$gg
	}
	print $out "$bbcode\n";
}
close  $in;
close  $out;
