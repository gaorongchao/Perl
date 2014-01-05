use strict;
use warnings;
use Data::Dumper;

my	$out_out = "result.txt";
open  my $out, '>', $out_out or die  "Fail open $out_out\n";
my (%hash,@all,%hash_all,);
my $i=0;
# 先把父子关系理清楚，每一个产品都有3个属性，父和子，以及系数
my	$in_in = "need.txt";
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
		$hash_all{$m}{$all[$i][2]}[0]=0;
		# hash{}{}[0] 是father
		# hash{}{}[1] 是son
		# hash{}{}[2] 是本身
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
		$hash_all{$m}{$all[$i][2]}[0]=0;
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
	#print $out "自身\t@{$hash{$key}[2]}\n";
	#print $out "父\t@{$hash{$key}[0]}\n";
	#print $out "子\t@{$hash{$key}[1]}\n\n\n";
}

my	$in1_in = "we_have.txt";
open  my $in1, '<', $in1_in or die "Fail open $in1_in file\n";
while(my $line=<$in1>)
{
	chomp $line;
	my ($name,$num)=(split/\s+/,$line)[0,2];
	my $ceng=$hash{$name}->[2]->[1];
	$hash_all{$ceng}{$name}[0]=$num;
}
close  $in1;

foreach my $key1 (sort {$b<=>$a} keys %hash_all)
{
	my $son_ceng=$key1+1;
	foreach my $key2 (keys $hash_all{$key1})
	{
		my @father=@{$hash{$key2}->[0]};
		my @son   =@{$hash{$key2}->[1]};
		my $xishu=$hash{$key2}->[2]->[4];
		#print $out "$xishu\n";
		if ($#father==0)
		{
			# $hash_all{}{}[0] 是原始数量
			# $hash_all{}{}[1] 是换算数量
			# $hash_all{}{}[2] 是加工更高级零件后，剩余数量
			$hash_all{$key1}{$key2}[1]=$hash_all{$key1}{$key2}[0]/$xishu;
			#print $out "$hash_all{$key1}{$key2}[1]\n";
			if ($#son>=0)
			{
				my $min=$hash_all{$son_ceng}{$son[0]}[1];
				foreach my $key3 (@son)
				{
					if ($hash_all{$son_ceng}{$key3}[1]<$min)
					{
						$min=$hash_all{$son_ceng}{$key3}[1];
					}
					else
					{
						next;
					}
				}
				$hash_all{$key1}{$key2}[0]+=$min;
				for my $key4 (@son)
				{
					$hash_all{$son_ceng}{$key4}[2]=$hash_all{$son_ceng}{$key4}[1]-$min*$hash{$key4}->[2]->[4];
				}
			}
			else
			{
				next;
			}
		}
		else
		{
		}
		#print $out "$key1 $key2 $hash_all{$key1}{$key2}[0]\n\n\n\n";
	}
}

foreach my $key1 (sort {$b<=>$a} keys %hash_all)
{
	foreach my $key2 (keys $hash_all{$key1})
	{
		print $out "$hash_all{$key1}{$key2}[2]";
	}
}
close  $out;
