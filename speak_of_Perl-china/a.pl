use strict;
use warnings;
use 5.16.3;
use utf8;
use Data::Dumper;

my (%hash,%hash1,@name,);
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

@name=keys %hash;

# 第一种方法，只需要得出排序后的QQ号码即可
my @names_after_sort=
map $_->[0],
sort {$b->[1] <=> $a->[1]}
map {[$_,$hash{$_}[0]]} @name;

foreach my $key (@names_after_sort)
{
	print $out "$key\t$hash{$key}[0]\t$hash{$key}[1]\n";
}

=cut 
# 第二种方法，把所有元素赋予排序后的数组，和hash再也无关
my @names_after_sort=
sort {$b->[1] <=> $a->[1]}
map {[$_,$hash{$_}[0],$hash{$_}[1]]} @name;

foreach my $key (0..$#names_after_sort)
{
	print $out "$names_after_sort[$key]->[0]\t$names_after_sort[$key]->[1]\t$names_after_sort[$key]->[2]\n";
}

# 第三种方法
# 下面是一种变化的策略来排序，建立一个新的hash来排序
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
