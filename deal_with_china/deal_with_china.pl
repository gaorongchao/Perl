use strict;
use warnings;
use utf8;

my	$out_out = "result.txt";
open  my $out, '>encoding(utf8)', $out_out or die  "Fail open $out_out\n";
# 控制输出utf8
my	$in_in = "po1.txt";
open  my $in, '<', $in_in or die "Fail open $in_in file\n";
# 因为文本是cp936所以读入以后要进行标准的转换，进行说明，这样perl就能够正确识别
binmode ($in,":encoding(gbk)");
while(my $line=<$in>)
{
	chomp $line;
	next if $line=~/ppvn/;
	next if $line=~/Live DB/;
	next if $line=~/价格单/;
	next if $line=~/---/;
	print $out "$line\n";
}
close  $in;
close  $out;
