# This is a perl Program to deal with gff in Bio

use strict;
use warnings;

# gff 的输入文件
my	$in_in = "in.txt";
open  my $in, '<', $in_in or die "cannot open\n";
while(<$in>)
{
	chomp;
	next if /^#/;
	my @infor=split/\s+/,$_;
}
close  $in;

