=cut
题目31：考察英国货币面值的组合问题
在英国，货币是由英镑￡，便士p构成的。一共有八种钱币在流通：

1p, 2p, 5p, 10p, 20p, 50p, ￡1 (100p) 和 ￡2 (200p).
要构造￡2可以用如下方法：

1×￡1 + 1×50p + 2×20p + 1×5p + 1×2p + 3×1p
允许使用任意数目的钱币，一共有多少种构造￡2的方法？

=cut

use strict;
use warnings;
use utf8;
use File::Basename;
use Data::Dumper;

#my @all_coin=qw/1 2 5 10 20 50 100 200/; # 所有货币的种类
my @all_coin=qw/200 100 50 20 10 5 2 1/; # 所有货币的种类
my $cout=0;

sub total
{
	my $deep=shift;
	my $left=shift;
	if ($deep==7 or $left==0)
	{
		$cout++;
		print "$cout\ncout\n";
		return;
	}
	else
	{
		for(my $i=0;$i<=$left/$all_coin[$deep];$i++)
		{
			print "$deep $left $i a\n";
			total($deep+1,$left-$i*$all_coin[$deep]);
			print "$deep $left $i b\n";
		}
	}
}

total(0,2);
print "$cout\n";
