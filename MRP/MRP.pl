use strict;
use warnings;
use Data::Dumper;

my	$out_out = "result.txt";
open  my $out, '>', $out_out or die  "Fail open $out_out\n";
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
	my @next=(split/\s+/,$line)[0,1,2,3,4];
	push @all,\@next;
}
close  $in;

foreach my $i (0..$#all)
{
	if ($all[$i][1] == 1)
	{
		my $m=$all[$i][1];
		%hash_all{$m}{}
		my @array=qw/None/;
		$hash{$all[$i][2]}[0]=\@array;
		$hash{$all[$i][2]}[2]=\@{$all[$i]};
		my $j=$i+1;
		my @son;
		foreach my $j ($j..$#all)
		{
			if ($all[$j][1] == $m+1 )
			{
				push @son,$all[$j][2];
				push @{$hash{$all[$j][2]}[0]},$all[$i][2];
			}
			elsif ($all[$j][1] > $m+1)
			{
				next;
			}
			elsif ($all[$j][1] <= $m)
			{
				last;
			}
		}
		$hash{$all[$i][2]}[1]=\@son;
	}
	else
	{
		my $m=$all[$i][1];
		$hash{$all[$i][2]}[2]=\@{$all[$i]};
		my $j=$i+1;
		my @son;
		foreach my $j ($j..$#all)
		{
			if ($all[$j][1] == $m+1 )
			{
				push @son,$all[$j][2];
				push @{$hash{$all[$j][2]}[0]},$all[$i][2];
			}
			elsif ($all[$j][1] > $m+1)
			{
				next;
			}
			elsif ($all[$j][1] <= $m)
			{
				last;
			}
		}
		$hash{$all[$i][2]}[1]=\@son;
	}
}

foreach my $key (sort keys %hash)
{
	#foreach my $key1 (@{$hash{$key}[0]})
	#{
	#print $out "$key1";
	#}
	print $out "自身\t@{$hash{$key}[2]}\n";
	print $out "父@{$hash{$key}[0]}\n";
	print $out "子\t@{$hash{$key}[1]}\n\n\n";

}

close  $out;
