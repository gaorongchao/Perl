use strict;
use warnings;
use utf8;
use File::Basename;
use Data::Dumper;


my	$out_out = "1_Samples.IRGSP.stampy.gatk.s107.flt.snp";
open  my $out, '>', $out_out or die  "Fail open $out_out\n";
my	$in_in = "1_sample.vcf";
#my	$in_in = "a.vcf";
open  my $in, '<', $in_in or die "Fail open $in_in file\n";
while(my $line=<$in>)
{
	chomp $line;
	next if $line=~m/^##/;
	if ($line=~m/^#CHROM/)
	{
		my @infor=split/\s+/,$line;
		print $out "@infor[0,1,3,4,9..$#infor]\n";
	}
	else
	{
		my @infor=split/\s+/,$line;
		my $length_ref=length($infor[3]);
		my @alt=split/,/,$infor[4];
		my $flag=alt(@alt);
		# select quality
		if ($infor[5] > 100 and $length_ref==1 and $flag eq "TRUE")
		{
			print $out "@infor[0,1,3,4] ";
			for my $sample (@infor[9..$#infor])
			{
				my @one_sample=split/[\/\:]/,$sample;
				if ($one_sample[0] eq $one_sample[1] and $one_sample[0] eq ".")
				{
					print $out "N ";
				}
				elsif ($one_sample[0] eq $one_sample[1] and $one_sample[0] eq "0")
				{
					print $out "$infor[3] ";
				}
				elsif ($one_sample[0] eq $one_sample[1] and $one_sample[0] eq "1")
				{
					print $out "$alt[0] ";
				}
				elsif ($one_sample[0] eq $one_sample[1] and $one_sample[0] eq "2")
				{
					print $out "$alt[1] ";
				}
				elsif ($one_sample[0] eq $one_sample[1] and $one_sample[0] eq "3")
				{
					print $out "$alt[2] ";
				}
				else
				{
					print $out "Z ";
				}
			}
			print $out "\n";
		}
		else
		{
			next;
		}
	}
}
close  $in;
close  $out;

sub alt
{
	my $flag="TRUE";
	my @alt=@_;
	foreach my $alt (@alt)
	{
		if (length($alt) > 1)
		{
			$flag="FALSE";
		}
		else
		{
			next;
		}
	}
	return $flag;
}
