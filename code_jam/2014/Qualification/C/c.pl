use strict;
use warnings;
use utf8;
use File::Basename;
use Data::Dumper;


my	$out2_out = "Inpossible.txt";
open  my $out2, '>', $out2_out or die  "Fail open $out2_out\n";
my	$out_out = "result_small.txt";
open  my $out, '>', $out_out or die  "Fail open $out_out\n";
my	$in_in = "C-small-attempt8.in";
#my	$in_in = "a.txt";
open  my $in, '<', $in_in or die "Fail open $in_in file\n";
<$in>;
my $cout=0;

while(my $line=<$in>)
{
	$cout++;
	chomp $line;
	my ($r,$c,$m)=split/\s+/,$line;
	if ($r==1 or $c==1)
	{
		print $out "Case #$cout:\n";
		#print $out "$r $c $m\n";
		if ($r==1) # 一行
		{
			for (1..$m)
			{
				print $out "*";
			}
			for ($m+1..$c-1)
			{
				print $out ".";
			}
			print $out "c\n";
		}
		elsif ($c==1) # 一行
		{
			for (1..$m)
			{
				print $out "*\n";
			}
			for ($m+1..$r-1)
			{
				print $out ".\n";
			}
			print $out "c\n";
		}
	}
	else
	{
		print $out "Case #$cout:\n";
		#print $out "$r $c $m\n";
		my $first_test=test1($r,$c,$m);
		my $second_test=test2($r,$c,$m);
		if ($first_test eq "FALSE" and $second_test eq "FALSE")
		{
			#不论怎么放，不管横竖，都没有超过两行或者两列的，也就是比较满的时候。
			if ($r*$c-$m==1)
			{
				my @all;
				for (1..$m)
				{
					push @all,"*";
				} 
				push @all,"c";
				for (1..$r)
				{
					for (1..$c)
					{
						my $fuhao=shift @all;
						print $out "$fuhao";
					}
					print $out "\n";
				}
			}
			elsif (sqrt($r*$c-$m)==int(sqrt($r*$c-$m)))
			{
				# 是一个正方形的，先输出c然后正方形，剩下的都是雷
				#print $out "$r $c $m\n";
				my $sqrt=int(sqrt($r*$c-$m));
				print $out "c";
				for (2..$sqrt)
				{
					print $out ".";
				}
				for ($sqrt+1..$c)
				{
					print $out "*";
				}
				print $out "\n";
				for (2..$sqrt)
				{
					for (1..$sqrt)
					{
						print $out ".";
					}
					for ($sqrt+1..$c)
					{
						print $out "*";
					}
					print $out "\n";
				}
				for ($sqrt+1..$r)
				{
					for (1..$c)
					{
						print $out "*";
					}
					print $out "\n";
				}
			}
			elsif ($r*$c-$m>3 and ($r*$c-$m)%2==0)
			{
				my $fill_lie=($r*$c-$m)/2;
				for (1..$r-2)
				{
					for (1..$c)
					{
						print $out "*";
					}
					print $out "\n";
				}
				
				for (1..$fill_lie)
				{
					print $out ".";
				}
				for ($fill_lie+1..$c)
				{
					print $out "*";
				}
				print $out "\n";
				print $out "c";
				for (2..$fill_lie)
				{
					print $out ".";
				}
				for ($fill_lie+1..$c)
				{
					print $out "*";
				}
				print $out "\n";
			}
			elsif (($r-2)*($c-2)>$m)
			{
				my $before_line=int($m/($c-2));
				for (1..$before_line)
				{
					for (1..$c-2)
					{
						print $out "*";
					}
					for ($c-1..$c)
					{
						print $out ".";
					}
					print $out "\n";
				}
				my $remain_mines=$m - $before_line*($c-2);
				for (1..$remain_mines)
				{
					print $out "*";
				}
				for ($remain_mines+1..$c)
				{
					print $out ".";
				}
				print $out "\n";
				for ($before_line+2..$r-1)
				{
					for (1..$c)
					{
						print $out ".";
					}
					print $out "\n";
				}
				for (1..$c-1)
				{
					print $out "."
				}
				print $out "c\n";
			}
			elsif ($r*$c-$m==11 and $r>=5 and $c>=5)
			{
				print $out "c..";
				for (4..$c)
				{
					print $out "*";
				}
				print $out "\n";
				for (2..3)
				{
					for (1..3)
					{
						print $out ".";
					}
					for (4..$c)
					{
						print $out "*";
					}
					print $out "\n";
				}
				print $out "..";
				for (3..$c)
				{
					print $out "*";
				}
				print $out "\n";
				for (5..$r)
				{
					for (1..$c)
					{
						print $out "*";
					}
					print $out "\n";
				}
			}
			else
			{
				if (($r ==2 or $c==2) and $m%2!=0)
				{
				}
				elsif ($r*$c-$m==2)
				{
				}
				elsif (($r==3 and $c==5 and $m==8) or ($r==5 and $c==3 and $m==8))
				{
				}
				elsif (($r==4 and $c==5 and ($m==17 or $m==13)) or ($r==5 and $c==4 and ($m==17 or $m==13)))
				{
				}
				elsif ($r*$c-$m==5 or $r*$c-$m==7 or $r*$c-$m==3)
				{
				}
				else
				{
					print $out2 "$r $c $m\n";
				}
				print $out "Impossible\n";
			}
		}
		elsif ($first_test eq "TRUE")
		{
			my @all;
			for (1..$m)
			{
				push @all,"*";
			}
			for ($m+1..$r*$c-1)
			{
				push @all,".";
			}
			push @all,"c";

			for (1..$r)
			{
				for (1..$c)
				{
					my $fuhao=shift @all;
					print $out "$fuhao";
				}
				print $out "\n";
			}
		}
		elsif ($second_test eq "TRUE")
		{

			my	$out1_out = "test";
			open  my $out1, '>', $out1_out or die  "Fail open $out1_out\n";
			my @all;
			for (1..$m)
			{
				push @all,"*";
			}
			for ($m+1..$r*$c-1)
			{
				push @all,".";
			}
			push @all,"c";

			for (1..$c)
			{
				for (1..$r)
				{
					my $fuhao=shift @all;
					print $out1 "$fuhao";
				}
				print $out1 "\n";
			}
			close  $out1;

			my @array;
			my	$in2_in = "test";
			open  my $in2, '<', $in2_in or die "Fail open $in2_in file\n";
			while(my $line=<$in2>)
			{
				chomp $line;
				my @infor=split//,$line;
				for (0..$#infor)
				{
					$array[$_] .= $infor[$_];
				}
			}
			close  $in2;
			foreach my $array (@array)
			{
				print $out "$array\n";
			}
		}
	}
}
close  $in;
close  $out;
close  $out2;

sub test1{
	# $r是多少行，$c是多少列
	my ($r,$c,$m)=@_;
	# 横向填充地雷
	my $first_remain=(int($m/$c)+1)*$c-$m;
	my $second_remain=$r-(int($m/$c)+1);
	if ($first_remain>=2 and $second_remain>=2)
	{
		return "TRUE";
	}
	else
	{
		return "FALSE";
	}
}

sub test2{
	my ($r,$c,$m)=@_;
	# 纵向填充地雷
	my $first_remain=(int($m/$r)+1)*$r-$m;
	my $second_remain=$c-(int($m/$r)+1);
	if ($first_remain>=2 and $second_remain>=2)
	{
		return "TRUE";
	}
	else
	{
		return "FALSE";
	}
}
