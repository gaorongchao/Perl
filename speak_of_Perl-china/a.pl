use strict;
use warnings;
use 5.16.3;
use utf8;

my (%hash,%hash1,);
my	$out_out = "result1.txt";
open  my $out, '>', $out_out or die  "Fail open $out_out\n";

#my	$in_in = "PerlChina.txt";
my	$in_in = "shumeng.txt";
open  my $in, '<', $in_in or die "Fail open $in_in file\n";
while(my $line=<$in>)
{
	chomp $line;
	if ($line=~m/:\d+\s(.+)\((\d{6,})\)$/)
	{
		$hash{$2}[0]++;
		$hash{$2}[1]=$1;
	}
	else
	{
		next;
	}
}
close  $in;

foreach my $key1 (sort keys %hash)
{
	#print $out "$key1\t$hash{$key1}[1]\t$hash{$key1}[0]\n";
	$hash1{$hash{$key1}[0]}{$key1}=$hash{$key1}[1];
}

foreach my $key1 (sort {$b<=>$a} keys %hash1)
{
	foreach my $key2 (sort keys %{$hash1{$key1}})
	{
		print $out "$key2\t$hash1{$key1}{$key2}\t$key1\n";
	}
}
close  $out;
