use strict;
use warnings;
use utf8;
use File::Basename;
use Data::Dumper;

my	$out_out = "result.txt";
open  my $out, '>', $out_out or die  "Fail open $out_out\n";
my (%hash1,%hash2,$case_cout);
my	$in_in = "A-small-attempt4.in";
#my	$in_in = "a.txt";
open  my $in, '<', $in_in or die "Fail open $in_in file\n";
<$in>;
while(my $line=<$in>)
{
	chomp $line;
	$case_cout++;
	my $first_row=$line;
	my @first;
	for my $i (1..4)
	{
		chomp (my $need=<$in>);
		push @first,$need;
	}
	my $first_chose=$first[$first_row-1];
	%hash1=map {$_,1} (split/\s+/,$first_chose);


	my @second;
	chomp(my $second_row=<$in>);
	for my $j (1..4)
	{
		chomp(my $need=<$in>);
		push @second,$need;
	}
	my $second_chose=$second[$second_row-1];
	%hash2=map {$_,1} (split/\s+/,$second_chose);


	my $cout=0;
	my @result;
	foreach my $key (keys %hash1)
	{
		if (exists $hash2{$key})
		{
			push @result,$key;
			$cout++;
		}
	}
	if ($cout==1)
	{
		print $out "Case #$case_cout: $result[0]\n";
	}
	elsif ($cout==0)
	{
		print $out "Case #$case_cout: Volunteer cheated!\n";
	}
	elsif ($cout>1)
	{
		print $out "Case #$case_cout: Bad magician!\n";
	}
	else
	{
		next;
	}
	undef %hash2;
	undef %hash1;
}
close  $in;
close  $out;
