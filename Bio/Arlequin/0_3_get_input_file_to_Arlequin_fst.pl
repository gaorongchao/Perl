use strict;
use warnings;
use utf8;
use File::Basename;
use Data::Dumper;

my (%hash,);
%hash=("30"=>9,"60"=>10,"70"=>13,"80"=>8);

my @files = glob "/home/grc/Data/TZH/all_sample_2014_03_18/0_2_Four_Group/Region_Tree/Less_less_region/*.fasta";

$/="\n>";
my @groups=qw/30 60 70 80/;
foreach my $file (@files)
{
	my $basename=basename($file);
	my	$out_out = "$basename.arp";
	open  my $out, '>', $out_out or die  "Fail open $out_out\n";
	
	my $output=output($file);
	print $out "$output\n";

	foreach my $group (@groups)
	{
		my @all_sample;

		print $out "SampleName=\"$group\"\nSampleSize=$hash{$group}\nSampleData=\{\n";

		my	$in_in = "$file";
		open  my $in, '<', $in_in or die "Fail open $in_in file\n";
		while(my $line=<$in>)
		{
			chomp $line;
			my @lines=split/\n/,$line;
			$lines[0]=~m/>?(.+)_(\d+)/;
			my $sample=$1;
			my $niandai=$2;
			my $judge=print_or_not($group,$niandai);
			if ($judge eq "TRUE")
			{
				print $out "$sample 1 $lines[1]\n";
			}
			else
			{
				next;
			}
		}
		print $out "}\n";
		close  $in;
	}
	print $out "[[Stucture]]\nStructureName=\"$file\"\nNbGroups=4\nGroup={\n";
	print $out "\"30\"\n\"40\"\n\"50\"\n\"60\"\n}";
	close  $out;
}
$/="\n";


#Sub
#------------------------------------------------
sub output 
{
	my $outputline="[Profile]\n\tTitle=\"$_[0]\"\n\tNbsamples=4\n
	\tDataType=DNA\nGenotypicData=0\nLocusSeparator=NONE\nMissingData=\"?\"\n
	[Data]\n[[Samples]]\n";
}


sub print_or_not
{
	if ($_[0]==30 and ($_[1]==30 or $_[1] ==40 or $_[1]==50))
	{
		return "TRUE";
	}
	elsif ($_[0] == 60 and $_[1] == 60)
	{
		return "TRUE";
	}
	elsif ($_[0] ==70 and $_[1] == 70)
	{
		return "TRUE";
	}
	elsif ($_[0] == 80 and ($_[1] == 80 or $_[1] ==90))
	{
		return "TRUE";
	}
	else
	{
		return "FALSE";
	}

}
