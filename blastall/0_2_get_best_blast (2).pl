use strict;
use warnings;

my (%hash,%hash1,);

my	$in1_in = "length_of_query_CDS.txt";
open  my $in1, '<', $in1_in or die "Fail open $in1_in file\n";
while(my $line=<$in1>)
{
	chomp $line;
	my @infor=split/\s+/,$line;
	$hash1{$infor[0]}=$infor[1];
}
close  $in1;

# 处理结果
my	$in_in = "blast_9311_CDS_result.txt";
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

my	$out1_out = "blast_not_in_CDS.txt";
open  my $out1, '>', $out1_out or die  "failed open$!\n";

foreach my $key (sort keys %hash)
{
	# 挑选相似度80%以上的
	my @infor=split/\s+/,$hash{$key}[2];
	my $coverage=($infor[7]-$infor[6]+1)/$hash1{$infor[0]};
	if ($infor[2]>80 and $coverage>=0.7)
	{
		print $out "$hash{$key}[2] $hash1{$infor[0]} $coverage\n";
	}
	else
	{
		print $out1 "$hash{$key}[2] $hash1{$infor[0]} $coverage\n";
	}
}
close  $out;
close  $out1;
