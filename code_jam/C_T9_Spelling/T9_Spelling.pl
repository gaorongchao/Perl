use strict;
use warnings;
use utf8;
use Data::Dumper;
my %hash;
my @cha= map { chr } 97..122;
#print Dumper(\@cha);

=cut
foreach my $chr (@cha)
{
	$hash{$chr}[0]=int((ord($chr)-96+5)/3);
	$hash{$chr}[1]=ord($chr)-int(ord($chr)/3)*3;
	if ($hash{$chr}[1] == 0) {$hash{$chr}[1]=3;}
}
=cut
$hash{a}[0]=2;$hash{a}[1]=1;
$hash{b}[0]=2;$hash{b}[1]=2;
$hash{c}[0]=2;$hash{c}[1]=3;
$hash{d}[0]=3;$hash{d}[1]=1;
$hash{e}[0]=3;$hash{e}[1]=2;
$hash{f}[0]=3;$hash{f}[1]=3;
$hash{g}[0]=4;$hash{g}[1]=1;
$hash{h}[0]=4;$hash{h}[1]=2;
$hash{i}[0]=4;$hash{i}[1]=3;
$hash{j}[0]=5;$hash{j}[1]=1;
$hash{k}[0]=5;$hash{k}[1]=2;
$hash{l}[0]=5;$hash{l}[1]=3;
$hash{m}[0]=6;$hash{m}[1]=1;
$hash{n}[0]=6;$hash{n}[1]=2;
$hash{o}[0]=6;$hash{o}[1]=3;
$hash{p}[0]=7;$hash{p}[1]=1;
$hash{q}[0]=7;$hash{q}[1]=2;
$hash{r}[0]=7;$hash{r}[1]=3;
$hash{s}[0]=7;$hash{s}[1]=4;
$hash{t}[0]=8;$hash{t}[1]=1;
$hash{u}[0]=8;$hash{u}[1]=2;
$hash{v}[0]=8;$hash{v}[1]=3;
$hash{w}[0]=9;$hash{w}[1]=1;
$hash{x}[0]=9;$hash{x}[1]=2;
$hash{y}[0]=9;$hash{y}[1]=3;
$hash{z}[0]=9;$hash{z}[1]=4;
$hash{" "}[0]=0;$hash{" "}[1]=1;

=cut
foreach my $key (sort keys %hash)
{
	print "$key $hash{$key}[0] $hash{$key}[1]\n";
}
=cut


#my	$out_out = "C-small-practice.out";
my	$out_out = "C-large-practice.out";
open  my $out, '>', $out_out or die  "Fail open $out_out\n";
my	$in_in = "C-large-practice.in";
#my	$in_in = "C-small-practice.in";
open  my $in, '<', $in_in or die "Fail open $in_in file\n";
<$in>;
my $cout=0;
while(my $line=<$in>)
{
	chomp $line;
	$cout++;
	print $out "Case #$cout: ";
	my @infor=split//,$line;
	if ($#infor<=0)
	{
		my $output="$hash{$infor[0]}[0]" x $hash{$infor[0]}[1];
		print $out "$output";
	}
	else
	{
		foreach my $i (1..$#infor)
		{
			if ($hash{$infor[$i]}[0] eq $hash{$infor[$i-1]}[0])
			{
				my $output="$hash{$infor[$i-1]}[0]" x $hash{$infor[$i-1]}[1];
				print $out "$output ";
			}
			else
			{
				my $output="$hash{$infor[$i-1]}[0]" x $hash{$infor[$i-1]}[1];
				print $out "$output";
			}
		}
		my $output="$hash{$infor[-1]}[0]" x $hash{$infor[-1]}[1];
		print $out "$output";
	}
	print $out "\n";
}
close  $in;
close  $out;
