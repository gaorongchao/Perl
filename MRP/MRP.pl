use strict;
use warnings;
use utf8;
use Data::Dumper;

my (%hash,@all);
my $i=0;
# 先把父子关系理清楚，每一个产品都有3个属性，父和子，以及系数
my	$in_in = "a.txt";
open  my $in, '<', $in_in or die "Fail open $in_in file\n";
while(my $line=<$in>)
{
	chomp $line;
	next if $line=~/^#/;
	my $i++;
	my @next=(split/\s+/,$line)[0,1,2,4];
	push @all,\@next;
	for my $j (0..3)
	{
		$all[$i][$j]=$next[$j];
	}
}
close  $in;

for my $m (0..$#all)
{
	for my $n (0..$#{$all[$m]})
	{
		print "$all[$m][$n]\n";
	}
	print "\n\n";
}
