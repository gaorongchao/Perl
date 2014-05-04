use strict;
use warnings;
use utf8;
use File::Basename;
use Data::Dumper;


my	$out_out = "result.txt";
open  my $out, '>', $out_out or die  "Fail open $out_out\n";

my (%hash,);
my @files = glob "*.nwk";
foreach my $file (@files)
{
	$file=~m/(.+).csv.fasta.nwk/;
	my $name=$1;
	my	$in_in = "$file";
	open  my $in, '<', $in_in or die "Fail open $in_in file\n";
	while(my $line=<$in>)
	{
		chomp $line;
		# 查看有多少个括号，也就是有多少个样品
		my @cout=($line=~m/\)/g);
		for (0..$#cout)
		{
			# 从后往前匹配,一次只算一个物种的长度
			if($line=~m/((\([\w\d:),.-]+?\))[\w\d:),.-]+?\));/)
			{
				# 计算括号的距离之和
				my $distance=distance($1);

				my $pipei=$2;
				# 如果是(,)这种情况，没有样品的时候处理
				if (length($pipei)<=3)
				{
					$line=~s/\(\,?$pipei\)\d\.\d+:\d\.\d+//g;
					#print $out "$line\n\n\n";
					#print $out "\n";
				}
				else
				{
					my $instead=$pipei;
					$instead=~s/\(,/(/;
					$instead=~s/,\)/)/;
					#print $out "$instead\n\n";
					my  @infor=split/,/,$instead;
					for (0..$#infor)
					{
						my ($key,$value)=($infor[$_]=~m/([\w\d\.]+):([\d\.-]+)/g);
						$hash{$key}{$name}=$value+$distance;
					}
					# 对计算过的删除
					$line=~s/\(\,?$pipei\)\d\.\d+:\d\.\d+//g;
					#print $out "$line\n";
				}
			}
			else
			{
				$line=~m/\(\,?([\w\d\.,:]+)\);/;
				my $pipei=$1;
				#print $out "$pipei\n";
				my $instead=$pipei;
				$instead=~s/\(,/(/;
				$instead=~s/,\)/)/;
				#print $out "$instead\n\n";
				my  @infor=split/,/,$instead;
				for (0..$#infor)
				{
					my ($key,$value)=($infor[$_]=~m/([\w\d\.]+):([\d\.-]+)/g);
					$hash{$key}{$name}=$value;
				}
				$line=~s/\(\,?$pipei\);//g;
				#print $out "$line\n";
			}
		}
	}
	close  $in;
}

print $out "";
foreach my $key1 (sort keys %{$hash{"9311..height"}})
{
	print $out "$key1 ";
}
print $out "\n";
foreach my $key1 (sort keys %hash)
{
	print $out "$key1 ";
	foreach my $key2 (sort keys %{$hash{$key1}})
	{
		print $out "$hash{$key1}{$key2} ";
	}
	print $out "\n";
}

close  $out;

sub distance
{
	my $all = $_[0];
	#print $out "$all\n";
	my @alls = ($all=~m/\)\d\.\d+:(\d.\d+)/g);
	my $distance=0;
	foreach my $alls (@alls)
	{
		$distance += $alls;
	}
	return $distance;
}
