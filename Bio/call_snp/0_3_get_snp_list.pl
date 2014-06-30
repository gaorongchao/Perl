use strict;
use warnings;
use utf8;
use File::Basename;
use Data::Dumper;

my	$out_out = "snp_position.list";
open  my $out, '>', $out_out or die  "Fail open $out_out\n";
my	$in_in = "Samples.IRGSP.stampy.gatk.s107.flt.snp";
open  my $in, '<', $in_in or die "Fail open $in_in file\n";
while(my $line=<$in>)
{
	chomp $line;
	next if $line=~m/^#/;
	my @infor=(split/\s+/,$line)[0,1];
	print $out "$infor[0]:$infor[1]-$infor[1]\n";
}
close  $in;
close  $out;
