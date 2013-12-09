use strict;
use warnings;

my (%hash,);
my	$in_in = "Blast_result.txt.fas";
open  my $in, '<', $in_in or die "cannot open\n";
while(<$in>)
{
	chomp;
	my $line=$_;
	my @infor=split/\s+/,$line;
	if (exists $hash{$infor[0]} and $hash{$infor[0]}[1]<$infor[11])
	{
		$hash{$infor[0]}[0]=$infor[1];
		$hash{$infor[0]}[1]=$infor[11];
		$hash{$infor[0]}[2]=$line;
	}
	elsif(exists $hash{$infor[0]} and $hash{$infor[0]}[1]>$infor[11])
	{
		next;
	}
	else
	{
		$hash{$infor[0]}[0]=$infor[1];
		$hash{$infor[0]}[1]=$infor[11];
		$hash{$infor[0]}[2]=$line;
	}
}
close  $in;

my	$out_out = "Osg_Loc.txt";
open  my $out, '>', $out_out or die  "failed open$!\n";

my	$out1_out = "Loc.txt";
open  my $out1, '>', $out1_out or die  "failed open$!\n";

foreach my $key (sort keys %hash)
{
	print $out "$hash{$key}[2]\n";
	print $out1 "$hash{$key}[0]\n";
}
close  $out;
close  $out1;
