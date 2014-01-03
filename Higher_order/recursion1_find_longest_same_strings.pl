use strict;
use warnings;

my $m=0;
my @array;
my	$in_in = "a.txt";
open  my $in, '<', $in_in or die "Fail open $in_in file\n";
while(my $line=<$in>)
{
	chomp $line;
	$array[$m]=$line;
	$m++;
}
close  $in;

for my $i (0..$#array-1)
{
	print $i."\n";
	my $j=$i+1;
	my $str1=$array[$i];
	my $str2=$array[$j];
	my $len=length($str1);
	my $max=$len;
	my $min=0;
	my $point=int($max/2);
	my $result=match($point,$len,$str1,$str2,$max,$min);
	print $result."\n";
}


sub match 
{
	my $point=$_[0];
	my $len=$_[1];
	my $str1=$_[2];
	my $str2=$_[3];
	my $max=$_[4];
	my $min=$_[5];
	my $end=$len-$point;
	for my $begin (0..$end)
	{
		my $lcs=substr($str1,$begin,$point);
		if ($str2 =~ /$lcs/)
		{
			my $aver=$max-$min;
			if ($aver<=1)
			{
				#print $lcs."\n";
				#exit;
				return $lcs;
			}
			else
			{
				$min=$point;
				$point=$min+int(($max-$min)/2);
				&match($point,$len,$str1,$str2,$max,$min);
			}
		}
	}
	$max=$point;
	$point=$max-int(($max-$min+1)/2);
	&match($point,$len,$str1,$str2,$max,$min);
}
