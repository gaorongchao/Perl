use strict;
use warnings;
use utf8;
use File::Basename;
use Data::Dumper;


my	$out_out = "all_arp_file.arb";
open  my $out, '>', $out_out or die  "Fail open $out_out\n";
my @file = glob "*.arp";
foreach my $file (@file)
{
	print $out "$file\n";
}
close  $out;
